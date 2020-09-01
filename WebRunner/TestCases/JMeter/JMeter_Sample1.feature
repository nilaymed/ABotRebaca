###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@JMeterSample

Feature: CDN_Profile_API
Scenario: Execute CDN_Profile_API and validate response


Given all configured endpoints for JMETER are connected successfully

Given I load the configuration from /JMeterInput/CDN_Profile_API.jmx

When I execute the jmx query and store the output as /Output1.csv

Then I validate the following response for api cdn_profile_create profile
| 	Parameter 	| Value 		|
|	version		| 4.6.2.0.00107	|
|	hostname	| amm001		|

Then I validate the following response for api cdn_profile_retrive profile
| 	Parameter 				| Value 		|
|	retrieval_type			| 0				|
|	persistent_connection	| false			|










