###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMC_AMC_IOS_Skip_Rewind
@UMC_AMC_IOS_Sanity

Feature: UMC_AMC_Skip_Rewind
Scenario: Run the UMCRefApp player to verify the Skip Forward/Reverse(30s) Playback of VOD media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
# Pre-condition
And I use the message-id RFVD003
#And I use the message-id RFVD002	

# Start-up Test by calling the common steps
Given I run the feature UMC_IOS_VOD_Common_Steps_Demo

# Verify the Start Playback of VOD media

Given I play the media for 10 seconds

Then I validate that the media is in playing state

When I skip-rewind the media for 1 time
And I wait for 5 seconds
Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state








