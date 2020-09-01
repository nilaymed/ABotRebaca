@OTT_Mobile_Test 

Feature: Youtube-7_1_1_Init

Scenario: Create global system configuration

Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I initialize the mobile-device Device1 and launch the application

Then I validate YouTubeLogo text to be present on window 

When I click on the element Search button

Given I input Steve jobs iphone launch on SearchBox textbox

And I play the media at index position 2 for 5 seconds

Then I validate that the media is in playing state

When I fast-forward the media for 5 times

Then I validate that the media moved forward

When I rewind the media for 2 time

Then I validate that the media moved reverse
       
#And I stop the player on device {abotprop.Android.Device1.Identification.String}



