@RefApp-Common-Step-OAuth
@WEB_LIBRARY
Feature: RefApp-Common-Step-validate-player-current-state 

  Scenario: Create global system configuration to validate RefApp Player current state as playing
    
    # Start-up
    
    Then I validate ApplicationTitleMessage text to be present on page
    When I input OTTAppRequestURL on Request URL (ACC) textbox
    And I input OwnerName on Owner UID textbox
    And I input Token on User token textbox
    And I input MediaIndentifier on Media UID textbox
    And I select VoDLIVE option from Playback mode dropdown
    And I input UserEmail on Primary user textbox
    And I input TenantIdentifier on Tenant Id textbox
    And I input AppTokenValue on app_token textbox
    
    When I play the media for 30 seconds
    Then I validate that the media is in playing state
    And I stop the media
	And I wait for 10 seconds
	