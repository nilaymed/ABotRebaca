@RefApp-Player-DragRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-DragRw-Steps

  Scenario: Verify the progress bar Drag(Seek) Backward functionality during the Playback 
    # Pre-condition
    
    # Verify the progress bar Drag(Seek) Backward during the Playback
    Then I drag the Video-Seek-bar towards left by 30%
    And I wait for 15 seconds
    And I validate that the media is in playing state
    And I wait for 5 seconds
	
