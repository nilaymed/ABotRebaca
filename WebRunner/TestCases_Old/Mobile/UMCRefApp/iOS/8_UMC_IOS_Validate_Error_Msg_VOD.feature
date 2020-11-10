###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMC_IOS_Player_UMCMobile_Error_msg
@UMC_IOS_Sanity

Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to validate error message from message box


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
	#Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle_pprod.xml
    
    # Pre-condition
    #And I use the message-id RFVD003
    And I use the message-id RFVD006	
    #And I use the message-id RF_VOD

	# Start-up Test by calling the common steps
	Given I run the feature UMC_IOS_VOD_Common_Steps
	
# Verify the Start Playback of VOD media
Given I play the media for 15 seconds

Then I validate that the media is in playing state

Given I expect that the next step will fail
#Given I play the media for 15 seconds
When I skip-forward the media for 1 time

Then I validate the following from console logs
    | Parameter        | Value |
    | IMC.ErrorCode       | 224   |
    #| IMC.ErrorCode	   | 210   |

When I stop the media
Then I validate that the media is in done state

