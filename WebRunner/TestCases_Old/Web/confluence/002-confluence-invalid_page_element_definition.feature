###########################################################################################
#                              Date: <02/01/2020> Version: <1.0>                          #
###########################################################################################

@Confluence_Invalid_Page_Element_Definition
@confluence_sanity
@web_sanity



Feature: Confluence_Invalid_Page_Element_Definition
Scenario: Invalid page element definition provided


Given all configured endpoints for WEB are connected successfully
Given the test data is in file /TestCases/Web/MessageBundle/WebMesageBundle.xml

And I use the message-id CNFD001

# Load and login to confluence application
Given the confluence app is loaded successfully

When I open the Home page
 
  And I wait for the Username textbox to become available
  And I wait for the Password textbox to become available
 	Given I input UserID on Username textbox
	And I input PassKey on Password textbox
	Then I click on the element Login link
	And I validate Confluence link to be present on page

# Load the Dashboard page and open the spaces link
When I open the Dashboard page

	Then I click on the element Spaces link
	And I validate Bosch link to be present on page
	When I click on the element Bosch link
  Then I validate Delivery Management link to be present on page
  When I click on the element Delivery Management link 
  Then I validate Project Management link to be present on page
  When I click on the element Project Management link
  Then I validate Customer Status Meetings link to be present on page
  When I click on the element Customer Status Meetings link
  Then I validate Customer Status Meetings 2019 link to be present on page
  When I click on the element Customer Status Meetings 2019 link
  And I wait for the BCM Weekly Status Report - 09/18/2019 link to become available
  Then I validate BCM Weekly Status Report - 09/18/2019 link to be present on page
  And I click on the element BCM Weekly Status Report - 09/18/2019 link
  
# Export to PDF operation
When I open the Status_Report page

  And I wait for the Actions link to become available
	Then I click on the element Action link
	And I validate Export to PDF link to be present on page
	Then I click on the element Export to PDF link  

# Terminate the web driver 
Then I terminate the web driver




