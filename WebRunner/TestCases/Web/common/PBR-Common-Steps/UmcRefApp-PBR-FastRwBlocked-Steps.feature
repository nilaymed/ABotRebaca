###########################################################################################
#                            Date: <06/26/2020> Version: <4.3.0>                          #
#				      Author Name: Abdul Khadeer D                                        #
###########################################################################################
@UmcRefApp-PBR-FastRwBlocked-Steps @WEB_LIBRARY
Feature: UmcRefApp-PBR-FastRwBlocked-Steps

  Scenario: Perform Fastrewind to test FastRwBlocked.

    # Pre-condition
    
    # Verifying the FastRw is blocked PBR during media playback
	Given I expect that the next step will fail
	When I 1x-rewind the media for 5 seconds
	And I wait for 15 seconds
	Then I validate that the media is in playing state
