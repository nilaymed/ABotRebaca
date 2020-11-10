###########################################################################################
#                              Date: <03/11/2020> Version: <1.0>                          #
###########################################################################################
@NextGen_testX
Feature: NG000_NextGen_test_feature

  Scenario: Demo the Software Analyzer Nextgen
    Given all configured endpoints for WEB are connected successfully
    
    # Pre-condition
    
    Given the nextgen app is loaded successfully
    
    # Login Steps
    
    When I open the Login page
    #Then I validate Software Analyser text to be present on page
    When I input sashankkor1 on Username textbox
    And I input admin on Password textbox
    Then I click on the element Login button
    Then I validate Dashboard link to be present on page
    
    And I terminate the web driver
    