###########################################################################################
#                              Date: <26/23/2020> Version: <4.3.0>                        #
#                                    Vignesh Sekar                                        #
###########################################################################################
@RefApp-Player-SkipFw-Steps @WEB_LIBRARY

Feature: RefApp-Player-SkipFw-Steps

	Scenario: RefApp Player to test SkipFw for playback

   # Verify the Skip Forward(15s) operation on Playback.
	When I skip-forward the media for 1 time
    And I wait for 15 seconds
	Then I validate that the media is in playing state