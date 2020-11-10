###########################################################################################
#                              Date: <02/01/2020> Version: <1.0>                          #
###########################################################################################

@Rebaca_App



Feature: Open Rebaca App In Google
Scenario: Open rebaca application in google


Given all configured endpoints for WEB are connected successfully

# Load and login to confluence application
Given the rebaca app is loaded successfully

When I open the Home page

And I validate Email link to be present on page

# Terminate the web driver 
Then I terminate the web driver    








