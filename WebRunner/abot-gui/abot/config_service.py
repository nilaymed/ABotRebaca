#install flask
#!flask/bin/python
from flask import Flask, jsonify, abort, request, make_response, url_for
import re
import fileinput

app = Flask(__name__, static_url_path = "")

#Contains configurations
sut_names = []
simulator_names = []
config_map = {}
FILE_NAME = "ABotConfig.properties"

@app.errorhandler(400)
def bad_request(error):
    return make_response(jsonify( { 'error': 'Bad request' } ), 400)

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify( { 'error': 'Not found' } ), 404)

#Converting node details to json
def jsonify_node_details(node_details, node):
    return jsonify( { node: node_details })
    
#Read configuration file
def read_configuration_file():
    global config_map
    configFile = open(FILE_NAME,"r")
    for configuration in configFile.readlines():
        configs = configuration.rstrip('\n\r').split('=')
        if not configs[0].startswith('##') and configs[0] != '':
            config_map[configs[0]]=configs[1]
    get_sut_names()
    get_simulator_names()

#Get SUT names
def get_sut_names():
    global sut_names
    global configs_map
    for key,val in config_map.items():
        if key.upper().startswith('ABOT.SUT.NAMES'):
            sut_names = val.split(',')
            break

#Get Simulator names
def get_simulator_names():
    global simulator_names
    global configs_map
    for key,val in config_map.items():
        if key.upper().startswith('ABOT.SIMULATOR.NAMES'):
            simulator_names = val.split(',')
            break

#Filter configrations by node name
def get_node_details(node_name):
    node_details = {}
    for key,val in config_map.items():
        if key.upper().startswith(node_name.upper()+'.'):
            key = key.upper().replace(node_name.upper() + '.', '')
            node_details[key] = val
    return node_details

def get_general_nodes():
    global sut_names
    global simulator_names
    other_nodes = {}
    nodes = sut_names + simulator_names + ['ABOT']
    for key,val in config_map.items():
        if len(re.findall(r"(?=("+'|'.join(nodes)+r"))",key)) == 0:
            other_nodes[key] = val
    return other_nodes

#ABOT Configurations
@app.route('/abot/api/v4.0.0/configs/nodes/<string:node_name>', methods = ['GET'])
def get_node(node_name):
    read_configuration_file()
    if(node_name.upper() == 'ABOT'):    
        node_details = get_node_details(node_name)
        return jsonify_node_details(node_details, node_name)
    elif(node_name.upper() == 'GENERAL'):
        node_details = get_general_nodes();
        return jsonify_node_details(node_details, node_name)
    abort(400)

#SUT by SUT name
@app.route('/abot/api/v4.0.0/configs/suts/<string:sut_name>', methods = ['GET'])
def get_sut(sut_name):
    global sut_names
    if sut_name.upper() in map(lambda sut:sut.upper(),sut_names):
        node_details = get_node_details(sut_name)
        return jsonify_node_details(node_details, sut_name)
    abort(404)

#SIMULATOR by SIMULATOR name	
@app.route('/abot/api/v4.0.0/configs/simulators/<string:simulator_name>', methods = ['GET'])
def get_simulator(simulator_name):
    global simulator_names
    if simulator_name.upper() in map(lambda simulator:simulator.upper(),simulator_names):
        node_details = get_node_details(simulator_name)
        return jsonify_node_details(node_details, simulator_name)
    abort(404)

@app.route('/abot/api/v4.0.0/configs/nodes/<string:node_name>', methods = ['PUT'])
def update_node(node_name):
    if not request.json:
        abort(400)
    modified_values = request.json.get(node_name)
    modified_node_name = ''
    if node_name.upper().startswith('ABOT'):
        modified_node_name = node_name.upper() + '.'
    for line in fileinput.FileInput(FILE_NAME, inplace=1):
        for key,val in modified_values.items():
           full_key = modified_node_name + key.upper()
           line = line.rstrip('\n\r')
           if line.upper().startswith(full_key):
               new_line = line.split('=')[0] + '=' + val
               line=line.replace(line, new_line)
           print line
           break
    return jsonify( { 'result': True } )

