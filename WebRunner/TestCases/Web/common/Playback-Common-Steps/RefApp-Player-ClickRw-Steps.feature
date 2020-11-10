@RefApp-Player-ClickRw-Steps @WEB_LIBRARY
Feature: RefApp-Player-ClickRw-Steps

    Scenario: Verify Click Rewind functionality for WMC & UMC
        # Verifying Drag Forward
        When I click the Video-Seek-bar towards left by 20%
        And I wait for 15 seconds
        Then I validate that the media is in playing state