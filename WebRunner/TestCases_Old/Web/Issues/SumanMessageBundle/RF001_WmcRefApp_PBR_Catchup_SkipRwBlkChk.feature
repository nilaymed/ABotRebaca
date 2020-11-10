###########################################################################################
#                              Date: <05/11/2020> Version: <4.0.1>                          #
#								Author Name: Kamatchi Rajan                               #
###########################################################################################

@Regression-PBR
@Sanity-PBR
@Basic-PBR
@RefApp-PBR
@RefApp-PBR-catchup
@MBX
Feature: RF001_WmcRefApp_PBR_Catchup_SkipRwBlkChk

  Scenario: Run the refapp player to verify the playback of Skip Rewind blocked CatchUp media
  
	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    
    Given the test data is in file /TestCases/Web/Issues/SumanMessageBundle/WebMesageBundleSuman.xml
	
	And I use the message-id PBR_Catchup_SkipRwBlk
    
    # Call common step
	Given I run the feature RefApp-Player-Common-Steps
	
	# Verify the Playback of CatchUp media.
	When I play the media for 30 seconds
	Then I validate that the media is in playing state

	#Verify the Seek Skip Rewind is blocked for Catchup media

	Given I expect that the next step will fail
    When I rewind the media for 1 time


	# Clicking on the Stop button to stop the playback
	
	Then I stop the media

	# Terminate the web driver
		

