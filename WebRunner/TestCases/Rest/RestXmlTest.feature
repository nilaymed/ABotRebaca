@RestTestFirstXML
  Feature: RestTestFirstXML
  Scenario: RestTestFirstXML : RestTestFirstXML
  
  Given the test data is in file /TestCases/Web/MessageBundle/NewTestData.xml
  Given all configured endpoints for WebServiceClient are connected successfully
  When REST request sent using http POST on endpoint WSRestClient to URI "/requests"
  Then compare REST response with following parameters:
  | responseResult                     		 | existence                         |
  |  //Emp[@id="0"]/role/text()            | {string:nocase:eq}(Developer) |
  |  //Emp[@id="0"]/age/text()             | {int:eq}(25)                  |
  |  //Emp[@id="0"]/name/text()            | {string:eq}(Sandip)           |
  |  //Emp[@id="0"]/gen/text()             | {string:eq}(Male)             |
  | HEADER.Content-type                    | {string:eq}(text/xml)         |
  | HEADER.Content-length                  | {int:eq}(165)                 |
  
  When a REST request sent using http POST on endpoint WSRestClient to URI "/requests" using message reference msg01
  Then compare the REST response with message reference msg01
  
  Then check the following parameters present or absent in the REST response:
      | responseResult                        | existence                    |
      | //Emp[@id="0"]/role/text()            | {string:nocase:present}  |
      | //Emp[@id="0"]/age/text()             | {string:nocase:present}  |
      | HEADER.Content-type                   | {string:nocase:present}  |
      | HEADER.Content-length                 | {string:nocase:present}  |
      | HEADER.Not-Found-Header               | {string:nocase:absent}   |
   Then save the REST response in /log/data.xml
   
   When save the following parameters for REST response at endpoint WSRestClient:
   | parameter                     				         | value|
   |  //Emp[@id="0"]/role/text()                   | Employee_Role  |
   |  //Emp[@id="0"]/age/text()                    | Employee_Age  |
   |  //Emp[@id="0"]/name/text()                   | Employee_Name |
   |  //Emp[@id="0"]/gen/text()                    | Employee_Gender  |
   | HEADER.Content-type                           | Header_Content_Type|
   | HEADER.Content-length                         | Header_Content_Length|
   
   Then validate the saved parameters for REST response with following attributes at endpoint WSRestClient:
   | responseResult                     				   | existence|
   |  Employee_Role                                | {string:nocase:eq}(Developer)  |
   |  Employee_Age                                 | {int:eq}(25)                   |
   |  Employee_Name                                | {string:eq}(Sandip)            |
   |  Employee_Gender                              | {string:nocase:eq}(Male)       |
   |  Header_Content_Type                          | {string:eq}(text/xml)          |
   |  Header_Content_Length                        | {int:eq}(165)                  |