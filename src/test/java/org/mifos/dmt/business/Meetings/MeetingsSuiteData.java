/*
 * Copyright (c) 2011-2015 SunGard Global Services, Bangalore
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */

package org.mifos.dmt.business.Meetings;
import java.util.HashMap;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.util.ParserXML;
import org.testng.annotations.BeforeGroups;
import org.testng.annotations.AfterGroups;
import org.xml.sax.SAXException;
import org.mifos.dmt.util.DMTXMLHandler;

public class MeetingsSuiteData {
	
	//variable to hold the testdata till the lifecycle of a method
	public static DMTXMLHandler xmlHandler;
	String path;
	
	// Parsing corresponding XML's against a group
	@BeforeGroups(groups="method1")
	  public void initSetUpMethod1() throws ConfigurationException, ParserConfigurationException, SAXException {
		
		path="src/test/resources/WeeklyFlat.xml";
		xmlHandler = ParserXML.populateObject(path);
		  
	  } //end of initset up method
	  
	  
	@BeforeGroups(groups="method2")
	  public void initSetUpMethod2() throws ConfigurationException, ParserConfigurationException, SAXException {
		
		path="src/test/resources/WeeklyDeclining.xml";
		xmlHandler = ParserXML.populateObject(path);
		
	  } //end of initset up method
	  
	@BeforeGroups(groups="method3")
		  public void initSetUpMethod3() throws ConfigurationException, ParserConfigurationException, SAXException {

			path="src/test/resources/MonthlyFlat.xml";
			xmlHandler = ParserXML.populateObject(path);
			  
		  } //end of initset up method
	@BeforeGroups(groups="method4")
	  public void initSetUpMethod4() throws ConfigurationException, ParserConfigurationException, SAXException {

		path="src/test/resources/MonthlyDeclining.xml";
		xmlHandler = ParserXML.populateObject(path);
		  
	  } //end of initset up method
	@BeforeGroups(groups="method5")
	  public void initSetUpMethod5() throws ConfigurationException, ParserConfigurationException, SAXException {

		  HashMap<String, String>stage1DbVal = DMTDatabaseConfigurations.STAGING_1;	  
		    String stage1User = stage1DbVal.get("user");
			String stage1Pass = stage1DbVal.get("password");
			String stage1Schema = stage1DbVal.get("schema");
			String stage1dbHost = stage1DbVal.get("host");
			String stage1dbPort = stage1DbVal.get("port");
			
			String stage2jobFilePath= DMTConfig.DMT_CONFIG_DIR
			                         + "\\prepStaging.bat";
			String stage1Sql= "src/test/resources/stage1part1.sql";
			try{
				
				String space = " ";
				String arg = stage2jobFilePath + space + stage1dbHost
						+ space + stage1User + space + stage1Pass + space
						+ stage1Schema + space + stage1Sql + space + stage1dbPort;
				Process thread = Runtime.getRuntime().exec(arg);
				thread.waitFor();
		         }catch (Exception e) {
				e.printStackTrace();
			}
		  
	  } //end of initset up method
	
	@AfterGroups(groups="method1")
	 public void tearDownMethod1()
	{
		xmlHandler=null;
	}// end of tear down method
	
	@AfterGroups(groups="method2")
	 public void tearDownMethod2()
	{
		xmlHandler=null;
	}// end of tear down method
	
	@AfterGroups(groups="method3")
	 public void tearDownMethod3()
	{
		xmlHandler=null;
	}// end of tear down method
	
	@AfterGroups(groups="method4")
	 public void tearDownMethod4()
	{
		xmlHandler=null;
	}// end of tear down method
	
	
}
