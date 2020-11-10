###########################################################################################
#                              Date: <03/23/2018> Version: <1.0>                          #
###########################################################################################

@Appium_MobiTV_Demo
@Appium_Demo


Feature: @Appium_MobiTV_Demo
Scenario: Play MobiTV application


Given all configured endpoints for APPIUM are connected successfully
Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I configure the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 5.0.2                              |
|  platformName               | Android                            |
|  port                       | 4723							   |
|  application                | MobiTv                             |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String}
|   responseResult            					 |   existence                        |
|   Mobitv Android DASH Player                   |  {string:nocase:present}           |                  


When I search for the video "H264 func-cp-qa DRM 7042 QVC simple" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(20)                  |

When I play the video at index position 2 on device {abotprop.Android.Device1.Identification.String}

Given the execution is paused for 5 seconds

Then I pause the video on device {abotprop.Android.Device1.Identification.String}

Then I validate that the video is paused successfully on device {abotprop.Android.Device1.Identification.String}

Given the execution is paused for 10 seconds

#Then I validate that the video was played 
#|   responseResult           |   existence                         |
#|   Played                   |  {string:eq}(True)                  |

 

#Then I stop the player on device {abotprop.Android.Device1.Identification.String}
                 

 