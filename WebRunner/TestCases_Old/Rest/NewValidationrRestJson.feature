@NewValidationJson

  Feature: NewValidationJson
  Scenario: NewValidationJson : NewValidationJson
  
  Given the test data is in file /TestCases/Web/MessageBundle/NewTestData.xml
  Given all configured endpoints for WebServiceClient are connected successfully
  When REST request sent using http POST on endpoint WSRestClient to URI "/requests"
  Then compare REST response with following parameters:
     | responseResult                      				 			| existence|
     |  $.cityName                                      | {string:nocase:eq}(Barrackpore)  |
     |  $.pinCode                                       | {integer:eq}(700123)     |
     |  $.distName                                      | {string:nocase:eq}(West Bengal)  |
  
  When a REST request sent using http POST on endpoint WSRestClient to URI "/requests" using message reference msg01
  Then compare the REST response with message reference msg06
  
  Then check the following parameters present or absent in the REST response:
      | responseResult        | existence                |
      | $.cityName            | {string:nocase:present}  |
      | $.pinCode             | {string:nocase:present}  |
      | $.distName            | {string:nocase:present}  |
      | $.unknownVar          | {string:nocase:absent}   |
      
   When save the following parameters for REST response at endpoint WSRestClient:
   | parameter                     				         | value         |
   |  $.cityName                                   | CITY_NAME     |
   |  $.pinCode                                    | CITY_PINCODE  |
   |  $.distName                                   | CITY_DIST_NAME|
   
   Then validate the saved parameters for REST response with following attributes at endpoint WSRestClient:
   | responseResult                     				   | existence                        |
   |  CITY_NAME                                    | {string:nocase:eq}(Barrackpore)  |
   |  CITY_PINCODE                                 | {integer:eq}(700123)             |
   |  CITY_DIST_NAME                               | {string:nocase:eq}(West Bengal)  |
   
  
  