#!/usr/bin/env python

from bs4 import BeautifulSoup
from pymodules.flask import jsonify, send_from_directory
from werkzeug.utils import secure_filename
import os
import subprocess
import time
import zipfile


def download_artifact(current_dir, artifact_name):
    try:
        path = os.path.join(current_dir, 'artifacts', artifact_name)
        createdFolderPath = os.path.join(
            current_dir, 'abot/temp', artifact_name)

        def _zipdir(url, ziph):
            length = len(url)
            for root, dirs, files in os.walk(url):
                folder = root[length:]
                for file in files:
                    ziph.write(os.path.join(root, file),
                               os.path.join(folder, file))

        zipfilename = artifact_name
        zipFolderPath = createdFolderPath + '.zip'
        zipf = zipfile.ZipFile(zipFolderPath, 'w', zipfile.ZIP_DEFLATED)
        _zipdir(path, zipf)
        zipf.close()
        zipSourcePath = zipFolderPath
        zipDestinationPath = os.path.join(current_dir, 'artifacts/')

        # To copy the Report folder to Artifacts folder from temp folder
        subprocess.Popen(["sudo", "cp", zipSourcePath,
                          zipDestinationPath], stdout=subprocess.PIPE)
        # To delete the Report folder from temp folder
        subprocess.Popen(["sudo", "rm", "-rf", zipFolderPath],
                         stdout=subprocess.PIPE)

        result = str(zipfilename)

        return jsonify(status='OK', result=result)

    except Exception, e:
        return jsonify(status='ERROR', message=str(e))


def download_report(current_dir, path):
    try:
        result = {'file': '', 'mime': '', 'message': '', 'message_css': '', 'download': '',
                  'showDownload': False, 'containerScroll': True, 'content': '', 'keywords': ''}

        file = os.path.join(current_dir, path.replace("../", ""))
        pdfName = file.split("/")[-1].split(".")[0]
        reportDate = file.split("/")[-3]
        pdfName = pdfName + "_" + reportDate + ".pdf"
        baseDir = os.path.join(current_dir, 'abot')
        newFilePath = ''

        # load the file
        with open(file) as fp:
            soup = BeautifulSoup(fp, "html.parser")

            # Remove header and footer from html
            soup.find(attrs={"id": "fullwidth_header"}).extract()
            soup.find(attrs={"class": "footer"}).extract()

            for a in soup.findAll('a'):
                del a['href']

            if not os.path.isdir("temp"):
                os.makedirs("temp")

            tempdir = os.path.join(current_dir, 'abot/temp')
            delTempFilesCmd = "rm"+" -rf"+" temp/*.pdf"

            # delete temp folder content
            delTempFile = subprocess.Popen(
                delTempFilesCmd, stdout=subprocess.PIPE, shell=True)

            newFilePath = os.path.join(tempdir, "output.html")

            with open(newFilePath, "w") as f:
                f.write(str(soup))
                f.close()

        bindir = os.path.join(current_dir, 'abot/bin')

        # Set execution permission for wkhtmltopdf file
        exePermissionStr = 'chmod +x ' + bindir + '/wkhtmltopdf; chmod +x ' + bindir + '/wkhtmltoimage'
        binPermission = subprocess.Popen(
            exePermissionStr, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)

        # create pdf file - cat test.html | ./wkhtmltopdf - test.pdf
        strs = 'bin/wkhtmltopdf' + ' --load-error-handling ignore ' + \
            newFilePath + ' ' + pdfName
        process = subprocess.Popen(strs, stdout=subprocess.PIPE, shell=True)

        #output, err = process.communicate(b"input data that is passed to subprocess' stdin")
        output, err = process.communicate()
        rc = process.returncode

        if rc == 0:
            # move pdf file to temp dir from bas dir - mv 002-sip_register.pdf temp/
            mvFile = subprocess.Popen(
                ["mv " + baseDir + "/" + pdfName + " temp/"], stdout=subprocess.PIPE, shell=True)
            output, err = mvFile.communicate()
            mvFileval = mvFile.returncode

        if mvFileval == 0:
            result['download'] = pdfName
            result['showDownload'] = True

        return jsonify(status='OK', result=result)

    except Exception:
        return


def upload_feature_files(current_dir, file, path):
    searchFfDir = os.path.join(current_dir, 'featureFiles')
    if file and _allowed_file(file.filename):
        filename = secure_filename(file.filename)
        if path == "":
            featureFile_DIR = os.path.join(current_dir, 'featureFiles')
        else:
            path = path.replace("../", "")
            featureFile_DIR = os.path.join(current_dir, path)
        filePath = os.path.join(featureFile_DIR, filename)
        baseFileName = filename.split(".")[0]
        fileNameExt = filename.split(os.extsep, 1)[-1]
        timestr = time.strftime("%Y%m%d-%H%M%S")

        for (dir, subdirs, files) in os.walk(searchFfDir):
            if filename in files:
                filename = baseFileName+"_"+str(timestr)+"."+fileNameExt
        file.save(os.path.join(featureFile_DIR, filename))
        return jsonify(status='OK', result='success')

    else:
        return jsonify(status='Error', result='Error')


def _allowed_file(filename):
    allowed_extensions = set(['csv', 'feature', 'tst', 'template'])
    return '.' in filename and \
        filename.rsplit('.', 1)[1] in allowed_extensions
