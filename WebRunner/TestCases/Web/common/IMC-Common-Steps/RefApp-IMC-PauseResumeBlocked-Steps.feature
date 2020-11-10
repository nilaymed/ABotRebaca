###########################################################################################
#                            Date: <07/04/2020> Version: <5.0.0.ALPHA>                          #
#				            Author Name: Puspendu Sarkar                                 #
###########################################################################################
@RefApp-IMC-PauseResumeBlocked-Steps @WEB_LIBRARY
Feature: RefApp-IMC-PauseResumeBlocked-Steps

    Scenario: Perform Pause Resume blocked IMC error check in console logs

        Then I validate the following from console logs
            | Parameter     | Value |
            | IMC.ErrorCode | 228   |
        And I wait for 5 seconds