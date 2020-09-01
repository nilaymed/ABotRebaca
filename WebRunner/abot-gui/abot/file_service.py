#!/usr/bin/env python

from pymodules.flask import jsonify, Response
from mimetypes import MimeTypes
from subprocess import Popen, PIPE
import os
import urllib
import csv
import time
import json
import select
import signal
import threading
import uuid

# global veriables
VALID_FILES = ['feature-overview.html', 'tag-overview.html']
ABOT_DEPLOY_DIR = '/etc/rebaca-test-suite/'
LOG_FILE = 'log/TestAutomationLog.log'
SUBSCRIBERS = []
IS_EXECUTING = False


# Thread class for tail process
class TailProcess(threading.Thread):
    def __init__(self):
        super(TailProcess, self).__init__()

    def run(self):
        global SUBSCRIBERS
        global ABOT_DEPLOY_DIR
        global LOG_FILE
        global IS_EXECUTING
        IS_EXECUTING = True
        self.file_descriptor = Popen(
            ['tail', '-F', ABOT_DEPLOY_DIR + LOG_FILE], stdout=PIPE, stderr=PIPE)
        while IS_EXECUTING is True:
            line = self.file_descriptor.stdout.readline()
            for subscriber in SUBSCRIBERS:
                subscriber.set_message(line)
            time.sleep(0.001)

    def close_process(self):
        global IS_EXECUTING
        IS_EXECUTING = False
        os.kill(self.file_descriptor.pid, signal.SIGTERM)


# class to store subscriber messages
class Subscriber:
    messages = []
    unique_id = str(uuid.uuid4())
    current_index = 0

    def get_messages(self):
        temp = self.messages
        self.messages = []
        return temp

    def get_unique_id(self):
        return self.unique_id

    def set_message(self, message):
        self.messages.append(message)


def is_executing():
    global IS_EXECUTING
    return IS_EXECUTING


def artifacts(current_dir):
    valid_files_ext = ['.pcap', '.log', '.csv']
    hidden_dir = ['blue', 'charts', 'js', '__macosx', '.zip']
    try:
        base_dir = os.path.join(current_dir, 'artifacts')
        tree_data = _make_tree(base_dir, valid_files_ext,
                               hidden_dir)['children']
        tree_data.sort(key=lambda x: time.mktime(time.strptime(
            x['label'].rsplit("-", 1)[0], "%d%b%Y-%H%M%S%p")), reverse=True)
        return jsonify(status='OK', tree_list=tree_data)
    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def home_directory(current_dir):
    valid_files_ext = ['.pcap', '.log', '.csv']
    hidden_dir = ['blue', 'charts', 'js', '__macosx', '.zip']
    try:
        base_dir = os.path.join(current_dir, 'artifacts')
        tree_data = _make_tree(base_dir, valid_files_ext,
                               hidden_dir)['children']
        tree_data.sort(key=lambda x: time.mktime(time.strptime(
            x['label'].rsplit("-", 1)[0], "%d%b%Y-%H%M%S%p")), reverse=True)
        return jsonify(status='OK', artifact=tree_data[0]['label'])
    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def feature_files(current_dir):
    valid_files_ext = ['.feature', '.xml', '.rxf', '.tst', '.csv', '.template']
    hidden_dir = ['blue', 'charts', 'js', '__macosx']
    try:
        base_dir = os.path.join(current_dir, 'featureFiles')
        tree_data = _make_tree(base_dir, valid_files_ext,
                               hidden_dir)['children']
        tree_data.sort(key=lambda x: x['label'], reverse=False)
        return jsonify(status='OK', tree_list=tree_data)
    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def configs(current_dir):
    valid_files_ext = ['.properties', '.template']
    hidden_dir = ['blue', 'charts', 'js', '__macosx']
    try:
        base_dir = os.path.join(current_dir, 'config')
        tree_data = _make_tree(base_dir, valid_files_ext,
                               hidden_dir)['children']
        tree_data.sort(key=lambda x: x['label'], reverse=False)
        return jsonify(status='OK', tree_list=tree_data)
    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def _make_tree(path, valid_files_ext, hidden_dir, level=-1, role=0):
    global VALID_FILES
    tree = dict(label=os.path.basename(path), children=[], id="role%s" % (
        str(level if level > 0 else "") + str(role)), collapsed='true')
    if level > 0:
        level = str(level) + "1"
    else:
        level = role
    try:
        lst = os.listdir(path)
    except OSError:
        pass
    else:
        role = 0
        for name in lst:
            fn = os.path.join(path, name)
            if os.path.isdir(fn) and name.lower() not in hidden_dir:
                role += 1
                tree['children'].append(_make_tree(
                    fn, valid_files_ext, hidden_dir, level, role))
            else:
                filename, file_ext = os.path.splitext(name)
                if file_ext.lower() in valid_files_ext or name.lower() in VALID_FILES:
                    className = 'ext_' + file_ext.lower()[1:]
                    role += 1
                    role_id = str(level if level > 0 else "") + \
                        str(role if role else "")
                    tree['children'].append(
                        {'label': name, 'id': "role%s" % (role_id), 'class': "%s" % (className)})
    return tree


