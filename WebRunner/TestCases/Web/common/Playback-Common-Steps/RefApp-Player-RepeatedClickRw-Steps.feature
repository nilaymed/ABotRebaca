###########################################################################################
#                              Date: <06/30/2020> Version: <5.0.0>                        #
#                                   Author Name:NIKHIL SHET                               #
###########################################################################################
@RefApp-Player-RepeatedClickRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedClickRw-Steps

    Scenario: Verify Repeated Click Rewind for WMC & UMC
        # Clicking seek bar to the end so that Click back is possible
        When I drag the Video-Seek-bar towards right by 90%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Trail-1 - Verify Click Rewind during playback
        When I drag the Video-Seek-bar towards left by 20%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Trail-2 - Verify Click rewind during playback
        When I drag the Video-Seek-bar towards left by 30%
        And I wait for 20 seconds
        Then I validate that the media is in playing state

        # Trail-3 - Verify Click rewind during playback
        When I drag the Video-Seek-bar towards left by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state