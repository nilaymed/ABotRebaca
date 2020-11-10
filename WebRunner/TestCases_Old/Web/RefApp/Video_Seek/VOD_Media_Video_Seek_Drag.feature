###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Video_Seek_tag_Drag
@RefApp_Player_VOD_Sanity
@RefApp_Player_Video_Seek_Sanity
@mytag_drag
@Sanity_Integration
Feature: RefApp Player VOD Media Video Seek Drag

  Scenario: Run the refapp player to verify the drag action on Video-Seek-bar of VOD media.
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
    Then the ending steps are complete
    
    # Pre-condition
    Given the refapp app is loaded successfully
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    And I use the message-id RFVD002
    
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
    When I play the media
    And I wait for 60 seconds
    Then I validate that the media is in playing state
    
    # Verify the drag on Video-Seek-bar of VOD media
    Then I drag the Video-Seek-bar towards right by 50%
    
    And I wait for 5 seconds
    
    Then I drag the Video-Seek-bar towards right by 5%
    
    And I wait for 5 seconds
    
    Then I drag the Video-Seek-bar towards left by 30%
    
    And I wait for 5 seconds

    Then I drag the Video-Seek-bar towards right by 70%
    
    And I wait for 5 seconds
    
    Then I drag the Video-Seek-bar towards left by 10%
    
    And I wait for 5 seconds
    
    Then I drag the Video-Seek-bar towards left by 5%
    
    And I wait for 5 seconds
    
    When I stop the media
    Then I validate that the media is in done state
    