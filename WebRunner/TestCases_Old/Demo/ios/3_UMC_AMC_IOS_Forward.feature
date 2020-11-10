###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@UMC_AMC_IOS_Forward
@UMC_AMC_IOS_Sanity

Feature: UMC_AMC_Media_Forward
Scenario: UMC/AMC player basic trick plays (Forward)


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml

# Pre-condition
And I use the message-id RFVD005


# Start-up Test by calling the common steps
Given I run the feature UMC_IOS_VOD_Common_Steps_Demo

# Verify the Start Playback of VOD media

Given I play the media for 30 seconds

Then I validate that the media is in playing state

When I 1x-fast-forward the media for 5 seconds

Then I play-pause the media

And I wait for 5 seconds

Then I validate that the media is in playing state

When I stop the media

Then I validate that the media is in done state








