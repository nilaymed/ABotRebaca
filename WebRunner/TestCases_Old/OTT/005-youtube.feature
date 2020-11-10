###########################################################################################
#                              Date: <04/18/2018> Version: <1.0>                          #
###########################################################################################

@YoutubeConfg

Feature: @Appium_Youtube_Search_And_Play_Media_At_Index
Scenario: Open the youtube application, search and play a particular media


Given all configured endpoints for MOBILEDEVICE are connected successfully

Given the steps below will be executed at the end
  Then I terminate the driver
Then the ending steps are complete

Given I initialize the mobile-device Device1 and launch the application