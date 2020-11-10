###########################################################################################
#                              Date: <06/30/2020> Version: <5.0.0>                        #
#                                    Author name:Nikhil Shet                              #
###########################################################################################
@RefApp-Player-RepeatedClickFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedClickFw-Steps

    Scenario: Verify Repeated Click Forward for WMC & UMC
        # Trail-1 - Verify Click forward during playback
        When I click the Video-Seek-bar towards right by 20%
        And I wait for 20 seconds
        Then I validate that the media is in playing state
        And I wait for 20 seconds

        # Trail-2 - Verify Click forward during playback
        When I click the Video-Seek-bar towards right by 30%
        And I wait for 20 seconds
        Then I validate that the media is in playing state
        And I wait for 20 seconds

        # Trail-3 - Verify Click forward during playback
        When I click the Video-Seek-bar towards right by 40%
        And I wait for 20 seconds
        Then I validate that the media is in playing state