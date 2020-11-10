@RefApp-Player-SkipRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-SkipRw-Steps

  Scenario: Verify the Skip Rewind functionality 
    # Pre-condition
    
    #When I skip-rewind the media for 1 time
    When I skip-rewind the media for 1 time
    And I wait for 20 seconds
	Then I validate that the media is in playing state
	
