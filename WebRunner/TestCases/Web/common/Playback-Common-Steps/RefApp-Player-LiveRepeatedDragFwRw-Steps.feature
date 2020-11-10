###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-LiveRepeatedDragFwRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-LiveRepeatedDragFwRw-Steps

    Scenario: Verify Repeated Drag Forward & Rewind for WMC & UMC
        # Trail-1
        # Verify Drag forward during playback
        When I drag the Video-Seek-bar towards right by 60%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Verify Drag rewind during playback
        When I drag the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        #Performing restart functionality,inorder give some buffer time for Drag Forward as in LIVE media cant do Drag forward while in live position
        When I restart the media
        Then I validate the media resumed from initial state
        And I wait for 10 seconds

        # Trail-2
        # Verify Drag forward during playback
        When I drag the Video-Seek-bar towards right by 50%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Verify Drag rewind during playback
        When I drag the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state