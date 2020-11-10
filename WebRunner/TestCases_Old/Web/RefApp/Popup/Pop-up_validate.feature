###########################################################################################
#                              Date: <04/10/2020> Version: <1.0>                          #
###########################################################################################
@Pop-ups
@Sanity_Integration
Feature: RefApp Player Pop-up validation

  Scenario: Run the refapp player for Pop-ups validation
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
  	And I terminate the driver
	Then the ending steps are complete
    
    # Pre-condition
    Given the refapp app is loaded successfully
       
    
    # Start-up VOD
    When I open the Home page
    And I validate WMC-SDK HTML5 RefApp text to be present on page
    Then I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com on Request URL (ACC) textbox
    And I input Default1_3255_Jitp_Reach_HD on Media UID textbox
    And I select VoD (default) option from Playback mode dropdown
    And I input jinadatta@outlook.com on Primary user textbox
    And I input default on Tenant Id textbox
    
    Given I expect that the next step will fail
    Then I validate Please give the Media UID! text to be present on pop-up alert
    
    When I click on the element Play button
    Then I validate Please give the Owner UID! text to be present on pop-up alert
    
    And I wait for 5 seconds
    
    Then I accept the pop-up alert
    
    Then I validate Please give the User Token! text to be present on pop-up alert
    
    And I wait for 5 seconds
    
    Then I accept the pop-up alert
    
    Then I stop the media
    
    And I input 2b791c224ef7e989dd70a0ec18fa301b on User token textbox
    And I input azuki on Owner UID textbox
    
    
    When I play the media for 30 seconds
	Then I validate that the media is in playing state
    
    Then I stop the media
    