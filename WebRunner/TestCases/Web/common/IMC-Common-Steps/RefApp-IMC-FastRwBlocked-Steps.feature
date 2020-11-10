###########################################################################################
#                           Date: <07/17/2020> Version: <5.0.2>                          #
#				            Author Name: Nikhil Shet                                     #
###########################################################################################
@RefApp-IMC-FastFwBlocked-Steps @WEB_LIBRARY
Feature: RefApp-IMC-FastRwBlocked-Steps

    Scenario: Perform Fast Rewind blocked IMC error check in console logs

       Then I validate the following from console logs
      | Parameter     | Value |
      | IMC.ErrorCode |   227 |