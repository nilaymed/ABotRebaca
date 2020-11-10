###########################################################################################
#                            Date: <07/12/2020> Version: <5.0.1>                           #
#				            Author Name: Nikhil Shet                                       #
###########################################################################################
@RefApp-IMC-TabletBlocked-Steps @WEB_LIBRARY
Feature: RefApp-IMC-TabletBlocked-Steps

    Scenario: Perform Tablet blocked IMC error check in Message Box

        Then I validate the following from message box
            | Parameter     | Value |
            | IMC.ErrorCode | 209   |
