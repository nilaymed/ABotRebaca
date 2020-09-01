###########################################################################################
#                              Date: <04/22/2020> Version: <1.0>                          #
###########################################################################################

@JMeterSample

Feature: Media_Recording_API
Scenario: Execute Media_Recording_API and validate response


Given all configured endpoints for JMETER are connected successfully

Given I load the configuration from /JMeterInput/Media_Recording_API.jmx

When I execute the jmx query and store the output as /Output2.csv

Then I validate the following response for api cdn_profile_create profile
| 	Parameter 	| Value 				|
|	version		| 4.6.2.0.00107			|
|	name		| test-user-name12		|

Then I validate the following response for api media - Recording update
| 	Parameter 				| Value 		|
|	channel_uid				| test1			|
|	cdn_group				| cdn_group_2	|










