###########################################################################################
#                              Date: <04/18/2020> Version: <3.0>                          #
#									Author Name: PruthviNath                              #
###########################################################################################
@RefApp-PBR
@RefApp-Player_R312
@RF002_WmcRefApp_PBR_VoD_SkipFw_In_PauseResumeBlkMedia
@MBX
Feature: A

   Scenario: Run the Refapp player to verify the Seek_Skip_forward functionality in Pause/Resume blocked VOD media.

	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete


    Given the test data is in file /TestCases/Web/Issues/SumanMessageBundle/WebMesageBundleSuman.xml

    And I use the message-id PBR_VOD_PauseResumeBlk

    # Call common step
	Given I run the feature RefApp-Player-Common-Steps

    # Verifying Skip forward functionality along with Pause/Resume blocked functionality in a pause/resume blocked VOD media

	# Verifying the playback
	When I play the media for 25 seconds
	Then I validate that the media is in playing state

    # Verifying Skip forward
	Then I 2x-fast-forward the media for 1 time
    And I wait for 10 seconds
	And I validate media has been played for 15 seconds
	And I validate that the media is in playing state

	# Verifying that Pause/Resume blocked for VoD media
	When I play-pause the media
    Given I expect that the next step will fail
    Then I validate that the media is in paused state
	
	# Clicking on the Stop button to stop the playback
	Then I stop the media

# Terminate the web driver

