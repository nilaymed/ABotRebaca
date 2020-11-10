@RefApp-Player-LiveButton-Steps @WEB_LIBRARY
Feature:RefApp-Player-LiveButton-Steps

    Scenario: Verify the  Live button functionality for WMC & UMC
       
        # Verifying Live button
        When I click on the element LIVE button
        And I wait for 10 seconds
        Then I validate the media resumed from LIVE state

