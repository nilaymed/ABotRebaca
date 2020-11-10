###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Suman                                                #
###########################################################################################
@RefApp-Player-LongRun-Steps @WEB_LIBRARY
Feature: RefApp-Player-LongRun-Steps

  Scenario: Verify long run playback for WMC & UMC

	# Verify the long run playback of any media
    When I play the media for 300 seconds
	And I validate that the media is in playing state