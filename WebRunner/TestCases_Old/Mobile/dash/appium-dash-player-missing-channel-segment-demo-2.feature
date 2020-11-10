###########################################################################################
#                              Date: <07/02/2018> Version: <1.0>                          #
###########################################################################################

@DASH_Player_Missing_Segment_Channel_Play1
@Appium_Demo


Feature: @DASH_Player_Missing_Segment_Channel_Play
Scenario: Play a video with missing segments


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

When I select the video type RECORDED from the panel on device {abotprop.Android.Device1.Identification.String}

And I play the video "Test Missing Segment" on the device {abotprop.Android.Device1.Identification.String} for 70 seconds and ENABLE log capture

Then I validate the log from the device {abotprop.Android.Device1.Identification.String} for the following attributes
|   responseResult            					 |   existence                        |
|   Source Error                        	     |  {string:nocase:absent}            |
|   HTTP 404 Error                               |  {string:nocase:absent}            |   
   






