###########################################################################################
#                              Date: <06/12/2020> Version: <4.3.0-β>                      #
#						           Author Name: Vignesh Sekar                             #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF004_RefApp_Player_VOD_Restart

  Scenario: Run the refapp player to verify the Restart Playback of VOD media
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
	
    # Verify the Restart Playback of VOD media
	Given I run the feature RefApp-Player-Restart-Steps

   	# Verifying stop playback
	Given I run the feature RefApp-Player-Stop-Steps

