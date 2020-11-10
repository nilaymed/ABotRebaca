###########################################################################################
#                            Date: <06/26/2020> Version: <4.3.0>                          #
#				      Author Name: Debanjan Bhattacharjee                                 #
###########################################################################################
@RefApp-PBR-DragRwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-DragRwBlocked-Steps

  Scenario: Perform drag rewind to test drag-rewind is blocked
    # Pre-condition
    
    # Verifying the drag rewind blocked PBR during media playback
	Given I expect that the next step will fail
	When I drag the Video-Seek-bar towards left by 30%
    And I wait for 10 seconds
	And I validate that the media is in playing state	
