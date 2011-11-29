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

public class PrepStaging extends Task {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(PrepStaging.class
			.getName());

	private String stage1User;
	private String stage1Pass;
	private String stage1Schema;
	private String stage1dbHost;
	private String stage1dbPort;
	private String stage2jobFilePath;
	private String stage1Sql;

	public PrepStaging() {
		HashMap<String, String> dbVals = DMTDatabaseConfigurations.STAGING_1;
		this.stage1User = dbVals.get("user");
		this.stage1Pass = dbVals.get("password");
		this.stage1dbHost = dbVals.get("host");
		this.stage1Schema =  dbVals.get("schema");
		this.stage1dbPort = dbVals.get("port");
		this.stage1Sql = DMTConfig.DMT_CONFIG_DIR
		+ DMTConfig.MIGRATION_BASE_SQL_TEMPLATE;
		this.stage2jobFilePath = DMTConfig.DMT_CONFIG_DIR
		+ "\\prepStaging.bat";
	}

	@Override
	public boolean execute() {
		try {
			String space = " ";
			logger.info("Prepearing stage1 schema to begin migration");
			String shellCommand = this.stage2jobFilePath + space + this.stage1dbHost
					+ space + this.stage1User + space + this.stage1Pass + space
					+ this.stage1Schema + space + this.stage1Sql + space + this.stage1dbPort;
			logger.debug("Stage 1 prep started with -> "
					+ shellCommand.replace("\\", "/"));
			Process thread = Runtime.getRuntime().exec(shellCommand);
			thread.waitFor();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public String getMessage() {
		return "Preparing a staging database for the DMT";
	}
}
