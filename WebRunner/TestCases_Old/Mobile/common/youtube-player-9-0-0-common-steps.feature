@Youtube-Common-Step
Feature: Youtube-9_0_0_Init

Scenario: Create global system configuration

Given I initialize the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 9.0.0                              |
|  port                       | 4723                               |
|  platformName               | Android                            |
|  application                | YouTube                            |
|  applicationVersion 		  | 1.0								   |
|  adbHost                    | 127.0.0.1                          |
|  protocol                   | http                               |
