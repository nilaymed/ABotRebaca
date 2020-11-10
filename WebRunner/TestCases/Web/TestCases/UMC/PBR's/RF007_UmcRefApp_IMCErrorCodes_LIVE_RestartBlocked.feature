###########################################################################################
#                              Date: <07/15/2020> Version: <5.0.2>                        #
#                                 Author Name: Nikhil Shet                                #
###########################################################################################
@Sanity_Check
@Sanity_PBR_LiveCheck

Feature: RF007_UmcRefApp_IMCErrorCodes_LIVE_RestartBlocked

  Scenario: Run the Refapp Player for PBR validation with RestartNow Blocked media.
    Given all configured endpoints for MOBILEDEVICE are connected successfully

    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete

    #Pre-condition
    Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

    And I use the message-id PBR_LIVE_RSNowBlocked

    # Call common step
    Given I run the feature RefApp-Player-Mobile-Steps

    # Verifying the playback
    When I run the feature RefApp-Player-Start-Steps

    # PBR validation with RestartNow
    When I run the feature RefApp-PBR-RestartNowBlocked-Steps

    # Verifying Restart block from console logs
    When I run the feature RefApp-IMC-RestartBlocked-Steps

    # Clicking on the Stop button to stop the playback
    When I run the feature RefApp-Player-Stop-Steps


