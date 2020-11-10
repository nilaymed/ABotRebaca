###########################################################################################
#                          Date: <06/30/2020> Version: <5.0.0>                            #
#                                 Author Name:Nikhil Shet                                 #
###########################################################################################
@RefApp-Player-LiveRepeatedClickFwRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-LiveRepeatedClickFwRw-Steps

    Scenario: Verify Repeated Click Forward & Rewind for WMC & UMC
        # Trail-1
        # Verify Drag forward during playback
        When I click the Video-Seek-bar towards right by 60%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Verify Drag rewind during playback
        When I click the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state


        #Performing restart functionality,inorder give some buffer time for Click Forward as in LIVE media cant do click forward while in live position
        When I restart the media
        Then I validate the media resumed from initial state
        And I wait for 10 seconds

        # Trail-2
        # Verify Drag forward during playback
        When I click the Video-Seek-bar towards right by 50%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Verify Drag rewind during playback
        When I click the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state