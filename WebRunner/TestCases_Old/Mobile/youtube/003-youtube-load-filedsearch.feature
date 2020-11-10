###########################################################################################
#                              Date: <03/23/2018> Version: <1.0>                          #
###########################################################################################

#@Youtube_Load_Test_Feature_Demo
#@Youtube_Demo


Feature: Youtube_Load_Test_Feature_Demo
Scenario: Test YouTube with MOBILE Android Driver


Given all configured endpoints for MOBILE are connected successfully

Given the steps below will be executed at the end
  Then I stop the player on device {abotprop.Android.Device1.Identification.String}
  Then I stop the player on device {abotprop.Android.Device2.Identification.String}
Then the ending steps are complete

Given I run the feature Youtube-7_1_1_Init

Given I run the feature Youtube-7_1_1_Init

Then I validate that the application is launched successfully on device {abotprop.Android.Device1.Identification.String} 
|   responseResult            |   existence                        |
|   YouTube                   |  {string:nocase:present}           |     

Then I validate that the application is launched successfully on device {abotprop.Android.Device2.Identification.String} 
|   responseResult            |   existence                        |
|   YouTube                   |  {string:nocase:present}           |             

When I search for the media "messi's top 10 goals" on device {abotprop.Android.Device1.Identification.String}

When I search for the media "ronaldo best goals" on device {abotprop.Android.Device2.Identification.String}

Then I validate the result on device {abotprop.Android.Device1.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:ge}(1)                   |

Then I validate the result on device {abotprop.Android.Device2.Identification.String} with the following attributes
|   responseResult      	  |   existence                        |
|   Total Items   			  |  {integer:ge}(1)                   |


When I play the media at index position 2 on device {abotprop.Android.Device1.Identification.String}

When I play the media at index position 3 on device {abotprop.Android.Device2.Identification.String}

#Given the execution is paused for 10 seconds 

Then I validate that the media is playing on device {abotprop.Android.Device1.Identification.String}
|   responseResult           |   existence                         |
|   Played                   |  {string:eq}(True)                  |

Then I validate that the media is playing on device {abotprop.Android.Device2.Identification.String}
|   responseResult           |   existence                         |
|   Played                   |  {string:eq}(True)                  |


Then I pause the media on device {abotprop.Android.Device1.Identification.String}

Then I pause the media on device {abotprop.Android.Device2.Identification.String}

Then I validate that the media is paused successfully on device {abotprop.Android.Device1.Identification.String}
|   responseResult           |   existence                         |
|   Played                   |  {string:eq}(False)                 |

Then I validate that the media is paused successfully on device {abotprop.Android.Device2.Identification.String}
|   responseResult           |   existence                         |
|   Played                   |  {string:eq}(False)                 |

   
##Then I stop the player on device {abotprop.Android.Device1.Identification.String}
##Then I stop the player on device {abotprop.Android.Device2.Identification.String}




 


                 

