###########################################################################################
#                              Date: <06/12/2020> Version: <4.3.0.Beat>                   #
#							   	Author Name: Vignesh Sekar                                #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF003_RefApp_Player_VOD_PauseResume

    Scenario: Run the refapp player to verify the Pause and Resume playback of VOD media.
	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

    And I use the message-id RF_VOD

    # Call common step
    Given I run the feature RefApp-Player-Common-Steps

    # Verifying the start of the VOD playback.
	Given I run the feature RefApp-Player-Start-Steps
	

    # Verify the Pause and Resume playback of VOD media.
	Given I run the feature RefApp-Player-PauseResume-Steps

    # Clicking on the Stop button to stop the playback
	Given I run the feature RefApp-Player-Stop-Steps

    # Terminate the web driver

