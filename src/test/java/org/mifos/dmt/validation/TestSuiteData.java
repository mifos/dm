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

package org.mifos.dmt.validation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.configuration.DMTPropertiesLoader;
import org.testng.annotations.BeforeGroups;

public class TestSuiteData {

  //method to create the test dataset before executing the test cases against correct data
  @BeforeGroups(groups="method1")
  public void initSetUpMethod1() throws ConfigurationException {
	  DMTPropertiesLoader prop = DMTPropertiesLoader.getInstance();	
	  HashMap<String, String>stage1DbVal = DMTDatabaseConfigurations.STAGING_1;	  
	    String stage1User = stage1DbVal.get("user");
		String stage1Pass = stage1DbVal.get("password");
		String stage1Schema = stage1DbVal.get("schema");
		String stage1dbHost = stage1DbVal.get("host");
		String stage1dbPort = stage1DbVal.get("port");
		
		String stage2jobFilePath= DMTConfig.DMT_CONFIG_DIR
		                         + "\\prepStaging.bat";
		String stage1Sql= "src/test/resources/org/mifos/dmt/validation/dest_stage.sql";
		Connection con;
		PreparedStatement psmt;
		con=null;
		psmt=null;
		
		try{
			String connectionDriver="jdbc:mysql://"+stage1dbHost+":"+stage1dbPort+"/mysql";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(connectionDriver,stage1User,stage1Pass);
			StringBuilder sbQuery = new StringBuilder();
			StringBuilder sbQuery1 = new StringBuilder();
			sbQuery.append("DROP DATABASE IF EXISTS ");	
			sbQuery.append(stage1Schema);
			sbQuery1.append("CREATE DATABASE ");	
			sbQuery1.append(stage1Schema);
		    psmt = con.prepareStatement(sbQuery.toString());
	        psmt.executeUpdate();
	        psmt = con.prepareStatement(sbQuery1.toString());
	        psmt.executeUpdate();
			
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {

					if(psmt!=null)
						psmt.close();	
				} catch (Exception e) {
					e.printStackTrace();
				}
			}			
		
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
  
  //method to drop the test dataset after executing the test cases against correct data
 
  
//method to create the test dataset before executing the test cases against incorrect data
  @BeforeGroups(groups="method2")
  public void initSetUpMethod2() throws ConfigurationException {
	  	DMTPropertiesLoader prop = DMTPropertiesLoader.getInstance();
		HashMap<String, String>stage1DbVal = DMTDatabaseConfigurations.STAGING_1;
		
	    String stage1User = stage1DbVal.get("user");
		String stage1Pass = stage1DbVal.get("password");
		String stage1Schema = stage1DbVal.get("schema");
		String stage1dbHost = stage1DbVal.get("host");
		String stage1dbPort = stage1DbVal.get("port");
		
		String stage2jobFilePath=DMTConfig.DMT_CONFIG_DIR
		                         + "\\prepStaging.bat";
		String stage1Sql= "src/test/resources/org/mifos/dmt/validation/dest_stage_set2.sql";
		Connection con;
		PreparedStatement psmt;
		con=null;
		psmt=null;
		
		try{
			String connectionDriver="jdbc:mysql://"+stage1dbHost+":"+stage1dbPort+"/mysql";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(connectionDriver,stage1User,stage1Pass);
			StringBuilder sbQuery = new StringBuilder();
			StringBuilder sbQuery1 = new StringBuilder();
			sbQuery.append("DROP DATABASE IF EXISTS ");	
			sbQuery.append(stage1Schema);
			sbQuery1.append("CREATE DATABASE ");	
			sbQuery1.append(stage1Schema);
		    psmt = con.prepareStatement(sbQuery.toString());
	        psmt.executeUpdate();
	        psmt = con.prepareStatement(sbQuery1.toString());
	        psmt.executeUpdate();
			
			}catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {

					if(psmt!=null)
						psmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}			
		
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
  
  //method to drop the test dataset after executing the test cases against incorrect data
 
}
