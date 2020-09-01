###########################################################################################
#                              Date: <04/10/2020> Version: <1.0>                          #
###########################################################################################
@RefApp-Player_Oauth_Token_From_Message_Bundle

Feature: RefApp-Player_Oauth_Token_From_Message_Bundle

  Scenario: Run the refapp player to verify the OAuth token input from message-bundle
    
    Given all configured endpoints for WEB are connected successfully
     
    Given the steps below will be executed at the end
    Then I terminate the driver
    Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/RefAppMessageBundle.xml
		
	Given I run the feature RefApp-Common-Step-validate-player-current-state
	# Custom steps
	And I use the message-id RFVDLV003
	Given the refapp app is loaded successfully
	When I open the Home page
	Then I validate ApplicationTitleMessage_3 text to be present on page
	When I input OTTAppRequestURL_3 on Request URL (ACC) textbox
	And I input OwnerName_3 on Owner UID textbox
	And I input Token_3 on User token textbox
	And I input MediaIndentifier_3 on Media UID textbox
	And I select VoDLIVE_3 option from Playback mode dropdown
	And I input UserEmail_3 on Primary user textbox
	And I input TenantIdentifier_3 on Tenant Id textbox
	And I input AppTokenValue_3 on app_token textbox
	And I input STSTokenValue_3 on STSToken textbox
		
	When I play the media for 30 seconds
    Then I validate that the media is in playing state
	And I stop the media
		
	Then I terminate the web driver
	Given I run the feature RefApp-Common-Step-validate-player-current-state
		
				