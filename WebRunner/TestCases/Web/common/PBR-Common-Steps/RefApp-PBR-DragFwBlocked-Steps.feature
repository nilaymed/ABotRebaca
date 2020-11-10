###########################################################################################
#                            Date: <05/26/2020> Version: <4.1.0>                          #
#									Author Name:Kanaga Vigneshwari D                      #
###########################################################################################
@RefApp-PBR-DragFwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-DragFwBlocked-Steps

  Scenario: Perform drag forward to test drag-forward is blocked
    # Pre-condition
    
    # Verifying the drag Forward blocked PBR during media playback
	  
	Given I expect that the next step will fail
    When I drag the Video-Seek-bar towards right by 30%
    And I wait for 10 seconds
	Then I validate that the media is in playing state	
