@RefApp-PBR-RestartNowBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-RestartNowBlocked-Steps

    Scenario: Common Steps to Verify the RestartNow blocked

        # Verifying that Restart is actually blocked
        When I restart the media
        Given I expect that the next step will fail
        Then I validate the media resumed from initial state
        And I wait for 5 seconds
