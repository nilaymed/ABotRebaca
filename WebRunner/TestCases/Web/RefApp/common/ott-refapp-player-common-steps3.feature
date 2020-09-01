@OTT-Common-RefApp-Step @WEB_LIBRARY
Feature: OTT-Common-RefApp-Stepss

  Scenario: Create global system configuration
	# Pre-condition
	
	When I play-pause the media
    Then I validate that the media is in resumed state