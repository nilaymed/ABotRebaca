###########################################################################################
#                              Date: <10/02/2019> Version: <2.0>                          #
###########################################################################################

@AUD_INITTEST


Feature: ABOT Automation Desk Driver Initialization
Scenario: Driver initialization feature file for Bosch
Given all configured endpoints for AUTODESK are connected successfully
When I create dSpace project TSH_Sitzlueftung_A_rebaca with the following attributes
|       parameter           |      value                                  |
|   BookmarkHierarchyPathes |    TestProjectValue				          |