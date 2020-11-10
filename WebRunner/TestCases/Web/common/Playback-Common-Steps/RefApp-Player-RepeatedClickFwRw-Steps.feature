###########################################################################################
#                          Date: <06/30/2020> Version: <5.0.0>                            #
#                                 Author Name:Nikhil Shet                                 #
###########################################################################################
@RefApp-Player-RepeatedDragFwRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedClickFwRw-Steps

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

        # Trail-2
        # Verify Drag forward during playback
        When I click the Video-Seek-bar towards right by 50%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Verify Drag rewind during playback
        When I click the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state