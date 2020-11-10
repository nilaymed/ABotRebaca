###########################################################################################
#                            Date: <05/26/2020> Version: <4.1.0>                          #
#									Author Name:Kanaga Vigneshwari D                      #
###########################################################################################
@RefApp-PBR-SkipFwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-SkipFwBlocked-Steps

    Scenario: Common Steps to Verify the Skip Foward blocked

        # Verifying that Skip Forward blocked
        
        Given I expect that the next step will fail
        When I skip-forward the media for 1 time

