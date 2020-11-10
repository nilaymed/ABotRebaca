###########################################################################################
#                              Date: <07/15/2020> Version: <5.0.2>                        #
#                                 Author Name: Nikhil Shet                                #
###########################################################################################
@Sanity_Check
@Sanity_PBR_LiveCheck

Feature: RF004_UmcRefApp_IMCErrorCodes_LIVE_FastFwBlocked

  Scenario: Run the Refapp player to Check the Fast Forward Block IMC error code in LIVE content
    Given all configured endpoints for MOBILEDEVICE are connected successfully

    Given the steps below will be executed at the end
    And I terminate the driver
    Then the ending steps are complete

    #Pre-condition
    Given the test data is in file /TestCases/Web/MessageBundle/MobileMesageBundle.xml

    And I use the message-id PBR_LIVE_FastFwBlk

    # Call common step
    Given I run the feature RefApp-Player-Mobile-Steps

    # Verifying the playback
    When I run the feature RefApp-Player-Start-Steps

    # PBR validation with FastFwBlocked_Blocked media
    When I run the feature UmcRefApp-PBR-FastFwBlocked-Steps

    # Verifying Fast Forward block from console logs
    #When I run the feature RefApp-IMC-FastFwBlocked-Steps

    # Clicking on the Stop button to stop the playback
    When I run the feature RefApp-Player-Stop-Steps

# Terminate the web driver

