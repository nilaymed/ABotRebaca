#!/usr/bin/env python

from datetime import timedelta
from functools import update_wrapper
from subprocess import Popen, PIPE
from pymodules.flask import abort, current_app, Flask, jsonify, make_response, request, Response, send_from_directory
from graph_service import packet_counters, transaction_counts, procedure_completions, uplink_downlink_bandwidth
from file_service import TailProcess

import file_service
import json
import os
import transfer_service
import threading
import logging
from logging.handlers import RotatingFileHandler

WORKING_DIRECTORY = '/etc/rebaca-test-suite/actions'
BASE_URL = '/abot/api/v5/'
CURRENT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

app = Flask(__name__)


class FeatureFileRunner(threading.Thread):
    def __init__(self, params):
        super(FeatureFileRunner, self).__init__()
        self.params = params

    def run(self):
        global WORKING_DIRECTORY
        process = Popen(['sudo', './run_local', self.params],
                        stdout=PIPE, stderr=PIPE, cwd=WORKING_DIRECTORY)
        tail_thread = TailProcess()
        tail_thread.start()
        process.communicate()
        process.wait()
        tail_thread.close_process()

# allows cross domain access


def crossdomain(origin=None, methods=None, headers=None, max_age=21600, attach_to_all=True, automatic_options=True):
    if methods is not None:
        methods = ', '.join(sorted(x.upper() for x in methods))
    if headers is not None and not isinstance(headers, basestring):
        headers = ', '.join(x.upper() for x in headers)
    if not isinstance(origin, basestring):
        origin = ', '.join(origin)
    if isinstance(max_age, timedelta):
        max_age = max_age.total_seconds()

    def get_methods():
        if methods is not None:
            return methods

        options_resp = current_app.make_default_options_response()
        return options_resp.headers['allow']

    def decorator(f):
        def wrapped_function(*args, **kwargs):
            if automatic_options and request.method == 'OPTIONS':
                resp = current_app.make_default_options_response()
            else:
                resp = make_response(f(*args, **kwargs))
            if not attach_to_all and request.method != 'OPTIONS':
                return resp

            h = resp.headers

            h['Access-Control-Allow-Origin'] = origin
            h['Access-Control-Allow-Methods'] = get_methods()
            h['Access-Control-Max-Age'] = str(max_age)
            if headers is not None:
                h['Access-Control-Allow-Headers'] = headers
            return resp

        f.provide_automatic_options = False
        return update_wrapper(wrapped_function, f)
    return decorator


# 400 error handler
@app.errorhandler(400)
def bad_request(error):
    return make_response(jsonify({'error': 'Bad request'}), 400)


# 404 error handler
@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)


# 500 error handler
@app.errorhandler(500)
def internal_server_error(error):
    return make_response(jsonify({'error': 'Internal Server Error'}), 500)


# Get artifacts tree view
@app.route(BASE_URL + 'artifacts', methods=['GET'])
@crossdomain(origin='*')
def get_artifacts():
    global CURRENT_DIR
    response = file_service.artifacts(CURRENT_DIR)
    return response

# Get Home page


@app.route(BASE_URL + 'artifacts/home', methods=['GET'])
@crossdomain(origin='*')
def get_home_page():
    global CURRENT_DIR
    response = file_service.home_directory(CURRENT_DIR)
    return response


# Get feature files tree view
@app.route(BASE_URL + 'feature_files', methods=['GET'])
@crossdomain(origin='*')
def get_feature_files():
    response = file_service.feature_files(CURRENT_DIR)
    return response


# Get configs tree view
@app.route(BASE_URL + 'configs', methods=['GET'])
@crossdomain(origin='*')
def get_configs():
    response = file_service.configs(CURRENT_DIR)
    return response


# get file content
@app.route(BASE_URL + 'files', methods=['GET'])
@crossdomain(origin='*')
def get_file_content():
    global CURRENT_DIR
    path = request.args.get('path')
    path = path.replace("../", "")
    if path is None:
        abort(400)
    if not os.path.exists(os.path.join(CURRENT_DIR, path)):
        abort(404)
    response = file_service.file_content(CURRENT_DIR, path)
    return response


