###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMC_AMC_IOS_Player_UMCMobile_Error_msg
@UMC_AMC_IOS_Sanity

Feature: RefApp_Player_VoD
Scenario: Run the UMCRefApp player to validate error message from message box


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I run the feature UMC_IOS_RefApp-Player-Common-Steps_VOD_Demo
# Verify the Start Playback of VOD media
Given I play the media for 15 seconds

Then I validate that the media is in playing state

Given I expect that the next step will fail
When I skip-forward the media for 1 time

Then I validate the following from console logs
    | Parameter        | Value |
    | IMC.ErrorCode       | 224   |

When I stop the media
Then I validate that the media is in done state