@app.route('/abot/api/v4.0.0/configs/suts/<string:sut_name>', methods = ['PUT'])
def update_sut(sut_name):
    global sut_names
    if not request.json:
        abort(400)
    if sut_name.upper() in map(lambda sut:sut.upper(),sut_names):
        modified_values = request.json.get(sut_name)
        for line in fileinput.FileInput(FILE_NAME, inplace=1):
            for key,val in modified_values.items():
                full_key = sut_name.upper() + '.' +key.upper()
                line = line.rstrip('\n\r')
                if line.upper().startswith(full_key):
                    new_line = line.split('=')[0] + '=' + val
                    line=line.replace(line, new_line)
                print line
                break
        return jsonify( { 'result': True } )
    abort(404)

@app.route('/abot/api/v4.0.0/configs/simulators/<string:simulator_name>', methods = ['PUT'])
def update_simulator(simulator_name):
    global simulator_names
    if not request.json:
        abort(400)
    if simulator_name.upper() in map(lambda simulator:simulator.upper(),simulator_names):
        modified_values = request.json.get(simulator_name)
        for line in fileinput.FileInput(FILE_NAME, inplace=1):
            for key,val in modified_values.items():
                full_key = simulator_name.upper() + '.' +key.upper()
                line = line.rstrip('\n\r')
                if line.upper().startswith(full_key):
                    new_line = line.split('=')[0] + '=' + val
                    line=line.replace(line, new_line)
                print line
                break
        return jsonify( { 'result': True } )
    abort(404)

@app.route('/abot/api/v4.0.0/configs/simulators/<string:simulator_name>', methods = ['DELETE'])
def delete_simulator(simulator_name):
    global simulator_names
    if simulator_name.upper() in map(lambda simulator:simulator.upper(),simulator_names):
        for line in fileinput.FileInput(FILE_NAME, inplace=1):
            line = line.rstrip('\n\r')
            if line.upper().startswith('ABOT.SIMULATOR.NAMES'):
                tokens = line.split('=')
                nodes = tokens[1]
                nodes = nodes.split(',')
                index = map(lambda simulator:simulator.upper(),simulator_names).index(simulator_name.upper())
                del nodes[index]
                line = tokens[0] + '=' + ",".join(nodes)
                print line
            elif not line.upper().startswith(simulator_name.upper()):
                print line
        return jsonify( { 'result': True } )
    abort(404)

@app.route('/abot/api/v4.0.0/configs/suts/<string:sut_name>', methods = ['DELETE'])
def delete_sut(sut_name):
    global sut_names
    if sut_name.upper() in map(lambda sut:sut.upper(),sut_names):
        for line in fileinput.FileInput(FILE_NAME, inplace=1):
            line = line.rstrip('\n\r')
            if line.upper().startswith('ABOT.SUT.NAMES'):
                tokens = line.split('=')
                nodes = tokens[1]
                nodes = nodes.split(',')
                index = map(lambda sut:sut.upper(),sut_names).index(sut_name.upper())
                del nodes[index]
                line = tokens[0] + '=' + ",".join(nodes)
                print line
            elif not line.upper().startswith(sut_name.upper()):
                print line
        return jsonify( { 'result': True } )
    abort(404)
	
@app.route('/abot/api/v4.0.0/configs/simulators/<string:simulator_name>', methods = ['POST'])
def add_simulator(simulator_name):
    if not request.json:
        abort(400)
    
    request_json = request.json[simulator_name]
    return jsonify( { simulator_name: request_json } ), 201

@app.route('/abot/api/v4.0.0/configs/suts/<string:sut_name>', methods = ['POST'])
def add_sut(sut_name):
    if not request.json:
        abort(400)
    
    request_json = request.json[sut_name]
    with open(FILE_NAME, 'a') as config_file:
        for key in request_json:
            value = request_json[key]
            config_file.write(sut_name + '.' + key + '=' + value + '\n')
    return jsonify( { sut_name: request_json } ), 201
    
if __name__ == '__main__':
    app.run(debug = True)
