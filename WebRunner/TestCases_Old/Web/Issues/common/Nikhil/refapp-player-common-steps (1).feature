@RefApp-Player-Common-Steps @WEB_LIBRARY
Feature: RefApp-Player-Common-Steps1

  Scenario: Create global system configuration
    # Pre-condition
    Given the refapp app is loaded successfully
    
    # Start-up LIVE
    When I open the Home page
    Then I validate ApplicationTitleMessage text to be present on page
    When I input OTTAppRequestURL on Request URL (ACC) textbox
    And I input OwnerName on Owner UID textbox
    And I input Token on User token textbox
    And I input MediaIndentifier on Media UID textbox
    And I select VoDLIVE option from Playback mode dropdown
    And I input UserEmail on Primary user textbox
    And I input TenantIdentifier on Tenant Id textbox
	And I input AppTokenValue on app_token textbox
