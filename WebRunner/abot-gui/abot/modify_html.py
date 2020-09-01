#!/usr/bin/env python3
import sys, os
import shutil
from distutils.dir_util import copy_tree
from tempfile import NamedTemporaryFile

def modifyFile(baseDir, file_end):
    """
    Iterate through the baseDir and change the content of the file endswith "file_end"
    
    @baseDir: directory path
    @file_end: file ending string
    """
    
    currentDir = os.path.dirname(os.path.abspath("__file__"))
    
    try:
        for root, directories, filenames in os.walk(baseDir):
            for filename in filenames:
                if filename.lower().endswith(file_end):
                    file_path = os.path.join(root, filename)
                    tempfile = NamedTemporaryFile(delete=False)
                    
                    # Copying the external directory as js directory
                    external_dir = os.path.join(currentDir, 'static', 'external')
                    js_dir = os.path.join(os.path.dirname(file_path), 'js')
                    copy_tree(external_dir, js_dir)
                    
                    # Replacing cucumber logo with abot logo
                    abot_logo = os.path.join(currentDir, 'static', 'external', 'logo.png')
                    cucumber_logo = os.path.join(os.path.dirname(file_path), 'blue', 'images', 'logo.png')
                    shutil.copy(abot_logo, cucumber_logo)
                                               
                    # Replacing the external links with local links       
                    with open(file_path) as f:
                        data = f.read()
                        data = data.replace("http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js", "js/jquery.min.js")
                        data = data.replace("https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.7.1/css/lightbox.css", "js/lightbox.css")
                        data = data.replace("https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.7.1/js/lightbox.min.js", "js/lightbox.min.js")
                        
                        tempfile.file.write(data)
                        tempfile.flush()
                        tempfile.close()
                    
                    shutil.copy(tempfile.name, file_path)
                    os.chmod(file_path, 0766)
                
                if filename.lower().endswith(".html"):
                    # Replace the footer
                    file_path = os.path.join(root, filename)
                    tempfile = NamedTemporaryFile(delete=False)
                    
                    with open(file_path) as f:
                        data = f.read()
                        footer = "<a href=\"https://github.com/damianszczepanik/jenkins-cucumber-jvm-reports-plugin-java\">Cucumber-JVM Jenkins Report Plugin</a> - version: cucumber-reporting-0.2.1"
                        new_footer = "<span>Copyright <i class=\"fa fa-copyright\" aria-hidden=\"true\"></i> 2017-2018. Rebaca-IXIA<span>"
                        data = data.replace(footer, new_footer)
                        
                        tempfile.file.write(data)
                        tempfile.flush()
                        tempfile.close()
                    
                    shutil.copy(tempfile.name, file_path)
                    os.chmod(file_path, 0766)
    except Exception,e:
        raise

        
if __name__ == "__main__":
    """
    How to run:
    sudo python modify_html.py /etc/rebaca-test-suite/artifacts/16Oct2017-064504AM-UTC
                                 OR
    sudo python modify_html.py /etc/rebaca-test-suite/artifacts                             
    """
    baseDir = sys.argv[1:][0] if sys.argv[1:] else '.'
    file_end = sys.argv[1:][1:]
    if not os.path.exists(baseDir):
        raise OSError("\"%s\" path doesn't exist" %(baseDir))
        
    modifyFile(baseDir, file_end if file_end else 'feature.html')

