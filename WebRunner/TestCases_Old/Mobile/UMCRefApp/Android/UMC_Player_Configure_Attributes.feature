###########################################################################################
#                              Date: <04/28/2020> Version: <3.0>                          #
#								                Author Name: Soumil Chatterjee                            #
###########################################################################################
@UMC_RefApp_Configure_Attributes
@UMC_RefApp_Sanity
@ADO_Configure

Feature: UMC_RefApp_Configure_Attributes

Scenario: Verify player fields are filled correctly

	Given all configured endpoints for MOBILEDEVICE are connected successfully

	Given the steps below will be executed at the end
    	Then I terminate the driver
	Then the ending steps are complete

	# Start-up Test by calling the common steps
	Given I run the feature UMCRefApp-Player-Common-Steps_VOD





