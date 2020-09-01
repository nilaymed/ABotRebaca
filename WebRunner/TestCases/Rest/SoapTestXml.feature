@SoapTestXml
  Feature: SoapTestXml

  Scenario: SoapTestXml : SoapTestXml
  
  Given the test data is in file /TestCases/Web/MessageBundle/NewTestData.xml
  
  Given all configured endpoints for WebServiceClient are connected successfully
  
  When SOAP request sent to endpoint WSSoapClient using message reference msg03
  
  Then compare the SOAP response with message reference msg04
  Then compare SOAP response with following parameters:
	  | responseResult                     				 				                    | existence                |
	  | //*[local-name()='country'][1]/*[local-name()='name'][1]/text()       | {string:nocase:eq}(Spain)|
	  | //*[local-name()='country'][1]/*[local-name()='population'][1]/text() | {int:eq}(46704314)       |
	  | //*[local-name()='country'][1]/*[local-name()='capital'][1]/text()    | {string:eq}(Madrid)      |
	  | //*[local-name()='country'][1]/*[local-name()='currency'][1]/text()   | {string:eq}(EUR)         |
  
  Then save the SOAP response in /log/SoapResponse.xml
  When save the following SOAP parameters at endpoint WSSoapClient:
  | parameter                     				 				                          | value|
  | //*[local-name()='country'][1]/*[local-name()='name'][1]/text()         | COUNTRY_NAME  |
  | //*[local-name()='country'][1]/*[local-name()='population'][1]/text()   | POPULATION  |
  | //*[local-name()='country'][1]/*[local-name()='capital'][1]/text()      | CAPITAL  |
  | //*[local-name()='country'][1]/*[local-name()='currency'][1]/text()     | CURRENCY  |
  
  Then validate the saved parameters for SOAP response with following attributes at endpoint WSSoapClient:
  | responseResult         | existence|
  | COUNTRY_NAME           | {string:nocase:eq}(Spain) |
  | POPULATION             | {int:eq}(46704314)        |
  | CAPITAL                | {string:eq}(Madrid)       |
  | CURRENCY               | {string:eq}(EUR)          |
  
  
  #Then verify the presence of following attributes in SOAP Response:
  Then check the following parameters present or absent in the SOAP response:
  | parameter                     				 				                         | value|
  | //*[local-name()='country'][1]/*[local-name()='name'][1]/text()        | {string:nocase:present}  |
  | //*[local-name()='country'][1]/*[local-name()='population'][1]/text()  | {string:nocase:present}  |
  | //*[local-name()='country'][1]/*[local-name()='capital'][1]/text()     | {string:nocase:present}  |
  | //*[local-name()='country'][1]/*[local-name()='currency'][1]/text()    | {string:nocase:present}  |