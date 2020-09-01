###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_IOS_Player_Restart
@UMC_IOS_Sanity

Feature: AMC_UMC_IOS_Player_Restart_VOD

Scenario: Verify media playback restart for VOD

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete
	
        Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
	#Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle_pprod.xml
    
    # Pre-condition
    #And I use the message-id RFVD003
    And I use the message-id RFVD002	
    #And I use the message-id RF_VOD

	# Start-up Test by calling the common steps
	Given I run the feature UMC_IOS_VOD_Common_Steps
  
	Given I play the media for 20 seconds

	Then I validate that the media is in playing state
	
	Then I restart the media
	
	Then I validate the player resumed from initial state
	
	And I wait for 5 seconds
  
  When I stop the media
	Then I validate that the media is in done state





