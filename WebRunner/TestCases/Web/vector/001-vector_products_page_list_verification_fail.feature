###########################################################################################
#                              Date: <02/01/2020> Version: <1.0>                          #
###########################################################################################
@Vector_Products_Page_List_Verification_Fail @vector_sanity @web_sanity
Feature: V001_Vector_Products_Page_List_Verification_Fail

  Scenario: Fails to validate section element DYNA4 as links
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
      Then I validate the following links are available for element "Hardware"
      | Parameter |
      | Accessories |
      When I click on the element Accessories link
      Then I validate Accessories text to be present on page

    # Terminate the web driver
    Then I terminate the web driver
