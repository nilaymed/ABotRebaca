###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_IMC_Play
@WEB_LIBRARY
Feature: FWD_BLK_PLAY
Scenario: Forward blocked common


Given I play the media for 15 seconds

Then I validate that the media is in playing state

Given I expect that the next step will fail
When I skip-forward the media for 1 time

Then I validate the following from console logs
	| Parameter        | Value |
    | IMC.ErrorCode	   | 224   |










