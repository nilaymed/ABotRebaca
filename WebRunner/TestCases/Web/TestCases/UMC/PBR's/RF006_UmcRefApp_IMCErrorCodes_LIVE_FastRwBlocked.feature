###########################################################################################
#                              Date: <07/15/2020> Version: <5.0.2>                        #
#                                 Author Name: Nikhil Shet                                #
###########################################################################################
@Sanity_Check
@Sanity_PBR_LiveCheck

Feature: RF006_UmcRefApp_IMCErrorCodes_LIVE_FastRwBlocked

  Scenario: Run the Refapp player to Check the Fast Rewind Block IMC error code in LIVE content
    Given all configured endpoints for MOBILEDEVICE are connected successfully

    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete

    #Pre-condition
    Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

    And I use the message-id PBR_LIVE_FastRwBlk

    # Call common step
    Given I run the feature RefApp-Player-Mobile-Steps

    # Verifying the playback
    When I run the feature RefApp-Player-Start-Steps

    # PBR validation with FastRwBlocked_Blocked media
    When I run the feature UmcRefApp-PBR-FastRwBlocked-Steps

    # Verifying Fast Rewind block from console logs
    #When I run the feature RefApp-IMC-FastRwBlocked-Steps

    # Clicking on the Stop button to stop the playback
    When I run the feature RefApp-Player-Stop-Steps

# Terminate the web driver