# update file content
@app.route(BASE_URL + 'files', methods=['POST'])
@crossdomain(origin='*')
def edit_file_content():
    global CURRENT_DIR
    path = request.args.get('path')
    path = path.replace("../", "")
    if path is None:
        abort(400)
    if not os.path.exists(os.path.join(CURRENT_DIR, path)):
        abort(404)
    json_data = request.get_json(force=True)
    return file_service.edit_file_content(CURRENT_DIR, path, json_data['content'])


# download artifact as a zip
@app.route(BASE_URL + 'artifacts/<artifact_name>/download', methods=['GET'])
@crossdomain(origin='*')
def download_artifact(artifact_name):
    global CURRENT_DIR
    path = request.view_args['artifact_name']
    if path is None:
        abort(400)
    if not os.path.exists(os.path.join(CURRENT_DIR, 'artifacts', path)):
        abort(404)
    return transfer_service.download_artifact(CURRENT_DIR, artifact_name)


# download artifact report as a pdf
@app.route(BASE_URL + 'reports', methods=['GET'])
@crossdomain(origin='*')
def download_report():
    global CURRENT_DIR
    path = request.args.get('path')
    path = path.replace("../", "")
    if path is None:
        abort(400)
    if not os.path.exists(os.path.join(CURRENT_DIR, path)):
        abort(404)
    return transfer_service.download_report(CURRENT_DIR, path)


# download pdf report
@app.route(BASE_URL + 'download_report_content', methods=['GET'])
@crossdomain(origin='*')
def download_report_content():
    try:
        tempdir = os.path.join(CURRENT_DIR, 'abot/temp/')
        filename = request.args.get('file')
        return send_from_directory(tempdir, filename, as_attachment=True, mimetype='application/pdf')
    except Exception:
        abort(500)


# add feature file
@app.route(BASE_URL + 'feature_files', methods=['POST'])
@crossdomain(origin='*')
def uploads_feature_file():
    global CURRENT_DIR
    file = request.files['file']
    path = request.values['path']
    response = transfer_service.upload_feature_files(CURRENT_DIR, file, path)
    return response


# Get execution status
@app.route(BASE_URL + 'execution_status', methods=['GET'])
@crossdomain(origin='*')
def is_executing():
    execution_status = {'executing': file_service.is_executing()}
    return make_response(jsonify(status=execution_status), 200)


# Execute feature file
@app.route(BASE_URL + 'feature_files/execute', methods=['POST'])
@crossdomain(origin='*')
def execute_feature_file():
    json_data = request.get_json(force=True)
    params = json_data['params']
    runner = FeatureFileRunner(json_data['params'])
    runner.start()
    return make_response(jsonify({'status': 'OK'}), 200)

# Execute feature file


@app.route(BASE_URL + 'execute/logs', methods=['GET'])
@crossdomain(origin='*')
def execution_log():
    return Response(file_service.log_message(), mimetype='text/html')


# Get packet counters data
@app.route('/abot/api/v5/graph/packet_counters', methods=['GET'])
@crossdomain(origin='*')
def get_packet_counters():
    packet_counters_response = packet_counters()
    if packet_counters_response is None:
        return make_response(jsonify({'error': 'Internal Server Error'}), 500)
    return packet_counters_response, 200


# Get transaction counts data
@app.route('/abot/api/v5/graph/transaction_counts', methods=['GET'])
@crossdomain(origin='*')
def get_transaction_counts():
    mongo_document_json = transaction_counts()
    return mongo_document_json, 200


# Get procedure completions data
@app.route('/abot/api/v5/graph/procedure_completions', methods=['GET'])
@crossdomain(origin='*')
def get_procedure_completions():
    mongo_document_json = procedure_completions()
    return mongo_document_json, 200


# Get uplink downlink bandwidth data
@app.route('/abot/api/v5/graph/uplink_downlink_bandwidth', methods=['GET'])
@crossdomain(origin='*')
def get_uplink_downlink_bandwidth():
    mongo_document_json = uplink_downlink_bandwidth()
    return mongo_document_json, 200


if __name__ == "__main__":
    # Rotating file handler for Flask log messages
    handler = RotatingFileHandler('abot-ui.log', maxBytes=10000, backupCount=3)
    handler.setLevel(logging.DEBUG)

    log = logging.getLogger('werkzeug')
    log.setLevel(logging.DEBUG)
    log.addHandler(handler)

    app.logger.addHandler(handler)
    app.logger.setLevel(logging.DEBUG)

    app.run(host='0.0.0.0', port=5000, threaded=True)
