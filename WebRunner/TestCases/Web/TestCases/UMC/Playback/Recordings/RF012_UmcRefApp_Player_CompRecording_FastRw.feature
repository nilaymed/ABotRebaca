###########################################################################################
#                           Date: <06/09/2020> Version: <4.3.0>                          #
#                               Author namae:NITHIN                                      #
###########################################################################################
@Sanity-RecordingsCheck
@SanityCheck

Feature: RF012_UmcRefApp_Player_CompRecording_FastRW
Scenario: Run the UMCRefApp player to verify the fast rewind Playback of CompRecording media

# Pre-condition
    Given all configured endpoints for MOBILEDEVICE are connected successfully

    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
    And I use the message-id RF_DVR_COMPLETED
#Common step call
    Given I run the feature RefApp-Player-Mobile-Steps 

# Verify the Start Playback of CompRecording media

    Given I run the feature RefApp-Player-Start-Steps
 
#verify the Fast Rewind of CompRecording media
	Given I run the feature UmcRefApp-Player-FastRw-Steps

# Clicking on the Stop button to stop the playback
    Given I run the feature RefApp-Player-Stop-Steps








