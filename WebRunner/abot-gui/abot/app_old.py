#!/usr/bin/env python3

from pymodules.flask import Flask,render_template,send_file,jsonify,abort,request,make_response, send_from_directory, current_app, stream_with_context, Response, redirect, url_for
from pymodules.natsort import natsorted
from mimetypes import MimeTypes
from datetime import timedelta
from functools import update_wrapper
from werkzeug.utils import secure_filename
from graph_server import packet_counters, transaction_counts, procedure_completions, uplink_downlink_bandwidth

from pprint import pprint

from os import listdir
from os.path import isfile, join

import ConfigParser
import os.path

import os, urllib, subprocess, stat
import time, json
import zipfile
import csv
import re
import time

#server code
from bs4 import BeautifulSoup

UPLOAD_FOLDER = '/abot/temp/'
#ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif', 'csv', 'feature', 'rxf', 'tst', 'template'])
ALLOWED_EXTENSIONS = set(['csv', 'feature', 'tst', 'template'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



#server code
CURRENT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

#docroot_resources = os.path.join(os.path.dirname(__file__), "resources")
#chart_config = os.path.join(os.path.dirname(__file__), "chartconfig")
#settings = os.path.join(os.path.dirname(__file__), 'settings.conf')
#current_path = os.path.dirname(os.path.abspath(__file__)) + os.path.sep

#local code
#CURRENT_DIR = os.pardir

ARTIFACTS_LIST = None
APPLY = True

def crossdomain(origin=None, methods=None, headers=None,

                max_age=21600, attach_to_all=True,

                automatic_options=True):

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

@app.route("/")
@app.route("/index.html")
def index():
    #return render_template('index.html')
    return send_file('index.html')

@app.route('/readTestReports', methods=['POST'])
@app.route('/readArtifacts', methods=['POST','OPTIONS'])
@crossdomain(origin='*')

def listDirectory():
    global ARTIFACTS_LIST
    if APPLY:
        ARTIFACTS_LIST = newFileTree()
    
    try:
        json_data = request.json
        BASE_DIR = os.path.join(CURRENT_DIR, 'artifacts')
        #BASE_DIR = os.path.join(os.getcwd(), 'static', 'artifacts')

        if not os.path.exists(BASE_DIR):
            return abort(404)

        subdir_names = [x for x in os.listdir(BASE_DIR) if os.path.isdir(os.path.join(BASE_DIR, x))]

        #subdir_names.sort(key=lambda x: time.mktime(time.strptime(x, "%d%b%Y-%H%M%S%p-UTC")), reverse=True)
        subdir_names.sort(key=lambda x: time.mktime(time.strptime(x.rsplit("-", 1)[0], "%d%b%Y-%H%M%S%p")), reverse=True)


        #subdir_names = natsorted(os.listdir(BASE_DIR), reverse=True)
        

        result = []
        for dir in subdir_names:
            if (dir != '.') and (dir != '..') and (os.path.isdir(os.path.join(BASE_DIR, dir))):
                result.append(dir)
            
        for file_name in subdir_names:
            if (file_name != '.') and (file_name != '..') and (not os.path.isdir(os.path.join(BASE_DIR, file_name))):
                result.append(file_name)
        
        #file_path = os.path.join('static', 'artifacts', subdir_names[0], 'report-'+ subdir_names[0], json_data['page']+'.html')
        #print "127", result
        return jsonify(status='OK',directories=result)

    except Exception,e:
        #return jsonify(status='ERROR',message=str(e))
        return



'''    
#@app.route('/displayFileTree', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def displayFileTree():
    try:
        json_data = request.json
        #print "displayFileTree" *47
        #print json_data
        
        dir = json_data['dir']
        dirTypeId = json_data['typeId']
        #print "142--0---", dir,"142--1---", dirTypeId
 
        if (dirTypeId and dirTypeId.lower() == 'artifactsfiles'):
            #print "52----------"
            hidden_dir = ['blue', 'charts', '__macosx']
            #Show tag-overview and feature-overview for report-xx directory
            report_dir_in_post = dir.split('/report-')
            if len(report_dir_in_post) > 1:
                visible_files = ['feature-overview.html', 'tag-overview.html']
        
        #BASE_DIR = os.path.join(os.pardir, dir)
        BASE_DIR = os.path.join(CURRENT_DIR, dir)
        #print "153", BASE_DIR

        #BASE_DIR = os.path.join(os.getcwd(), dir)
        if not os.path.exists(BASE_DIR):

            return abort(404)
        
        subdir_names = natsorted(os.listdir(BASE_DIR), reverse=True)    
        
        html = ""
        dirList = []
        for dir_name in subdir_names:
            if (dir_name != '.') and (dir_name != '..') and (os.path.isdir(os.path.join(BASE_DIR, dir_name))):
                hide_class = ''
                if hidden_dir:
                    if dir_name.lower() in hidden_dir:
                        hide_class = 'hidden'
                    else:
                        hide_class = ''
                
                html+= "<li class='directory collapsed " + hide_class 
                html+= "\'><a href='#' rel='" 
                html+= "/".join([dir, dir_name]) 
                html+= "/'>" + dir_name 
                html+= "</a></li>"
                dirList.append(dir_name)
                
        for file_name in subdir_names:
            if (file_name != '.') and (file_name != '..') and (not os.path.isdir(os.path.join(BASE_DIR, file_name))):
                ext = os.path.splitext(file_name)[1][1:]
                hide_class = ''
                
                if visible_files:
                    if file_name.lower() in visible_files:
                        hide_class = ''
                    else:
                        hide_class = 'hidden'
                
                html+= "<li class=\"file " + hide_class + "ext_" + ext + "\"><a href=\"#\" onclick=\"fileName()\" class=\"file-list\" rel=\"" + "/".join([dir, file_name]) + "\">" + file_name + "</a></li>"
                    
        html+= "</ul>"
        
        return jsonify(status='OK',dir_list=dirList,html_data=html)
    except Exception,e:
        raise
        return jsonify(status='ERROR',message=str(e))
'''

@app.route('/displayFeatureFileTree', methods=['POST'])
@crossdomain(origin='*')
def newFeatureFileTree():
    try:
        #BASE_DIR = os.path.join(os.pardir, 'featureFiles')
        BASE_DIR = os.path.join(CURRENT_DIR, 'featureFiles')
        #BASE_DIR = "static/featureFiles"
        tree_data = _make_feature_tree(BASE_DIR)['children']
        return jsonify(status='OK',tree_list=tree_data)
    except Exception,e:
        return jsonify(status='ERROR',message=str(e))    

def _make_feature_tree(path, level=-1, role=0):
    valid_files_ext = [".feature", 
                       ".xml", 
                       ".rxf",
                       ".tst",
                       ".csv",
                       ".template"]
    hidden_dir = ['blue', 
                  'charts', 
                  'js',
                  '__macosx']
                  
    valid_files = ['feature-overview.html', 'tag-overview.html']   
        
    tree = dict(label=os.path.basename(path), children=[], id="role%s" %(str(level if level > 0 else "") + str(role)))
    if level > 0:
        level = str(level) + "1"
    else:
        level = role
    try: lst = os.listdir(path)
    except OSError:
        pass #ignore errors
    else:
        role = 0
        for name in natsorted(lst, reverse=False):
            fn = os.path.join(path, name)
            if os.path.isdir(fn) and name.lower() not in hidden_dir:
                role += 1
                tree['children'].append(_make_feature_tree(fn, level, role))
            else:
                filename, file_ext = os.path.splitext(name)
                if file_ext.lower() in valid_files_ext or name.lower() in valid_files:
                    className = 'ext_' + file_ext.lower()[1:]
                    role += 1
                    role_id = str(level if level > 0 else "") + str(role if role else "")
                    tree['children'].append({'label':name, 'id':"role%s" %(role_id), 'class':"%s" %(className)})
                    
    return tree
 
@app.route('/displayConfigFileTree', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def configFileTree():
    try:
        #BASE_DIR = os.path.join(os.pardir, 'config')
        BASE_DIR = os.path.join(CURRENT_DIR, 'config')
        tree_data = _make_config_tree(BASE_DIR)['children']
        return jsonify(status='OK',tree_list=tree_data)
    except Exception,e:
        return jsonify(status='ERROR',message=str(e))    

def _make_config_tree(path, level=-1, role=0):
    valid_files_ext = [".properties", 
                       ".properties_old"]
    hidden_dir = ['blue', 
                  'charts', 
                  'js',
                  '__macosx']
                  
    valid_files = ['feature-overview.html', 'tag-overview.html']   
        
    tree = dict(label=os.path.basename(path), children=[], id="role%s" %(str(level if level > 0 else "") + str(role)))
    if level > 0:
        level = str(level) + "1"
    else:
        level = role
    try: lst = os.listdir(path)
    except OSError:
        pass #ignore errors
    else:
        role = 0
        for name in natsorted(lst, reverse=False):
            fn = os.path.join(path, name)
            if os.path.isdir(fn) and name.lower() not in hidden_dir:
                role += 1
                tree['children'].append(_make_config_tree(fn, level, role))
            else:
                filename, file_ext = os.path.splitext(name)
                if file_ext.lower() in valid_files_ext or name.lower() in valid_files:
                    className = 'ext_' + file_ext.lower()[1:]
                    role += 1
                    role_id = str(level if level > 0 else "") + str(role if role else "")
                    tree['children'].append({'label':name, 'id':"role%s" %(role_id), 'class':"%s" %(className)})
    return tree


@app.route('/displayFileTree', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def newFileTree():
    if APPLY and ARTIFACTS_LIST is not None and (len(json.loads(ARTIFACTS_LIST.response[0])['tree_list']) == len(os.listdir(os.path.join(CURRENT_DIR, 'artifacts')))-1):
        #print "EXISTING DATA"
        return ARTIFACTS_LIST
        
    try:
        #BASE_DIR = os.path.join(os.pardir, 'artifacts')
        BASE_DIR = os.path.join(CURRENT_DIR, 'artifacts')
        tree_data = _make_tree(BASE_DIR)['children']

        #tree_data.sort(key=lambda x: time.mktime(time.strptime(x['label'], "%d%b%Y-%H%M%S%p-UTC")), reverse=True)
        tree_data.sort(key=lambda x: time.mktime(time.strptime(x['label'].rsplit("-", 1)[0], "%d%b%Y-%H%M%S%p")), reverse=True)
        

        return jsonify(status='OK',tree_list=tree_data)
    except Exception,e:
        return jsonify(status='ERROR',message=str(e))
    
def _make_tree(path, level=-1, role=0):
    valid_files_ext = [".pcap", 
                       ".log",
                       ".csv"]
    hidden_dir = ['blue', 
                  'charts', 
                  'js',
                  '__macosx',
                  '.zip']
                  
    valid_files = ['feature-overview.html', 'tag-overview.html']   
        
    tree = dict(label=os.path.basename(path), children=[], id="role%s" %(str(level if level > 0 else "") + str(role)), collapsed = 'true')
    if level > 0:
        level = str(level) + "1"
    else:
        level = role
    try: 
        lst = os.listdir(path)
        
    except OSError:
        pass #ignore errors
    else:
        role = 0
        for name in lst:
            fn = os.path.join(path, name)
            if os.path.isdir(fn) and name.lower() not in hidden_dir:
                role += 1
                tree['children'].append(_make_tree(fn, level, role))
            else:
                filename, file_ext = os.path.splitext(name)
                if file_ext.lower() in valid_files_ext or name.lower() in valid_files:
                    className = 'ext_' + file_ext.lower()[1:]
                    role += 1
                    role_id = str(level if level > 0 else "") + str(role if role else "")
                    tree['children'].append({'label':name, 'id':"role%s" %(role_id), 'class':"%s" %(className)})
    
    return tree
   
        
@app.route('/getFileContent', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def getFileContent():
    try:
        #Initialize
        result = {'file' : '',
                   'mime' : '',
                   'message' : '',
                   'message_css' : '',
                   'download' : '',
                   'showDownload' : False,
                   'containerScroll' : True,
                   'content' : '',
                   'keywords' : ''}
    
        #json_data = request.json
        
        json_data = request.get_json(force=True)
        
        #file = json_data['path']
        file = os.path.join(CURRENT_DIR, json_data['path'].replace("../",""))
        
        mime = MimeTypes()
        mime_type = mime.guess_type(urllib.pathname2url(file))[0] if mime.guess_type(urllib.pathname2url(file))[0] else 'text/plain' 
        result['file'] = file
        result['mime'] = mime_type
        download_html = ''
        download_html+='<div class="">'
        download_html+='<a class="btn-download btn btn-lg btn-primary" href="' + file + '" target="_blank"><i class="glyphicon glyphicon-download-alt"></i> Download</a>'
        download_html+='</div>'
        result['download'] = download_html
        
        supported_application = ['application/xml', 'text/x-php', 'text/plain', 'text/xml', 'text/csv']
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
                    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
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
            html_content+= '<object data="' + file + '" type="' + mime_type + '" id="fileObject" style="width:100% ">'
            html_content+='<embed type="' + mime_type + '" src="' + file + '" style="width:100%">'
            html_content+='</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = False
        else:
            html_content = ''
            html_content+= '<object data="' + file + '" type="' + mime_type + '" id="fileObject" style="width:100% " class="hidden">'
            html_content+='<embed type="' + mime_type + '" src="' + file + '" style="width:100%">'
            html_content+='</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = True
       
        return jsonify(status='OK',result=result)
    except Exception,e:
        return jsonify(status='ERROR',message=str(e))

@app.route('/executeFeatureFile', methods=['GET'])
@crossdomain(origin='*')
def executeFile():
    #Initialize
    json_data = request.args.to_dict()
    directory = json_data['directory']
    command = json_data['command']
    params = json_data['params']
    def inner():
        #process = subprocess.Popen(["sudo", "./run_local", "sip-ssh-test"], stdout=subprocess.PIPE, cwd="/etc/rebaca-test-suite/actions")
        yield "<script>var refreshIntervalId = window.setInterval(function() { window.scrollTo(0,999999999) }, 500); </script>"
        process = subprocess.Popen(["sudo", command, params], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=directory)
        for line in iter(process.stdout.readline, ''):
            yield "<font color='#333333' font family='Open Sans,Arial,sans-serif' >" + line.rstrip() + '<br/>\n'
            #yield "<font color='red'>" + line.rstrip() + '</font><br/>\n' if 'error' in line.rstrip().lower() else "<font color='green'>" + line.rstrip() + '</font><br/>\n'
        '''    
        for line in iter(process.stderr.readline, ''):
            yield '<font color="red">' + line.rstrip() + '</font><br/>\n'
        '''
        yield "<script>window.setTimeout(function() { window.clearInterval(refreshIntervalId); }, 1000);</script>"    
            
    return Response(inner(), mimetype='text/html')


@app.route('/getArtiFolder', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def downloadArtifactsFolder():
         
    BASE_DIR = os.path.join(CURRENT_DIR, 'artifacts')
    try:
        json_data = request.get_json(force=True)
        path = os.path.join(CURRENT_DIR,'artifacts', json_data['folderName'])
        
        createdFolderPath = os.path.join(CURRENT_DIR,'abot/temp', json_data['folderName'])
        
        def zipdir(url, ziph):
            length = len(url)
            for root, dirs, files in os.walk(url):
                folder = root[length:] # path without "parent"
                for file in files:
                    ziph.write(os.path.join(root, file), os.path.join(folder, file))
                    
        zipfilename = json_data['folderName']
        
        zipFolderPath = createdFolderPath+".zip";
        
        zipf = zipfile.ZipFile(zipFolderPath, 'w', zipfile.ZIP_DEFLATED)
        
        zipdir(path, zipf)
        zipf.close()
        
        zipSourcePath = zipFolderPath
        
        zipDestinationPath = os.path.join(CURRENT_DIR,'artifacts/')
        
        #To copy the Report folder to Artifacts folder from temp folder 
        process = subprocess.Popen(["sudo", "cp", zipSourcePath , zipDestinationPath], stdout=subprocess.PIPE)
        
        #To delete the Report folder from temp folder 
        process = subprocess.Popen(["sudo", "rm", "-rf", zipFolderPath], stdout=subprocess.PIPE)

        result = str(zipfilename)
        
        return jsonify(status='OK',result=result) 

    except Exception,e:
        return jsonify(status='ERROR',message=str(e))

@app.route('/editFileContent', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def editFileContent():
    try:
        #Initialize
        result = {'file' : '',
                   'mime' : '',
                   'message' : '',
                   'message_css' : '',
                   'download' : '',
                   'showDownload' : False,
                   'containerScroll' : True,
                   'content' : '',
                   'keywords' : ''}
    
        #json_data = request.json
        
        json_data = request.get_json(force=True)
        
        #file = json_data['path']
        file = os.path.join(CURRENT_DIR, json_data['path'].replace("../",""))
        fileContent = json_data['content'].replace("<br>", "\n")
        
        # cleanr = re.compile('<.*?>')
        # cleantext = re.sub(cleanr, '', fileContent)
        #print "584", cleantext
        
        # fileContent = cleantext
        
        # Providing Read, Write and Execute permission to selected featureFiles 
        exePermissionStr = "sudo " + "find " + file + " -type " + "f " + "-exec " + "chmod " + "ugo+rwx " + "{} " +"\;"
        #print "569", exePermissionStr
        ffPermissionChange = subprocess.Popen(exePermissionStr, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
        output, err = ffPermissionChange.communicate()
        temp = ffPermissionChange.returncode
        #print "572", temp

        if temp == 0:
            with open(file, "w") as f:
                #print "575"
                f.write(fileContent)
        else: 
            print "Write permission not granted to the feature file"

        mime = MimeTypes()
        mime_type = mime.guess_type(urllib.pathname2url(file))[0] if mime.guess_type(urllib.pathname2url(file))[0] else 'text/plain' 
        result['file'] = file
        result['mime'] = mime_type
        download_html = ''
        download_html+='<div class="">'
        download_html+='<a class="btn-download btn btn-lg btn-primary" href="' + file + '" target="_blank"><i class="glyphicon glyphicon-download-alt"></i> Download</a>'
        download_html+='</div>'
        result['download'] = download_html
        
        supported_application = ['application/xml', 'text/x-php', 'text/plain', 'text/xml', 'text/csv' ]
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
                #print "569"
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
            html_content+= '<object data="' + file + '" type="' + mime_type + '" id="fileObject" style="width:100% ">'
            html_content+='<embed type="' + mime_type + '" src="' + file + '" style="width:100%">'
            html_content+='</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = False
        else:
            html_content = ''
            html_content+= '<object data="' + file + '" type="' + mime_type + '" id="fileObject" style="width:100% " class="hidden">'
            html_content+='<embed type="' + mime_type + '" src="' + file + '" style="width:100%">'
            html_content+='</object>'
            result['content'] = html_content
            result['containerScroll'] = False
            result['showDownload'] = True
       
        return jsonify(status='OK',result=result)
        
    except Exception,e:
        return jsonify(status='ERROR',message=str(e))


@app.route('/getReportContent', methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def getReportContent():
    try:
        #Initialize
        result = {'file' : '',
                   'mime' : '',
                   'message' : '',
                   'message_css' : '',
                   'download' : '',
                   'showDownload' : False,
                   'containerScroll' : True,
                   'content' : '',
                   'keywords' : ''}
    
        json_data = request.get_json(force=True)      
        file = os.path.join(CURRENT_DIR, json_data['path'].replace("../",""))
        #print "632", file
        
        pdfName = file.split("/")[-1].split(".")[0]
        
        reportDate = file.split("/")[-3]
        #print "636", reportDate 
        
        pdfName = pdfName + "_" + reportDate + ".pdf"
        #print "639", pdfName

        BASE_DIR = os.path.join(CURRENT_DIR, 'abot')
        #print "638", BASE_DIR

        newFilePath = ''
        
        # load the file
        with open(file) as fp:
            #print "649"
            soup = BeautifulSoup(fp)
            
            # Remove header and footer from html
            soup.find(attrs={"id" : "fullwidth_header"}).extract()
            soup.find(attrs={"class" : "footer"}).extract()
           
            for a in soup.findAll('a'):
                # Delete the link from  
                del a['href']

            #print "666", (os.path.isdir("temp"))
            
            if not os.path.isdir("temp"):
                print "670"
                os.makedirs("temp");

            #print(os.path.exists("/home/el/myfile.txt"))

            tempdir = os.path.join(CURRENT_DIR,'abot/temp')
            #print "652", tempdir
            delTempFilesCmd = "rm"+" -rf"+" temp/*.pdf"
            #print "653", delTempFilesCmd
            
            # delete temp folder content    
            delTempFile = subprocess.Popen(delTempFilesCmd, stdout=subprocess.PIPE, shell=True)
             
            newFilePath = os.path.join(tempdir, "output.html")

            with open(newFilePath, "w") as f:
                #print "684"
		f.write(str(soup))
                f.close()

        bindir = os.path.join(CURRENT_DIR,'abot/bin')
        #print "692", bindir

        # Set execution permission for wkhtmltopdf file
        # find /opt/lampp/htdocs -type f -exec chmod 777 {} \;
        exePermissionStr = "find " + bindir + "/wkhtmltopdf" + " -type " + "f " "-exec" + " chmod " + "ugo+x " + "{} " +"\;"
        #print "697", exePermissionStr
        binPermission = subprocess.Popen(exePermissionStr, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
        #print "701", binPermission
        
        # create pdf file - cat test.html | ./wkhtmltopdf - test.pdf
        strs = "cat "+newFilePath+" | bin/wkhtmltopdf - "+pdfName
        process = subprocess.Popen(strs, stdout=subprocess.PIPE, shell=True)
        
        #output, err = process.communicate(b"input data that is passed to subprocess' stdin")
        output, err = process.communicate()
        rc = process.returncode
        
        if rc==0:
            # move pdf file to temp dir from bas dir - mv 002-sip_register.pdf temp/
            mvFile = subprocess.Popen(["mv " + BASE_DIR +"/"+ pdfName + " temp/"], stdout=subprocess.PIPE, shell=True)
            output, err = mvFile.communicate()
            mvFileval = mvFile.returncode
            
        if mvFileval==0:
            result['download'] = pdfName
            result['showDownload'] = True

        return jsonify(status='OK',result=result)
        
    except Exception,e:
        return
        #return jsonify(status='ERROR',message=str(e))


@app.route('/downloadReport', methods=['GET','OPTIONS'])
@crossdomain(origin='*')
def downloadReport():
    try:
        tempdir = os.path.join(CURRENT_DIR,'abot/temp/')
        #print "735", tempdir

        filename = request.args.get('file')
        #print "732", file
        return send_from_directory(tempdir,filename, as_attachment=True, mimetype='application/pdf')
               
    except Exception,e:
        return
        #return jsonify(status='ERROR',message=str(e))

def allowed_file(filename):
    #print "793"
    return '.' in filename and \
        filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

@app.route("/uploads", methods=['POST','OPTIONS'])
@crossdomain(origin='*')
def uploads():
    #print "799"
    if request.method == 'POST':
        file = request.files['file']
        path = request.values['path']
        searchFfDir = os.path.join(CURRENT_DIR, 'featureFiles');
        if file and allowed_file(file.filename):
            #print "812",file.read()
            filename = secure_filename(file.filename)
            if path =="":
                featureFile_DIR = os.path.join(CURRENT_DIR, 'featureFiles')
            else: 
                path = path.replace("../","")
                #print "820----path----", path
                featureFile_DIR = os.path.join(CURRENT_DIR, path)
                #print "822------", featureFile_DIR
            filePath = os.path.join(featureFile_DIR, filename)
            
            baseFileName = filename.split(".")[0]
            fileNameExt = filename.split(os.extsep, 1)[-1]
            #print "822", fileNameExt

            timestr = time.strftime("%Y%m%d-%H%M%S")
            
            for (dir,subdirs,files) in os.walk(searchFfDir):
                if filename in files:
                    #print "836", ("Found:", os.path.join(dir, filename))
                    filename = baseFileName+"_"+str(timestr)+"."+fileNameExt   

            file.save(os.path.join(featureFile_DIR, filename))
            return jsonify(status='OK',result='success')
            
        else:
            return jsonify(status='Error',result='Error')
            
@app.route('/abot/api/v5/graph/packet_counters', methods=['GET'])
@crossdomain(origin='*')
def get_packet_counters():
    packet_counters_response = packet_counters()
    if packet_counters_response is None:
        return make_response(jsonify( { 'error': 'Internal Server Error' } ), 500)
    return packet_counters_response, 200

@app.route('/abot/api/v5/graph/transaction_counts', methods = ['GET'])
@crossdomain(origin='*')
def get_transaction_counts():
    mongo_document_json = transaction_counts()
    return mongo_document_json, 200

@app.route('/abot/api/v5/graph/procedure_completions', methods = ['GET'])
@crossdomain(origin='*')
def get_procedure_completions():
    mongo_document_json = procedure_completions()
    return mongo_document_json, 200

@app.route('/abot/api/v5/graph/uplink_downlink_bandwidth', methods = ['GET'])
@crossdomain(origin='*')
def get_uplink_downlink_bandwidth():
    mongo_document_json = uplink_downlink_bandwidth()
    return mongo_document_json, 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, threaded=True)  
