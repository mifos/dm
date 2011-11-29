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

public class GenerateProductionDump extends Task{
	private static final DMTLogger logger = (DMTLogger) DMTLogger
			.getLogger(GenerateProductionDump.class.getName());
	private String dbUser;
	private String dbPass;
	private String schema;
	private String jobFilePath;
	private String backupFilePath;
	private String dbHost;
	private String dbPort;
	
	GenerateProductionDump() {
		HashMap<String, String> dbProd = DMTDatabaseConfigurations.PRODUCTION;
		this.dbUser = dbProd.get("user");
		this.dbPass = dbProd.get("password");
		this.schema = dbProd.get("schema");
		this.dbHost = dbProd.get("host");
		this.dbPort = dbProd.get("port");
		
		this.jobFilePath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.DUMP_DATABASE_ROUTINE;
		this.backupFilePath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.BACKUP_TEMP_DIR;
	}

	@Override
	public boolean execute() {
	
		/*
		 * appending a timestamp to the backup so that multiple copies of the backup
		 * can persist. Its upto the implementor to clean up the backup files as of now
		 * can implement a simple task that cleans up all but the most recent backup	
		*/ 
		String tempTs = Long.toString(new Date().getTime());
		String backupFilePath = this.backupFilePath + "\\dump_"+ tempTs +".bak";
		
		logger.info("Initializing step: Saving copy of production database");
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
			logger.debug("Starting the dump process with the command -> "+arg);
			Process thread = Runtime.getRuntime().exec(arg);
			thread.waitFor();
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("Production database backup complete, saved to file -> dump_"+tempTs);
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
		return "Generating dump of production database";
	}
	
}
