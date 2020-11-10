###########################################################################################
#                            Date: <05/26/2020> Version: <4.1.0>                          #
#									Author Name:Suruthi                                    #
###########################################################################################
@RefApp-PBR-SkipRwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-PBR-SkipRwBlocked-Steps

    Scenario: Common Steps to Verify the SkipRewindBlocked

        # Verifying that SkipRewind blocked
        Given I expect that the next step will fail
        When I skip-rewind the media for 1 time

