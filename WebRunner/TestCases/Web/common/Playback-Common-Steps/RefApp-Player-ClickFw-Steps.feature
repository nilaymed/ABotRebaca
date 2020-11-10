@RefApp-Player-ClickFw-Steps @WEB_LIBRARY
Feature: RefApp-Player-ClickFw-Steps

    Scenario: Verify Click forward functionality for WMC & UMC
        # Verifying Drag Forward
        When I click the Video-Seek-bar towards right by 30%
        And I wait for 15 seconds
        Then I validate that the media is in playing state