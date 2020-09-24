###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_IOS_Configure_Player
@UMC_IOS_Sanity
@ADO_Configure

Feature: Configure_AMC_IOS

Scenario: Start the AMC/UMC iOS player and input all the fields 

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete
	
  Given the test data is in file /TestCases/Web/MessageBundle/MessageBundle.xml
    
  # Pre-condition
  #And I use the message-id RFVD003
  And I use the message-id RFVD002
  
	# Start-up Test by calling the common steps
	Given I run the feature UMC_IOS_VOD_Common_Steps
		