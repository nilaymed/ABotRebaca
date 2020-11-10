###########################################################################################
#                              Date: <04/18/2018> Version: <1.0>                          #
###########################################################################################

@Youtube_Test_Feature_CFS_Demo
@Youtube_Demo


Feature: Youtube_Test_Feature_CFS_Demo
Scenario: Test YouTube media player with MOBILE Android Driver


Given all configured endpoints for MOBILE are connected successfully

Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
Then the ending steps are complete

Given I run the feature Youtube-7_1_1_Init

Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String} 
|   responseResult            |   existence                        |
|   YouTube                   |  {string:nocase:present}           |     

When I search for the media "messi's top 10 goals" on device {abotprop.Android.Device1.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:le}(10)                  |

When I play the media at index position 2 on device {abotprop.Android.Device1.Identification.String} for 10 seconds with snap rate delay of 5 seconds 

Then I validate that the media is playing on device {abotprop.Android.Device1.Identification.String}

Then I pause the media on device {abotprop.Android.Device1.Identification.String}

Then I validate that the media is paused successfully on device {abotprop.Android.Device1.Identification.String}



