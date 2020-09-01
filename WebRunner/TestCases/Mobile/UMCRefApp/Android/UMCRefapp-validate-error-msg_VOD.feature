###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMCMobile_Error_msg
@UMC_RefApp_Sanity


Feature: RefApp_Player_VoD_Message_Box
Scenario: Run the UMCRefApp player to validate error message from message box


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMCRefApp-Player-Common-Steps_VOD

# Verify the Start Playback of VOD media
Given I expect that the next step will fail
Given I play the media for 15 seconds

Then I validate the following from message box
	| Parameter        | Value |
    | IMC.ErrorCode	   | 210   |









