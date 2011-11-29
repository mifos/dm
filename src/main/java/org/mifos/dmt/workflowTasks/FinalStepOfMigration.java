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

import java.util.HashMap;

import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;

public class FinalStepOfMigration extends Task {
	private static final DMTLogger logger = (DMTLogger) DMTLogger
			.getLogger(FinalStepOfMigration.class.getName());
	private String dbUser;
	private String dbPass;
	private String schema;
	private String jobFilePath;
	private String backupFilePath;
	private String dbHost;
	private String dbPort;

	// below are variables for stage 2
	private String stage2User;
	private String stage2Pass;
	private String stage2Schema;
	private String stage2dbHost;
	private String stage2dbPort;
	private String stage2jobFilePath;
	FinalStepOfMigration()  {
		HashMap<String, String> dbProd = DMTDatabaseConfigurations.PRODUCTION;
		this.dbUser = dbProd.get("user");
		this.dbPass = dbProd.get("password");
		this.schema = dbProd.get("schema");
		this.dbHost = dbProd.get("host");
		this.dbPort = dbProd.get("port");
		this.jobFilePath = DMTConfig.DMT_CONFIG_DIR
				+ DMTConfig.DUMP_DATABASE_ROUTINE;
		this.backupFilePath = DMTConfig.DMT_CONFIG_DIR
				+ DMTConfig.BACKUP_TEMP_DIR;
		
		HashMap<String, String> dbStage2 = DMTDatabaseConfigurations.STAGING_2;
		
		this.stage2User = dbStage2.get("user");
		this.stage2Pass = dbStage2.get("password");
		this.stage2dbHost = dbStage2.get("host");
		this.stage2Schema = dbStage2.get("schema");
		this.stage2dbPort = dbStage2.get("port");
		
		this.stage2jobFilePath = DMTConfig.DMT_CONFIG_DIR
		+ DMTConfig.LOAD_TO_DATABASE_ROUTINE;
	}

	// public static void main(String args[]) {
	@Override
	public boolean execute() {

		String backupFilePath = this.backupFilePath + "\\temp";

		logger.info("Final Migration process to prod-server");
		try {
			String space = " ";
			/*
			 * The code block below will take a dump of the stage 2 and put it
			 * in prod-server
			 */

			/*
			 * Configure the following values in the message.properties file
			 * Structure of String arg is as follows it needs a space seperated
			 * list of arguments in the following order: path to batch file
			 * production server location (IP) production server username
			 * production server password production server schema that needs
			 * backup path to backup folder that will store the backup
			 */

			String arg = this.jobFilePath + space + this.stage2dbHost + space
					+ this.stage2User + space + this.stage2Pass + space
					+ this.stage2Schema + space + backupFilePath + space
					+ this.stage2dbPort;
			logger.debug("temp storage of stage 2 with command :"
					+ arg.replace("\\", "/"));
			Process thread = Runtime.getRuntime().exec(arg);
			thread.waitFor();
			logger.debug("stage 2 database backup is now updated to file -> "
					+ backupFilePath.replace("\\", "/"));

			/*
			 * Configure the following values in the message.properties file
			 * Structure of String arg is as follows it needs a space seperated
			 * list of arguments in the following order: path to batch file
			 * production server location (IP) production server username
			 * production server password production server schema that needs
			 * backup path to backup folder that will store the backup
			 */
			String arg1 = this.stage2jobFilePath + space + this.dbHost + space
					+ this.dbUser + space + this.dbPass + space + this.schema
					+ space + backupFilePath + space + this.dbPort;
			logger.debug("Starting process of dumping to prod db with args :"
					+ arg1.replace("\\", "/"));
			thread = Runtime.getRuntime().exec(arg1);
			thread.waitFor();
			logger.debug("End of Migration Process ...");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

		/*
		 * This return statement has to be replaced by a camel message producer
		 * - will be implemented in future, this would enable parallel
		 * consumption of messages and hence threaded architecture of the DMT
		 * Would speed up things for larger migrations
		 */
	}

	@Override
	public String getMessage() {
		return "Moving to production database";
	}

}
