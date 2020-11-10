###########################################################################################
#                              Date: <26/23/2020> Version: <4.3.0>                        #
#                                    Vignesh Sekar                                        #
###########################################################################################
@RefApp-Player-Restart-Steps @WEB_LIBRARY

Feature: RefApp-Player-Restart-Steps

	Scenario: RefApp Player to test Restart playback

    # Verify the Restart Playback of a media
	When I restart the media
	Then I validate the media resumed from initial state
	And I wait for 20 seconds
	And I validate that the media is in playing state