###########################################################################################
#                              Date: <04/18/2018> Version: <1.0>                          #
###########################################################################################

@Youtube_Test_Feature_Nerds_Demo
@Youtube_Demo



Feature: Youtube_Test_Feature_Nerds_Demo
Scenario: Test YouTube media player with MOBILE Android Driver


Given all configured endpoints for MOBILE are connected successfully

Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I initialize the device {abotprop.Android.Device1.Identification.String} and launch the application with the following attributes
|    parameter                | value                              |
|  platformVersion            | 7.1.1                              |
|  port                       | 4723                               |
|  platformName               | Android                            |
|  application                | YouTube                            |
|  applicationVersion 		  	| 1.0																 |
|  adbHost                    | 127.0.0.1                          |
|  protocol                   | http                               |


Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String} 
|   responseResult            |   existence                        |
|   YouTube                   |  {string:nocase:present}           |     

When I search for the media "messi's top 10 goals" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(10)                  |

When I play the media at index position 2 on device {abotprop.Android.Device1.Identification.String}

Given the execution is paused for 5 seconds 

Then I validate that the media is playing on device {abotprop.Android.Device1.Identification.String}

When I fast-forward the media by 2 times on device {abotprop.Android.Device1.Identification.String}

Then I validate that the media moved forward on device {abotprop.Android.Device1.Identification.String}

#When I rewind the media by 2x on device {abotprop.Android.Device1.Identification.String}

Then I pause the media on device {abotprop.Android.Device1.Identification.String}

Then I validate that the media is paused successfully on device {abotprop.Android.Device1.Identification.String}



