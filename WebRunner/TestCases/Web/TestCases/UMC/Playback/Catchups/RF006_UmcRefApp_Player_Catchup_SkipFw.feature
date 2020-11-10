###########################################################################################
#                              Date: <06/28/2020> Version: <5.0.0>                        #
#								  Author Name: Suman Saw                                  #
###########################################################################################
@Sanity-CatchupCheck
@SanityCheck

Feature: RF006_UmcRefApp_Player_Catchup_SkipFw

	Scenario: Verify Skip-Forward in Catchup media playback.
	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
	Then I terminate the driver
	Then the ending steps are complete

	Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
    
	# Pre-condition
	And I use the message-id RF_TSB_CATCHUP
    
	Given I run the feature RefApp-Player-MobileTSB-Steps
	
 	# Verify the Start Playback of Catchup media
    Given I run the feature RefApp-Player-Start-Steps

    # Verifying Skip forward
	Given I run the feature RefApp-Player-SkipFw-Steps

	# Clicking on the Stop button to stop the playback
	Given I run the feature RefApp-Player-Stop-Steps
	
