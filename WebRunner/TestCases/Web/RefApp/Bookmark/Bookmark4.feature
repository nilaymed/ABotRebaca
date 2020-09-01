###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@Bookmark4 
@Bookmark_Sanity
@Bookmark_wmc
Feature: Advanced Bookmark Verify bookmark feature for 2 accounts

  Scenario: Run the refapp player to verify bookmark feature for 2 accounts
  
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    
    # Pre-condition
    Given the refapp app is loaded successfully
    And I use the message-id RFVD002
   
    # Start-up VOD for Account1
    When I open the Home page
    When I run the feature RefApp-Common-Step-bookmark-validation
   
    #Enable Bookmark
    #When I click on the element AMC Additional Parameters link
    Then I click on the element Bookmark checkbox
    
    When I play the media for 20 seconds
    Then I validate that the media is in playing state
    
    Then I save current playing time
    
    Given I stop the media
    Then I validate that the media is in done state
    
    And I wait for 5 seconds
    
    #Validate Bookmark
    When I play the media
    Then I validate the player resumed from bookmark state
    
    And I stop the media
    
    And I use the message-id RFVD004
    
    # Start-up VOD for Account2
      When I login to the app-environment Environment1 as User1

    Given the refapp app is loaded successfully
    When I open the Home page
    When I run the feature RefApp-Common-Step-bookmark-validation
    
    #Enable Bookmark
    #When I click on the element AMC Additional Parameters link
    Then I click on the element Bookmark checkbox
    
    When I play the media for 20 seconds
    Then I validate that the media is in playing state
    
    And I drag the Video-Seek-bar towards right by 50%
    
    And I wait for 10 seconds
    
    Given I save current playing time
    
    And I stop the media
    Then I validate that the media is in done state
    
    Then I wait for 5 seconds
    
    #Validate Bookmark
    When I play the media
    Then I validate the player resumed from bookmark state
