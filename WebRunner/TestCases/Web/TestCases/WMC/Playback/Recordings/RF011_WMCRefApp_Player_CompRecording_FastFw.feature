###########################################################################################
#                               Date: <06/12/2020> Version: <4.3.0>                        #
#								  Author Name: Nithin                                      #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF011_WMCRefApp_Player_CompRecording_FastFw

Scenario: Run the refapp player to verify the Fast Forward playback of Completed recording media.

    Given all configured endpoints for WEB are connected successfully
#Pre-Condition
    Given the steps below will be executed at the end
    When I terminate the driver
    Then the ending steps are complete

    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
    And I use the message-id RF_DVR_COMPLETED   

# Call common step
    Given I run the feature RefApp-Player-Common-Steps

# Verifying playback start for Completed recording media
    Given I run the feature RefApp-Player-Start-Steps
	
# Verifying that Fast_Forward 2x/1x  for Completed recording media
    Given I run the feature WmcRefApp-Player-FastFw-Steps
	
# Clicking on the Stop button to stop the playback
    Given I run the feature RefApp-Player-Stop-Steps
