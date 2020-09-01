#!/bin/bash
baseDirectory=`pwd`

function cls(){
	clear
}

function info(){
	msg=$1
	echo "INFO $1"	
}
clear
info "Clearing existing build from $2"
rm -rf $2
info "Folder deleted $2"
info "==================================="
info "Starting the build process for $1"
info "==================================="
source build_base.sh
cd $baseDirectory
source build_ssh.sh ABOT-SSH
info "======================="
info "Completed successfully"
info "======================="
cd $baseDirectory
source build_ott.sh ABOT-OTT
info "======================="
info "Completed successfully"
info "======================="
cd $baseDirectory
source build_mobile.sh ABOT-MOBILE
info "======================="
info "Completed successfully"
info "======================="
cd $baseDirectory
source build_web.sh  ABOT-WEB
info "======================="
info "Completed successfully"
info "======================="
cd $baseDirectory
source build_jmeter.sh  ABOT-JMETER
info "======================="
info "Completed successfully"
info "======================="
#cd $baseDirectory
#echo "Finished building $1"
