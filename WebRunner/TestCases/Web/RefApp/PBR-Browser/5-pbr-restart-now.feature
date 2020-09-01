###########################################################################################
#                              Date: <06/04/2020> Version: <1.0>                          #
###########################################################################################
@PBRtag
@PBRtag_5
Feature: PBR05 RefApp Player RestartNow Blocked LIVE Media

  Scenario: Run the refapp player for PBR validation with Restart in LIVE Media
  
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
    And I select LIVE option from Playback mode dropdown
    And I input 4763 on app_token textbox
    And I input LIVE$11945 on Media UID textbox
    
    When I play the media for 60 seconds
	Then I validate that the media is in playing state
    
    # PBR validation with RestartNow
    When I restart the media
    Given I expect that the next step will fail
	And I validate the media resumed from initial state
	
	Then I validate the following from console logs
	| Parameter    	   | Value |
    | IMC.ErrorCode	   | 231 |

     
    And I stop the media
	Then I validate that the media is in done state
    
    
    