def file_content(current_dir, path):
    try:
        result = {'file': '', 'mime': '', 'message': '', 'message_css': '', 'download': '',
                  'showDownload': False, 'containerScroll': True, 'content': '', 'keywords': ''}
        file = os.path.join(current_dir, path.replace("../", ""))

        mime = MimeTypes()
        mime_type = mime.guess_type(urllib.pathname2url(file))[0] if mime.guess_type(
            urllib.pathname2url(file))[0] else 'text/plain'
        result['file'] = file
        result['mime'] = mime_type
        download_html = ''
        download_html += '<div class="">'
        download_html += '<a class="btn-download btn btn-lg btn-primary" href="' + file + \
            '" target="_blank"><i class="glyphicon glyphicon-download-alt"></i> Download</a>'
        download_html += '</div>'
        result['download'] = download_html

        supported_application = [
            'application/xml', 'text/x-php', 'text/plain', 'text/xml', 'text/csv']
        mime = mime_type.split('/')
        file_mime = mime[0]
        if mime_type in supported_application:
            content = ''
            words = ''
            file_ext = file.split('.')
            if file_ext[len(file_ext)-1] == "properties":
                with open(file) as f:
                    for line in f:
                        content += line
            elif file_ext[len(file_ext)-1] == "feature":
                content = open(file).read()
                x = open(file, "r")
                words = [w for w in x.read().split() if w[0] == "@"]
            elif file_ext[len(file_ext)-1] == "csv":
                with open(file, 'rb') as csvfile:
                    spamreader = csv.reader(
                        csvfile, delimiter=' ', quotechar='|')
                    for row in spamreader:
                        line = ' '.join(row)
                        content += line + "\n"
            else:
                content = open(file).read()
                content = unicode(content, errors='ignore')

            result['content'] = content
            result['containerScroll'] = True
            result['showDownload'] = False
            result['keywords'] = words

        elif (file_mime == 'text'):
            html_content = ''
            html_content += '<object data="' + file + '" type="' + \
                mime_type + '" id="fileObject" style="width:100% ">'
            html_content += '<embed type="' + mime_type + \
                '" src="' + file + '" style="width:100%">'
            html_content += '</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = False
        else:
            html_content = ''
            html_content += '<object data="' + file + '" type="' + mime_type + \
                '" id="fileObject" style="width:100% " class="hidden">'
            html_content += '<embed type="' + mime_type + \
                '" src="' + file + '" style="width:100%">'
            html_content += '</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = True

        return jsonify(status='OK', result=result)
    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def edit_file_content(current_dir, path, content):
    try:
        result = {'file': '', 'mime': '', 'message': '', 'message_css': '', 'download': '',
                  'showDownload': False, 'containerScroll': True, 'content': '', 'keywords': ''}
        file = os.path.join(current_dir, path.replace('../', ''))
        fileContent = content.replace("<br>", "\n")
        exePermissionStr = 'sudo ' + 'find ' + file + ' -type ' + \
            'f ' + '-exec ' + 'chmod ' + 'ugo+rwx ' + '{} ' + '\;'
        ffPermissionChange = Popen(
            exePermissionStr, stderr=PIPE, stdout=PIPE, shell=True)
        ffPermissionChange.communicate()
        temp = ffPermissionChange.returncode

        if temp == 0:
            with open(file, "w") as f:
                f.write(fileContent)
        else:
            print "Write permission not granted to the feature file"

        mime = MimeTypes()
        mime_type = mime.guess_type(urllib.pathname2url(file))[0] if mime.guess_type(
            urllib.pathname2url(file))[0] else 'text/plain'
        result['file'] = file
        result['mime'] = mime_type
        download_html = ''
        download_html += '<div class="">'
        download_html += '<a class="btn-download btn btn-lg btn-primary" href="' + file + \
            '" target="_blank"><i class="glyphicon glyphicon-download-alt"></i> Download</a>'
        download_html += '</div>'
        result['download'] = download_html

        supported_application = [
            'application/xml', 'text/x-php', 'text/plain', 'text/xml', 'text/csv']
        mime = mime_type.split('/')
        file_mime = mime[0]
        if mime_type in supported_application:
            content = ''
            words = ''

            file_ext = file.split('.')

            if file_ext[len(file_ext)-1] == "properties":
                with open(file) as f:
                    for line in f:
                        content += line
            elif file_ext[len(file_ext)-1] == "feature":
                content = open(file).read()
                x = open(file, "r")
                words = [w for w in x.read().split() if w[0] == "@"]

            else:
                content = open(file).read()

            result['content'] = content
            result['containerScroll'] = True
            result['showDownload'] = False
            result['keywords'] = words

        elif (file_mime == 'text'):
            html_content = ''
            html_content += '<object data="' + file + '" type="' + \
                mime_type + '" id="fileObject" style="width:100% ">'
            html_content += '<embed type="' + mime_type + \
                '" src="' + file + '" style="width:100%">'
            html_content += '</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = False
        else:
            html_content = ''
            html_content += '<object data="' + file + '" type="' + mime_type + \
                '" id="fileObject" style="width:100% " class="hidden">'
            html_content += '<embed type="' + mime_type + \
                '" src="' + file + '" style="width:100%">'
            html_content += '</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = True

        return jsonify(status='OK', result=result)

    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def _remove_element(uid):
    global SUBSCRIBERS
    for index in range(len(SUBSCRIBERS)):
        if uid == SUBSCRIBERS[index].get_unique_id():
            del SUBSCRIBERS[index]
            break


def log_message():
    global IS_EXECUTING
    global SUBSCRIBERS
    subscriber = Subscriber()
    SUBSCRIBERS.append(subscriber)
    yield "<script>var refreshIntervalId = window.setInterval(function() { window.scrollTo(0,999999999) }, 500); </script>"
    while IS_EXECUTING is True:
        for message in subscriber.get_messages():
            yield "<font color='#333333' font family='Open Sans,Arial,sans-serif'>" + message + '</font><br/>\n'
    yield "<script>window.setTimeout(function() { window.clearInterval(refreshIntervalId); }, 1000);</script>"
    _remove_element(subscriber.get_unique_id())
    return
