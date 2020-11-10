#############################################################################################
#                              Date: <06/12/2020> Version: <4.3.0>                        #
#                          			Nithin                                                #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF007_WMCRefApp_Player_CompRecording_DragFw

Scenario: Run the refapp player to verify the Drag forward playback of Recording media.
#Pre-Condition   
    Given all configured endpoints for WEB are connected successfully

    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
    And I use the message-id RF_DVR_COMPLETED   

# Call common step
    Given I run the feature RefApp-Player-Common-Steps

# Verifying the start of the playback of DVR media
    Given I run the feature RefApp-Player-Start-Steps

# Verify the drag forward on progress bar during playback of  Recording media
    Given I run the feature RefApp-Player-DragFw-Steps

# Clicking on the Stop button to stop the playback
    Given I run the feature RefApp-Player-Stop-Steps

