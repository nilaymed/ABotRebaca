###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-Stop-Steps @WEB_LIBRARY
Feature: RefApp-Player-Stop-Steps

  Scenario: Verify Stop Playback for WMC & UMC
# Clicking on the Stop button to stop the playback
    When I stop the media
    And I wait for 5 seconds
    Then I validate that the media is in done state