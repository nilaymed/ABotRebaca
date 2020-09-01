###########################################################################################
#                              Date: <03/23/2018> Version: <1.0>                          #
###########################################################################################

@Appium_HostStar_Demo
@Appium_Demo


Feature: @Appium_HostStar_Demo
Scenario: Play HotStar application


Given all configured endpoints for APPIUM are connected successfully

Given I configure the device {abotprop.Android.Device.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 6.0                                |
|  platformName               | Android                            |
|  application                | HotStar                            |


#Then I validate that the application is launched correctly
#|   responseResult            |   existence                        |
#|   HotStar                   |  {string:nocase:present}           |                  

When I search for the video "hero isl" 

Then I validate the result with the following attributes 
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:ge}(1)                   |

When I play the video at index position 2

Given the execution is paused for 60 seconds

#Then I pause the video

#Then I validate that the video was played 
#|   responseResult           |   existence                         |
#|   Played                   |  {string:eq}(True)                  |

 


                 

