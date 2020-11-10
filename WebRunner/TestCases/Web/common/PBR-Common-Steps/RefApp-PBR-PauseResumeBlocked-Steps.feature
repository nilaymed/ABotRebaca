@RefApp-PBR-PauseResumeBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-PauseResumeBlocked-Steps

    Scenario: Common Steps to Verify the Pause/Resume blocked

        # Verifying that Pause/Resume blocked
        When I play-pause the media
        Given I expect that the next step will fail
        Then I validate that the media is in paused state

