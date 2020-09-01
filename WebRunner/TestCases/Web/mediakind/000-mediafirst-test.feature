###########################################################################################
#                              Date: <02/12/2020> Version: <1.0>                          #
###########################################################################################
@MediaFirst-pre-condition
Feature: MF000_RefApp_pre-condition

  Scenario: Open the MediaFirst app page
  
    Given all configured endpoints for WEB are connected successfully

    Given the mediakind app is loaded successfully
    
    When I wait for the Reach-CID (PC) link to become available
    Then I click on the element Reach-CID (PC) link