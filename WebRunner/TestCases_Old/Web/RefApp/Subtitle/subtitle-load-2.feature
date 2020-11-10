###########################################################################################
#                              Date: <06/11/2020> Version: <1.0>                          #
###########################################################################################
@subtitle_load-2
@mytag_subtitle
@Sanity_Integration
Feature: RefApp Player Subtitle with value

  Scenario: Run the refapp player for Subtitle load
  
    Given all configured endpoints for WEB are connected successfully
    
	Given the steps below will be executed at the end
  	And I terminate the driver
	Then the ending steps are complete
    
    # Pre-condition
    Given the refapp app is loaded successfully
        
    # Start-up
    When I open the Home page
    And I validate WMC-SDK HTML5 RefApp text to be present on page
    When I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com on Request URL (ACC) textbox
    And I input azuki on Owner UID textbox
    And I input 2b791c224ef7e989dd70a0ec18fa301b on User token textbox
    And I input jinadatta@outlook.com on Primary user textbox
    And I input default on Tenant Id textbox
    And I input Default1_32933_Jitp_Reach_HD on Media UID textbox
    And I select VoD (default) option from Playback mode dropdown
    
    
        
    When I play the media for 90 seconds
	Then I validate that the media is in playing state
	
	And I wait for 15 seconds
	
	Then I click on the element Subtitle State checkbox
	
	Then I select eng option from Subtitle dropdown
	Then I validate subtitle eng is loaded successfully
	
	And I wait for 5 seconds
	Then I stop the media
	
	
	