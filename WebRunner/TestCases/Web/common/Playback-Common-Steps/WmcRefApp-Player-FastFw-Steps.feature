@WmcRefApp-Player-FastFw-Steps @WEB_LIBRARY
Feature: WmcRefApp-Player-FastFw-Steps

  Scenario: Verifying that Fast_Forward 2x/1x 
    # Pre-condition
    
    # Verifying that Fast_Forward 2x/1x
    When I 2x-fast-forward the media for 10 seconds
	Then I validate that the media is in playing state	
    And I wait for 5 seconds

    When I 1x-fast-forward the media for 10 seconds
	Then I validate that the media is in playing state
    And I wait for 5 seconds
