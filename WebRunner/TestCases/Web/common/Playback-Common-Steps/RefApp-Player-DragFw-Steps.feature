@RefApp-Player-DragFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-DragFw-Steps

  Scenario: Verify the progress bar Drag(Seek) Forward functionality during Playback 
    # Pre-condition
    
    # Verify the progress bar Drag(Seek) Forward during Playback 
	Then I drag the Video-Seek-bar towards right by 30%
    And I wait for 15 seconds
	And I validate that the media is in playing state
    And I wait for 5 seconds
	
