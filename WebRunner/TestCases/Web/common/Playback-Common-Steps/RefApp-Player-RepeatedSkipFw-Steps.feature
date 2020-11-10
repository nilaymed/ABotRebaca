###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Suman                                                #
###########################################################################################
@RefApp-Player-RepeatedSkipFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedSkipFw-Steps

Scenario: Verify Repeated Skip Forward for WMC & UMC

	# Verify the repeated skip forward playback of media
    # Loop No. 1
	Then I skip-forward the media for 1 time
    And I wait for 15 seconds
	And I validate that the media is in playing state

    # Loop No. 2
	Then I skip-forward the media for 1 time
    And I wait for 15 seconds
	And I validate that the media is in playing state

    # Loop No. 3
	Then I skip-forward the media for 1 time
    And I wait for 15 seconds
	And I validate that the media is in playing state