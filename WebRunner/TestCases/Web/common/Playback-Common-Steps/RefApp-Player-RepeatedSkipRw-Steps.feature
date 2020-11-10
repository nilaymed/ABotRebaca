###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-RepeatedSkipRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedSkipRw-Steps

  Scenario: Verify Repeated Skip Rewind for WMC & UMC
# Trail-1 - Verify Skip rewind during playback
    When I skip-rewind the media for 1 time
    And I wait for 30 seconds
    Then I validate that the media is in playing state
		
# Trail-2 - Verify Skip rewind during playback
    When I skip-rewind the media for 1 time
    And I wait for 30 seconds
    Then I validate that the media is in playing state
		
# Trail-3 - Verify Skip rewind during playback
    When I skip-rewind the media for 1 time
    And I wait for 30 seconds
    Then I validate that the media is in playing state