###########################################################################################
#                              Date: <06/23/2020> Version: <4.3.0>                        #
#                                    Nithin                                               #
###########################################################################################
@RefApp-Player-RepeatedDragFwRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-RepeatedDragFwRw-Steps

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
			
# Trail-2 
# Verify Drag forward during playback
    When I drag the Video-Seek-bar towards right by 50%
    And I wait for 20 seconds
    Then I validate that the media is in playing state
		
# Verify Drag rewind during playback
    When I drag the Video-Seek-bar towards left by 40%
    And I wait for 20 seconds
    Then I validate that the media is in playing state