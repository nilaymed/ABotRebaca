###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-RepeatedDragFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedDragFw-Steps

  Scenario: Verify Repeated Drag Forward for WMC & UMC
# Trail-1 - Verify Drag forward during playback
    When I drag the Video-Seek-bar towards right by 20%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Trail-2 - Verify Drag forward during playback
    When I drag the Video-Seek-bar towards right by 30%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Trail-3 - Verify Drag forward during playback
    When I drag the Video-Seek-bar towards right by 40%
    And I wait for 20 seconds
    Then I validate that the media is in playing state