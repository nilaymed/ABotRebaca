###########################################################################################
#                              Date: <06/04/2020> Version: <1.0>                          #
###########################################################################################
@IssueNull
@IssueX1
Feature: PBR01_RefApp_Player_PlayPause_Blocked

  Scenario: Run the refapp player for PBR validation with PlayPause
    Given all configured endpoints for WEB are connected successfully
    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete
    
    # Pre-condition
    Given the refapp app is loaded successfully
    
    # Start-up
    When I open the Home page
    Then I validate HTML5 AMC Web Reference App text to be present on page
    When I input https://ottapp-appgw-amp-a.cip.mr.tv3cloud.com on Request URL (ACC) textbox
    And I input azuki on Owner UID textbox
    And I input 2b791c224ef7e989dd70a0ec18fa301b on User token textbox
    And I input jinadatta@outlook.com on Primary user textbox
    And I input default on Tenant Id textbox
    
    # For VoD (default) playback mode
    And I select VoD (default) option from Playback mode dropdown
    And I input Default1_417_Jitp_Reach_HD on Media UID textbox
    When I play the media for 30 seconds
    Then I validate that the media is in playing state
    
    # PBR validation with Play-Pause
    When I play-pause the media
    Given I expect that the next step will fail
    Then I validate that the media is in paused state
    Then I validate the following from console logs
      | Parameter     | Value |
      | IMC.ErrorCode |   228 |
    And I stop the media
    And I wait for 5 seconds
    
    # For LIVE playback mode
    And I select LIVE option from Playback mode dropdown
    And I input 4778 on app_token textbox
    And I input LIVE$2100010912 on Media UID textbox
    When I play the media for 30 seconds
    Then I validate that the media is in playing state
    
    # PBR validation with Play-Pause
    When I play-pause the media
    Given I expect that the next step will fail
    Then I validate that the media is in paused state
    Then I validate the following from console logs
      | Parameter     | Value |
      | IMC.ErrorCode |   228 |
    And I stop the media
    Then I validate that the media is in done state
