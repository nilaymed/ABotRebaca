@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: RefApp_Player_VOD_Playy

  Scenario: Play VOD
	# Verify the Pause and Resume playback of VOD media.
			
	And I input Default_Media1000 on Media UID textbox
    Given I expect that the next step will fail
    When I play the media for 15 seconds