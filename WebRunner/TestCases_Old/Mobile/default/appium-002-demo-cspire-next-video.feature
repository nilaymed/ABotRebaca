###########################################################################################
#                              Date: <07/02/2018> Version: <1.0>                          #
###########################################################################################

@Appium_MobiTV_Validation_Demo_Next_Video
@Appium_MobiTV


Feature: @Appium_MobiTV_Validation_Demo_Next_Video
Scenario: Play MobiTV application


Given all configured endpoints for APPIUM are connected successfully
Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I configure the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 4.4.2                              |
|  platformName               | Android                            |
|  port                       | 4723							   |
|  application                | GooglePlayer                       |
|  adbhost                    | 127.0.0.1                          |
|  protocol                   | http                               |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String}
|   responseResult            					 |   existence                        |
|   Mobitv Android DASH Player                   |  {string:nocase:present}           |                  


When I search for the video "H264 func-cp-qa DRM 7042 QVC simple" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(20)                  |

When I play the video at index position 2 on device {abotprop.Android.Device1.Identification.String}

Given the execution is paused for 10 seconds

When I try to play the next video on device {abotprop.Android.Device1.Identification.String}

And I validate that the video execution failed on device {abotprop.Android.Device1.Identification.String} with following attributes
|   responseResult            					 |   existence                        |
|   License Error                        	     |  {string:nocase:present}           |
|   HTTP 404 Error                               |  {string:nocase:present}           |   





