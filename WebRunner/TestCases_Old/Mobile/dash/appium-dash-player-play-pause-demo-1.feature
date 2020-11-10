###########################################################################################
#                              Date: <07/17/2018> Version: <2.0>                          #
###########################################################################################

@DASH_Player_Play_Pause1
@Appium_Demo


Feature: @DASH_Player_Play_Pause
Scenario: Video Playback with Play Pause validations

Given all configured endpoints for APPIUM are connected successfully
Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I configure the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 4.4.2                              |
|  platformName               | Android                            |
|  port                       | 4723   							   |
|  application                | MobiTv                             |
|  adbHost                    | 127.0.0.1                          |
|  protocol                   | http                               |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String}
|   responseResult            					 |   existence                        |
|   Mobitv Android DASH Player                   |  {string:nocase:present}           |                  

When I play the video "H264 func-cp-qa DRM 7042 QVC simple" on the device {abotprop.Android.Device1.Identification.String} for 10 seconds and ENABLE log capture

When I pause the video on device {abotprop.Android.Device1.Identification.String}

Then I validate that the video is paused successfully on device {abotprop.Android.Device1.Identification.String}

And I validate the log from the device {abotprop.Android.Device1.Identification.String} for the following attributes
|     responseResult            |         existence                   |
|     Video Played              |       {string:nocase:present}       |
|     Video Paused              |       {string:nocase:present}       |          
