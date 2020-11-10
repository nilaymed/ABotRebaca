###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@UMC_RefApp-Player_Slider_Drag


Feature: UMC_Refapp_Player_Slider_Drag

Scenario: Run the refapp player to verify the drag on Video-Seek-bar of VOD media.
    
Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
    Then I terminate the driver
Then the ending steps are complete    

Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	
And I use the message-id RFVD002
    
# Pre-condition
Given I initialize the mobile-device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|   parameter                | value                              |
|  platformVersion           | 10.0                               |
|  port                      | 4723                               |
|  platformName              | Android                            |
|  application               | UMCRefAPP                          |
|  applicationVersion 		 | 1.0								  |
|  adbHost                   | 127.0.0.1                          |
|  protocol                  | http                               |

Then I validate ApplicationTitleMessage text to be present on page

When I input OTTAppRequestURL on Request URL (ACC) textbox

And I input OwnerName on Owner UID textbox

And I input Token on User token textbox

And I input MediaIndentifier on Media UID textbox

And I select VoDLIVE option from Playback mode dropdown

And I input UserEmail on Primary user textbox

And I input TenantIdentifier on Tenant Id textbox
	
# Verify the drag on Video-Seek-bar of VOD media

When I play the media for 15 seconds

Then I validate that the media is in playing state

Given I drag the Video-Seek-bar towards right by 50%

Then I validate that the media is in playing state

Given I drag the Video-Seek-bar towards left by 30%

Then I validate that the media is in playing state
