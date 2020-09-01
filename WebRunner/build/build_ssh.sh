#!/bin/bash
baseDirectory=`pwd`

function cls(){
	clear
}

function info(){
	msg=$1
	echo "INFO $1"	
}

function startBuild(){
	cd $currentDirectory
        mvn clean install
}
info "Starting the build process for $1"
info "================================== "
cd ../../../framework/$1
currentDirectory=`pwd`
cd $currentDirectory
info "Changed to $currentDirectory"
startBuild $1 $currentDirectory

