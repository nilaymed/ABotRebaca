###########################################################################################
#                            Date: <06/26/2020> Version: <4.3.0>                          #
#				      Author Name: Debanjan Bhattacharjee                                 #
###########################################################################################
@WmcRefApp-PBR-FastFwBlocked-Steps @WEB_LIBRARY
Feature: WmcRefApp-PBR-FastFwBlocked-Steps

  Scenario: Perform Fastforward to test FastFwBlocked.

    # Pre-condition
    
    # Verifying the FastFw is blocked PBR during media playback
	Given I expect that the next step will fail
    When I 2x-fast-forward the media for 10 seconds
    Then I validate that the media is in playing state
    And I wait for 10 seconds
    When I 1x-fast-forward the media for 10 seconds
	Then I validate that the media is in playing state	
