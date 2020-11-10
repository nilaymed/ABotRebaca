###########################################################################################
#                              Date: <07/07/2020> Release: <5.0.1>                        #
#							   Author Name: Nikhil Shet                                   #
###########################################################################################
@Sanity-VoD
@Bookmark-VoD
@10july2020-vod
Feature:RF013_UmcRefApp_BookMark_VOD_BMEnabled_ChkBM_SameBrowserDiffAcc
    Scenario: Run the refapp player to Verify the Book Mark playback in Same device with different user account.
        Given all configured endpoints for MOBILEDEVICE are connected successfully

        Given the steps below will be executed at the end
        When I terminate the driver
        Then the ending steps are complete

        Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

        #Pre-condition

        And I use the message-id RF_VoD_BM_1

        #Call common step

        Given I run the feature RefApp-Player-Mobile-Steps
        #Enable Bookmark
        Then I click on the element Bookmark checkbox

        When I play the media for 30 seconds
        Then I validate that the media is in playing state

        Then I save current playing time

        When I stop the media
        And I wait for 10 seconds
        Then I validate that the media is in done state

        And I wait for 10 seconds

        #Validate Bookmark
        #When I play the media
        #Then I validate the player resumed from bookmark state

        #And I stop the media

        And I use the message-id RF_VoD_Acc_2
        # Start-up VOD for Account2
        When I login to the app-environment Environment1 as User1

        Given I run the feature RefApp-Player-Mobile-Steps

        #Validate Bookmark For 2nd account
        When I play the media
        Then I validate the media resumed from bookmark state
        And I wait for 10 seconds
        Then I click on the element Stop button
        And I wait for 10 seconds
        And I validate that the media is in done state

