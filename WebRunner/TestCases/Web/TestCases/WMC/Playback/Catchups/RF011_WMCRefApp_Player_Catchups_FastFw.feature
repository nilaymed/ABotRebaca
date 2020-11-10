###########################################################################################
#                              Date: <06/28/2020> Version: <5.0.0>                        #
#								  Author Name: Suman Saw                                  #
###########################################################################################
@SanityCheck
@WMC_SanityCheck

Feature: RF011_WMCRefApp_Player_Catchups_FastFw

	Scenario: Run the refapp player to verify the Fast Forward Playback of Catchup media.
	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete
    Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	
	And I use the message-id RF_TSB_CATCHUP
    
    # Call common step
	Given I run the feature RefApp-Player-WebTSB-Steps
	
	# Verifying playback start for Catchup media
	Given I run the feature RefApp-Player-Start-Steps
	
    # Verifying that Fast_Forward 2x/1x  for Catchup media
    Given I run the feature WmcRefApp-Player-FastFw-Steps
	
    # Clicking on the Stop button to stop the playback
	Given I run the feature RefApp-Player-Stop-Steps
	


