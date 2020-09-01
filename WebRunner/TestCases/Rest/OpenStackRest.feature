@OpenStackRest

  Feature: OpenStackRest
  Scenario: OpenStackRest : OpenStackRest
  
  Given the test data is in file /TestCases/Web/MessageBundle/NewTestData.xml
  Given all configured endpoints for WebServiceClient are connected successfully
  When a REST request sent using http POST on endpoint WSRestClient to URI "/v2.0/tokens" using message reference msg02
  
  Then compare the REST response with message reference msg05