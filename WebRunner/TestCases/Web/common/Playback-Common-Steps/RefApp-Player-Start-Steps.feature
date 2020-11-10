###########################################################################################
#                              Date: <26/23/2020> Version: <4.3.0>                        #
#                                    Vignesh Sekar                                        #
###########################################################################################

@RefApp-Playback-Start-Steps @WEB_LIBRARY

Feature: RefApp-Player-Start-Steps

	Scenario: RefApp Player start playback

    # Verifying the start playback.(Playing the media for 60secs to make Trick mode to work)
	
	When I play the media for 60 seconds
	Then I validate that the media is in playing state