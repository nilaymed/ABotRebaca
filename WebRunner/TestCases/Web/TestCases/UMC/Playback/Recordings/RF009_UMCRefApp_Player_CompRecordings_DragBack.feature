###########################################################################################
#                            Date: <06/09/2020> Version: <4.3.0>                         #
#                               Author name:NITHIN 		                                 #
###########################################################################################
@Sanity-RecordingsCheck
@SanityCheck

Feature: RF009_UmcRefApp_Player_CompRecording_DragBack

Scenario: Run the refapp player to verify the Seek(Drag) backward functionality of CompRecording media.
	
# Pre-condition
  Given all configured endpoints for MOBILEDEVICE are connected successfully

  Given the steps below will be executed at the end
  When I terminate the driver
  Then the ending steps are complete

  Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml 
  And I use the message-id RF_DVR_COMPLETED
#Common step call   
  Given I run the feature RefApp-Player-Mobile-Steps 
	
# Verifying the playback
  Given I run the feature RefApp-Player-Start-Steps

# Verify the drag backward on progress bar during playback of Recording media
  Given I run the feature RefApp-Player-DragRw-Steps
		
# Clicking on the Stop button to stop the playback
  Given I run the feature RefApp-Player-Stop-Steps


