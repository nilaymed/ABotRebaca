###########################################################################################
#                              Date: <07/07/2018> Version: <1.0>                          #
###########################################################################################

@DASH_Player_Play_Next_Missing_Video
@Appium_Demo


Feature: @DASH_Player_Play_Next_Missing_Video
Scenario: Play a video for a specified time and then play the next video which does not exists


Given all configured endpoints for APPIUM are connected successfully
Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I configure the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 4.4.2                              |
|  platformName               | Android                            |
|  port                       | 4723							   |
|  application                | MobiTv                             |
|  adbHost                    | 127.0.0.1                          |
|  protocol                   | http                               |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String}
|   responseResult            					 |   existence                        |
|   Mobitv Android DASH Player                   |  {string:nocase:present}           |                  


When I search for the video "H264 func-cp-qa DRM 7042 QVC simple" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(20)                  |

When I play the video on device {abotprop.Android.Device1.Identification.String} for 20 seconds and ENABLE log capture

When I try to play the next video on device {abotprop.Android.Device1.Identification.String} and ENABLE log capture

And I validate that the log of the device {abotprop.Android.Device1.Identification.String} for the following attributes
|   responseResult            					 |   existence                       |
|   Source Error                        	     |  {string:nocase:absent}           |
|   HTTP 404 Error                               |  {string:nocase:absent}           |   
|   WinDeath Error                               |  {string:nocase:absent}           |





