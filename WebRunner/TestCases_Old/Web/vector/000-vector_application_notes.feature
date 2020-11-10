###########################################################################################
#                              Date: <02/01/2020> Version: <1.0>                          #
###########################################################################################
@Vector_Application_Notes @vector_sanity1 @web_sanity
Feature: V000_Vector_Application_Notes

  Scenario: Navigation of vTESTstudio's Application Notes and Validate Text
    Given all configured endpoints for WEB are connected successfully

    # Load and login to vector application
    Given the vector app is loaded successfully
        When I open the Home page
        Then I wait for the Products link to become available
        When I click on the element Products link
        Then I wait for the "Products A-Z" link to become available
        And I click on the element "Products A-Z" link
    
    # Load and navigate through the Products page
    When I open the Products page
        Then I wait for the vTESTstudio text to become available
        When I click on the element vTESTstudio link
        Then I validate vTESTstudio text to be present on page

    # Load and navigate through the VTestStudio page
    When I open the VTestStudio page
        Given I click on the element "Application Notes" link
        Then I wait for the "AN-IND-1-021 Vector Testing Solution" link to become available
        And I validate AN-IND-1-021 Vector Testing Solution link to be present on page
        Given I click on the element "AN-IND-1-021 Vector Testing Solution" link
        Then I validate AN-IND-1-021 Vector Testing Solution text to be present on page
        When I click on the element Downloads link
        Then I validate Vector Testing Solution text to be present on page

    # Terminate the web driver
    Then I terminate the web driver
