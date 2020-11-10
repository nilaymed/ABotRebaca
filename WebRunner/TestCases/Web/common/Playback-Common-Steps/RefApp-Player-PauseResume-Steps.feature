###########################################################################################
#                              Date: <26/23/2020> Version: <4.3.0>                        #
#                                    Vignesh Sekar                                        #
###########################################################################################
@RefApp-Player-PauseResume-Steps @WEB_LIBRARY

Feature: RefApp-Player-PauseResume-Steps

	Scenario: RefApp Player to test PauseResume for playback

	# Verify the Pause and Resume playback of a media.
	When I play-pause the media
    And I wait for 10 seconds
	Then I validate that the media is in paused state
	When I play-pause the media
	And I wait for 10 seconds
    Then I validate that the media is in resumed state
    And I wait for 10 seconds