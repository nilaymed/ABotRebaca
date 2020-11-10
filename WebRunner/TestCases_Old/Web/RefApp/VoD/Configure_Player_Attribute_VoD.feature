###########################################################################################
#                              Date: <02/21/2020> Version: <1.0>                          #
###########################################################################################
@RefApp_Player_VOD_Media_Configure_Attribute
@RefApp_Player_VOD_Sanity
@Sanity_Integration
@ADO_Configure
Feature: RefApp Player VOD Media Configure Attribute

  Scenario: Run the refapp player for VoD (default) playback mode
    
    Given all configured endpoints for WEB are connected successfully
    
    Given the steps below will be executed at the end
    Then I terminate the driver
    Then the ending steps are complete
    
    Given the test data is in file /TestCases/Web/MessageBundle/WebMessageBundle.xml
    And I use the message-id RFVD002
    
    # Call common step
    Given I run the feature RefApp_Player_VOD_Common_Steps
