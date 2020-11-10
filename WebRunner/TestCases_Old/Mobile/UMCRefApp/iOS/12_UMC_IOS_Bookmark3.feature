###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@IOS_BookmarkUMC3 @IOS_BookmarkUMC
@IOS_Bookmark_Sanity

Feature: Check Bookmark for 2 different account

  Scenario: Run the refapp player to verify bookmark feature for different account.
    Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
  		Then I terminate the driver
	Then the ending steps are complete

	Given I run the feature UMC_IOS_RefApp-Player-Common-Steps_VOD
    
    #Enable Bookmark
    Then I click on the element Bookmark checkbox
	
	When I play the media for 20 seconds
	Then I validate that the media is in playing state
	
    Then I save current playing time
    
    Given I stop the media
	Then I validate that the media is in done state
	
	Then I wait for 5 seconds
	
	When I login to the app-environment Environment1 as User1
	
	#Enter Account2 details
	#And I input 3a876ed9e9deeae8305ed82690f70a57 in User textbox
	#When I input esawsum@outlook.com in Primary textbox
	#When I input {abotprop.REFAPP.OAUTH.TOKEN2} in STS tokens textbox
	
	Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
    # Pre-condition
    And I use the message-id RFVD015
    
    Given I run the feature UMC_IOS_VOD_Common_Steps
    
    When I play the media for 20 seconds
	Then I validate that the media is in playing state
    
    And I drag the Video-Seek-bar towards right by 50%
    
    And I wait for 10 seconds
    
    Given I save current playing time
    
    And I stop the media
    Then I validate that the media is in done state
    
    Then I wait for 5 seconds
	
	#Validate Bookmark For 2nd account
	When I play the media
	Then I validate the media resumed from bookmark state
    And I wait for 2 seconds
    Then I click on the element Stop button
    And I validate that the media is in done state
    
	