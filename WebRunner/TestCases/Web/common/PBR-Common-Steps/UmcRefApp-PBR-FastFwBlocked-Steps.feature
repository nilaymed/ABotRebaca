###########################################################################################
#                            Date: <06/26/2020> Version: <4.3.0>                          #
#				      Author Name: Abdul Khadeer D                                        #
###########################################################################################
@UmcRefApp-PBR-FastFwBlocked-Steps @WEB_LIBRARY
Feature: UmcRefApp-PBR-FastFwBlocked-Steps

  Scenario: Perform Fastforward to test FastFwBlocked.

    # Pre-condition
    
    # Verifying the FastFw is blocked PBR during media playback
	Given I expect that the next step will fail
    When I 1x-fast-forward the media for 5 seconds
    And I wait for 15 seconds
    Then I validate that the media is in playing state
