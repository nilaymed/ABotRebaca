###########################################################################################
#                              Date: <04/18/2018> Version: <1.0>                          #
###########################################################################################

@Youtube_Search_And_Play_Media_At_Index
@Youtube_Test_Feature_Demo
@Youtube_Sanity
@Youtube_Demo


Feature: @Appium_Youtube_Search_And_Play_Media_At_Index
Scenario: Open the youtube application, search and play a particular media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I initialize the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 7.1.1                              |
|  port                       | 4723                               |
|  platformName               | Android                            |
|  application                | YouTube                            |
|  applicationVersion 		  | 1.0 							   |
|  adbHost                    | 127.0.0.1                          |
|  protocol                   | http                               |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String} 
|   responseResult            |   existence                        |
|   YouTube                   |  {string:nocase:present}           |     

When I search for the media "ronaldo's top 10 goals" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(10)                  |

When I play the media at index position 2 on device {abotprop.Android.Device1.Identification.String}

Then I validate that the media is playing on device {abotprop.Android.Device1.Identification.String}

Given the execution is paused for 5 seconds 

Then I pause the media on device {abotprop.Android.Device1.Identification.String}

Then I validate that the media is paused successfully on device {abotprop.Android.Device1.Identification.String}
