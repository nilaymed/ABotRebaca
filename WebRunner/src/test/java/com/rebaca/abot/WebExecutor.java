/*************************************************************************
 * 
 * @!$ Rebaca Technologies
 * __________________
 * 
 * 2016 Rebaca Technologies
 * 
 * NOTICE:  All information contained herein is, and remains
 * the property of Rebaca Technologies and its suppliers, if any.
 * The intellectual and technical concepts contained herein are 
 * proprietary to Rebaca Technologies and its suppliers and may be  
 * covered by Indian and Foreign Patents, patents in process, and
 * are protected by trade secret or copyright law. Dissemination
 * of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from 
 * Rebaca Technologies.
 * 
 * Coding Standards
 * -----------------
 *
 * -- Class Name              ----->   e.g. MyClass                    [Camel case]    
 * -- Class Function          ----->   e.g. MyFunction()               [Camel case]    
 * -- Static Variable         ----->   e.g. sVar                       [Starts with 's' and then Camel case]
 * -- Class Member Variable   ----->   e.g. varVar                     [Starts with small case, and then Camel case]
 * -- Function Brace          ----->   e.g. void MyFunction {          [On the same line as definition]
 * -- Class Brace             ----->   e.g. Class MyClass {            [On the same line as definition]
 * -- Conditional Brace       ----->   e.g. if condition {             [On the same line as statement and brace is mandatory]
 * -- Loop Brace              ----->   e.g. loop {                     [On the same line as statement]
 * -- try Brace               ----->   e.g. try {                      [On the same line as statement]
 *
 * @!$Id$
 */

/**
 * This class is used for running all tests
 */
package com.rebaca.abot;

import org.junit.runner.RunWith;
import com.rebaca.adapters.base.data.AutomationOptions;
import com.rebaca.adapters.base.lifecycle.runner.AutomatedTestRunner;

/**
* @author Rebaca Technologies Pvt. Ltd.
*
*/


@AutomationOptions(
//testcasepath = "./ABOTTestCases" ,  
//plugin="pretty", "json:artifacts/TestResults.json",
//glue="com/rebaca/gluecode/",
		config = "config/config.properties", 
		loglevel = "INFO",
		tags = "@PBRtag_1",
		validategrammaronly = false,
		suitename="WEB_LIBRARY"
//strict = true
)
@RunWith(AutomatedTestRunner.class)
public class WebExecutor {

}