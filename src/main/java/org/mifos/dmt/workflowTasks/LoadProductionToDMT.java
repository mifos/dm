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

package org.mifos.dmt.workflowTasks;

import java.util.Date;
import java.util.HashMap;

import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;

public class LoadProductionToDMT extends Task{
	private static final DMTLogger logger = (DMTLogger) DMTLogger
			.getLogger(LoadProductionToDMT.class.getName());
	private String dbUser;
	private String dbPass;
	private String schema;
	private String jobFilePath;
	private String backupFilePath;
	private String dbHost;
	private String dbPort;
	
	//below are variables for stage 2
	private String stage2User;
	private String stage2Pass;
	private String stage2Schema;
	private String stage2dbHost;
	private String stage2dbPort;
	private String stage2jobFilePath;
	
	
	LoadProductionToDMT() {
		HashMap<String, String> prodDbVal = DMTDatabaseConfigurations.PRODUCTION;
		this.dbUser = prodDbVal.get("user");
		this.dbPass = prodDbVal.get("password");
		this.schema = prodDbVal.get("schema");
		this.dbHost = prodDbVal.get("host");
		this.dbPort = prodDbVal.get("port");
		this.jobFilePath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.DUMP_DATABASE_ROUTINE;
		this.backupFilePath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.BACKUP_TEMP_DIR;
		
		HashMap<String, String> stage2DbVal = DMTDatabaseConfigurations.STAGING_2;
		this.stage2jobFilePath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.LOAD_TO_DATABASE_ROUTINE;
		
		this.stage2User =  stage2DbVal.get("user");
		this.stage2Pass =  stage2DbVal.get("password");
		this.stage2dbHost =  stage2DbVal.get("host");
		this.stage2Schema =  stage2DbVal.get("schema");
		this.stage2dbPort = stage2DbVal.get("port");
		
	}

	// public static void main(String args[]) {
	@Override
	public boolean execute() {
		/*
		 * appending a timestamp to the backup so that multiple copies of the backup
		 * can persist. Its upto the implementor to clean up the backup files as of now
		 * can implement a simple task that cleans up all but the most recent backup	
		*/ 
		String tempTs = Long.toString(new Date().getTime());
		String backupFilePath = this.backupFilePath + "\\temp";
		
		logger.info("Initializing step: Updating copy of production database to load into DMT");
		try {
			String space = " ";
			/*
			 * Configure the following values in the message.properties file
			 * Structure of String arg is as follows it needs a space seperated list of arguments in the
			 * following order:
			 * path to batch file
			 * production server location (IP)
			 * production server username
			 * production server password
			 * production server schema that needs backup
			 * path to backup folder that will store the backup
			 */
			String arg =this.jobFilePath + space + this.dbHost+ space + this.dbUser + space
			+ this.dbPass + space + this.schema + space
			+ backupFilePath + space + this.dbPort;
		
			Process thread = Runtime.getRuntime().exec(arg);
			thread.waitFor();
			logger.info("Production database backup is now updated, saved to file -> dump_"+tempTs);
			
			/*
			 * Configure the following values in the message.properties file
			 * Structure of String arg is as follows it needs a space seperated list of arguments in the
			 * following order:
			 * path to batch file
			 * production server location (IP)
			 * production server username
			 * production server password
			 * production server schema that needs backup
			 * path to backup folder that will store the backup
			 */
			
			String arg1 =this.stage2jobFilePath + space + this.stage2dbHost+ space + this.stage2User + space
			+ this.stage2Pass + space + this.stage2Schema + space
			+ backupFilePath + space + this.stage2dbPort;
			thread = Runtime.getRuntime().exec(arg1);
			thread.waitFor();
			logger.debug("Start process- populate data into DMT  ->: "+this.stage2Schema+" with the command -> "+arg1.replace("\\", "/"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
		
		
		/*
		 * This return statement has to be replaced by a camel message producer -
		 * will be implemented in future, this would enable parallel consumption of messages
		 * and hence threaded architecture of the DMT
		 * Would speed up things for larger migrations
		 */
	}

	@Override
	public String getMessage() {
		return "Updating the DMT with data from the production server";
	}
	
}
