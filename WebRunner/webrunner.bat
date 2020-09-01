:: Executes tag based automation
:: Rebaca Technologies 2020
:: 


@echo off
cls
set parameter=%1
if "%1" == "" goto error
rem - process each of the named files
:again
rem if %1 is blank, we are finished
if "%1" == "" goto end
If NOT "%parameter%"=="%parameter:@=%" (
    echo 
) else (
    goto notfound
)
echo.
echo Executing test cases for tag %1...
SET dtStamp9=%date:~-4%%date:~4,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
echo Started execution with tag %1
rem mvn -T 4 -Dtest=WebExecutor  -DCucumber.options="--tags %1" -DDisplayHTMLReport=true -Djava.awt.headless=false > log/webrunner/webrunner_"%dtStamp9%".log  2>&1
mvn -T 4 test -Dtest=WebExecutor -DAutomationOptions.tags=%1 -DDisplayHTMLReport=true -Djava.awt.headless=false > log/webrunner/webrunner_"%dtStamp9%".log  2>&1
rem - shift the arguments and examine %1 again
shift
goto again
:error
echo Missing argument!
echo Usage: webrunner.bat  @tag_name
echo where tag_name is a well defined tag in a feature file or a tag used for a group of feature files
echo =================================================================================================
echo Rebaca Technologies 2020
echo =================================================================================================
goto end
:notfound
echo Missing argument!
echo Usage: webrunner.bat  @tag_name
echo tag_name should have a @ before tagname
echo =================================================================================================
echo Rebaca Technologies 2020
echo =================================================================================================
goto end
:end
echo.
echo Done.