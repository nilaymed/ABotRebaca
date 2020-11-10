###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Suman                                                #
###########################################################################################
@RefApp-Player-RepeatedPauseResume-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedPauseResume-Steps

  Scenario: Verify Repeated Pause Resume for WMC & UMC

	# Verify the Pause and Resume playback of media
    # Loop No. 1
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in paused state
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in resumed state
    And I wait for 10 seconds

    # Loop No. 2
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in paused state
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in resumed state
    And I wait for 10 seconds
    
    # Loop No. 3
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in paused state
	Then I play-pause the media
    And I wait for 10 seconds
	And I validate that the media is in resumed state
    And I wait for 10 seconds