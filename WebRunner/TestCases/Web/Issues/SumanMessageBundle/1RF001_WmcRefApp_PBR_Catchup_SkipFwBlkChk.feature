###########################################################################################
#                              Date: <05/11/2020> Version: <4.0.1>                          #
#                              Author:KANAGA VIGNESHWARI D                                # 
###########################################################################################
@RefApp-Player_R10
@RefApp-Player_R10_1
@RefApp-Player_R312
@RefApp-PBR
@MBX
Feature: B

  Scenario: Run the refapp player to verify the playback of Skip Forward blocked CatchUp media
  
	Given all configured endpoints for WEB are connected successfully

	Given the steps below will be executed at the end
	When I terminate the driver
	Then the ending steps are complete

    
    Given the test data is in file /TestCases/Web/Issues/SumanMessageBundle/WebMesageBundleSuman.xml	
	And I use the message-id PBR_Catchup_SkipFwBlk
    
    # Call common step
	
		Given I run the feature RefApp-Player-Common-Steps
	
	# Verify the Playback of CatchUp media.
	
	When I play the media for 20 seconds
	And I validate that the media is in playing state
	And I wait for 10 seconds	
	
	
	#Verify the Seek Skip Forward is blocked for Catchup media

	Given I expect that the next step will fail
	When I 2x-fast-forward the media for 1 time

	
	# Clicking on the Stop button to stop the playback
	
	Then I stop the media

	# Terminate the web driver
		

