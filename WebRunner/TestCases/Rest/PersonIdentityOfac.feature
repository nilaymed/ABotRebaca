@PersonIdentityOfac
  Feature: PersonIdentityOfac

  Scenario: PersonIdentityOfac : PersonIdentityOfac
  
  Given the test data is in file /TestCases/Web/MessageBundle/PersonIdentityOfac.xml
  
  Given all configured endpoints for WebServiceClient are connected successfully
  
  When SOAP request sent to endpoint WSSoapClient using message reference msg01
  
  Then compare the SOAP response with message reference msg02
  
  Then compare SOAP response with following parameters:
	  | responseResult                     				 				                                                                                                            | existence|
    |//*[local-name()='Envelope'][1]/*[local-name()='Body'][1]/IsSDNAndBlockedPersonsResponse[1]/SDNLists[1]/SDNLists[1]/SDN[5]/AlternateIdentityName[1]/text()     |Abu Ali   |