###########################################################################################
#                            Date: <07/04/2020> Version: <5.0.0.ALPHA>                          #
#				            Author Name: Puspendu Sarkar                                 #
###########################################################################################
@RefApp-PlaybackBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PlaybackBlocked-Steps

    Scenario: Perform basic Playback blocked IMC error check in console logs

        Given I expect that the next step will fail
        When I play the media
        And I wait for 5 seconds