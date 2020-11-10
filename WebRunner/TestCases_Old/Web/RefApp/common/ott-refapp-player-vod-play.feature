@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: RefApp_Player_VOD_Play

  Scenario: Play VOD
	# Verify the Pause and Resume playback of VOD media.
			
	When I play-pause the media
	Then I validate that the media is in paused state
	
	Given I run the feature OTT-Common-RefApp-Stepss
	
	And I wait for 10 seconds
	Then I validate that the media is in playing state