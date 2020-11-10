###########################################################################################
#                            Date: <07/04/2020> Version: <5.0.0.ALPHA>                          #
#				            Author Name: Puspendu Sarkar                                 #
###########################################################################################
@RefApp-IMC-SkipFwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-IMC-SkipFwBlocked-Steps

    Scenario: Perform Skip Forward blocked IMC error check in console logs

        Then I validate the following from console logs
            | Parameter     | Value |
            | IMC.ErrorCode | 224   |
        And I wait for 5 seconds