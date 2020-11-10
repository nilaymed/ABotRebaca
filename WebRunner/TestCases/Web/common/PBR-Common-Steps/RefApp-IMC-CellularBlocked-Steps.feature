###########################################################################################
#                            Date: <07/13/2020> Version: <5.0.1>                           #
#				            Author Name: Nikhil Shet                                       #
###########################################################################################
@RefApp-IMC-CellularBlocked-Steps @WEB_LIBRARY
Feature:RefApp-IMC-CellularBlocked-Steps

    Scenario: Perform Cellular blocked IMC error check in Message Box

        Then I validate the following from message box
            | Parameter     | Value |
            | IMC.ErrorCode | 211   |
