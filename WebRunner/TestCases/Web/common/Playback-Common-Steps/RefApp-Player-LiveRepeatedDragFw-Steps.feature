###########################################################################################
#                              Date: <06/30/2020> Version: <5.0.0>                        #
#                               Author Name:NIKHIL SHET                                   #
###########################################################################################
@RefApp-Player-LiveRepeatedDragFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-LiveRepeatedDragFw-Steps

    Scenario: Verify Repeated Drag Forward for WMC & UMC
        # Trail-1 - Verify Drag forward during playback
        When I drag the Video-Seek-bar towards right by 20%
        And I wait for 20 seconds
        Then I validate that the media is in playing state


        #Performing restart functionality,inorder give some buffer time for Drag Forward as in LIVE media cant do Drag forward while in live position
        When I restart the media
        Then I validate the media resumed from initial state
        And I wait for 10 seconds

        # Trail-2 - Verify Drag forward during playback
        When I drag the Video-Seek-bar towards right by 30%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        #Performing restart functionality,inorder give some buffer time for Drag Forward as in LIVE media cant do Drag forward while in live position
        When I restart the media
        Then I validate the media resumed from initial state
        And I wait for 10 seconds

        # Trail-3 - Verify Drag forward during playback
        When I drag the Video-Seek-bar towards right by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state