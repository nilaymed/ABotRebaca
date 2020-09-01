###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@WMC_RefApp-Player_Slider_Drag


Feature: WMC_Refapp_Player_Slider_Drag

Scenario: Run the refapp player to verify the drag on Video-Seek-bar of VOD media.
    
Given all configured endpoints for WEB are connected successfully

Given the steps below will be executed at the end
    Then I terminate the driver
Then the ending steps are complete    

Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml
	
And I use the message-id RFVD002
    
# Pre-condition
Given the refapp app is loaded successfully
    
# Start-up VOD
When I open the Home page

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
