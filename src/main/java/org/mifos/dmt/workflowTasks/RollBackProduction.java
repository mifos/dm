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

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;

public class RollBackProduction extends Task {
	private static final DMTLogger logger = (DMTLogger) DMTLogger
	.getLogger(RollBackProduction.class.getName());
	
	String dbUser;
	String dbPass;
	String schema;
	String jobFilePath;
	String backupFilePath;
	String dbHost;
	String dbPort;
	
	public RollBackProduction() {
		HashMap<String, String> dbProd = DMTDatabaseConfigurations.PRODUCTION;
		this.dbUser = dbProd.get("user");
		this.dbPass = dbProd.get("password");
		this.schema = dbProd.get("schema");
		this.dbHost = dbProd.get("host");
		this.dbPort = dbProd.get("port");
	
	}
	
	@Override
	public boolean execute() {
		/*
		 * During backup we appended a time stamp to the backup process,
		 * to enable multiple backups of the production can persist thru multiple runs of the
		 * tool. 
		 * The tool currently supports only rollback to a state the production db was at the 
		 * beginning of the CURRENT MIGRATION PROCESS.
		 * If there is a need to roll back to a previous state, the implementor can
		 * manually rollback. Read documentation for more instructions for the same	
		*/ 
		
		/*
		 * Logical code for script gen :
		 *  
		 *  File aDirectory = new File("d:\\kettle\\backup");
		 *	// get a listing of all files in the directory
		 *	String[] filesInDir = aDirectory.list();
		 *	// sort the list of files (optional)
		 *	Arrays.sort(filesInDir);
		 *	System.out.println(filesInDir[filesInDir.length-1] );
		 */
		
		
		logger.info("will try to rollback ->"+ latestbackUp());
		return true;		
	}
	
	private String latestbackUp() {
		File tempDir = new File(this.backupFilePath);
		String[] filesInDir = tempDir.list();
		Arrays.sort(filesInDir);
		return filesInDir[filesInDir.length-1];
		
	}

	@Override
	public String getMessage() {
		return "Due to encountered errors, rolling back production database";
	}
	
}
