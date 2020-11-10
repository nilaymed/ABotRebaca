###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Suman                                                #
###########################################################################################

@UmcRefApp-Player-FastRw-Steps @WEB_LIBRARY
Feature: UmcRefApp-Player-FastRw-Steps

  Scenario: Verify the progress bar Fast Rewind functionality during the Playback 
    # Pre-condition
    
    # Verify the Fast Rewind 
    When I 1x-rewind the media for 5 seconds
    When I play-pause the media
    And I wait for 10 seconds
    Then I validate that the media is in playing state
	
