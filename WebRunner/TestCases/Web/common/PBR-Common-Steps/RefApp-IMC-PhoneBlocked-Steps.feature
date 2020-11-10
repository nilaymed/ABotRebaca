###########################################################################################
#                            Date: <07/12/2020> Version: <5.0.1>                           #
#				            Author Name: Nikhil Shet                                       #
###########################################################################################
@RefApp-IMC-PhoneBlocked-Steps @WEB_LIBRARY
Feature: RefApp-IMC-PhoneBlocked-Steps

    Scenario: Perform Phone blocked IMC error check in Message Box

        Then I validate the following from message box
            | Parameter     | Value |
            | IMC.ErrorCode | 208   |
