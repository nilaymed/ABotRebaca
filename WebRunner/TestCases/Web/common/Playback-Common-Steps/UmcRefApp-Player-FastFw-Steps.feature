@UmcRefApp-Player-FastFw-Steps @WEB_LIBRARY
Feature: UmcRefApp-Player-FastFw-Steps

  Scenario: Verify the progress bar Fast Forward functionality during the Playback 
    # Pre-condition
    
    #Verify the Fast forward 
    When I 1x-fast-forward the media for 5 seconds
    #When I play-pause the media
    And I wait for 10 seconds
    Then I validate that the media is in playing state
	
