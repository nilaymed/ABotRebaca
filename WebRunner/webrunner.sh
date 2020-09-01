#!/bin/bash
# Executes tag based automation
# Rebaca Technologies 2020
 
# Help message for tool usage
function showUsage(){
 echo "==============================================================================================="
 echo "Usage: webrunner.sh @tag_name"
 echo where tag_name is a well defined tag in a feature file or a tag used for a group of feature file
 echo "==============================================================================================="
 echo "Rebaca Technologies 2020"
 echo "==============================================================================================="
 echo ""	
 exit 0 
}

# Start of execution 

clear
param=$1
home_dir=`pwd`

# check if tag is null 
if [ -z "$param" ]
then
	showUsage     
fi	 

# Check if paramater has an @ tag associated with it
if [[ $param != *"@"* ]]; then
	echo "'@' not present in tag name $param"
        showUsage
	exit 1
fi	
if [[ $param == "@" ]];then
	echo " A tagname must contain an '@' and a 'TAGNAME'. Check command line arguments"
        showUsage
        exit 2
fi

# Prepare teh date time stamp
dateStamp=`date "+%Y%m%d-%H%M%S"`

echo "Starting execution of the test cases with tag :- @$param"

if [ -d  $home_dir/log/webrunner ]; then
	echo "'webrunner' directory exists"
else
	echo "'webrunner' directory does not exists; creating the same"
	mkdir $home_dir/log/webrunner
fi
logFileName=log/webrunner/webrunner_$dateStamp.log
echo "Logs redirected to $logFileName"
mvn -T 4 test -Dtest=WebExecutor -DAutomationOptions.tags=$param -DDisplayHTMLReport=true -Djava.awt.headless=false 2>&1 | tee $logFileName
echo "Test Completed"



