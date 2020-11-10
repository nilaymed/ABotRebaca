###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-RepeatedDragRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedDragRw-Steps

  Scenario: Verify Repeated Drag Rewind for WMC & UMC
# Dragging seek bar to the end so that drag back is possible	
    When I drag the Video-Seek-bar towards right by 90%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Trail-1 - Verify Drag Rewind during playback
    When I drag the Video-Seek-bar towards left by 20%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Trail-2 - Verify Drag rewind during playback
    When I drag the Video-Seek-bar towards left by 30%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Trail-3 - Verify Drag rewind during playback
    When I drag the Video-Seek-bar towards left by 40%
    And I wait for 20 seconds
    Then I validate that the media is in playing state