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

package org.mifos.dmt.serviceFactory;

import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTPropertiesLoader;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.workflowTasks.Task;
import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.logging.LogLevel;
import org.pentaho.di.core.logging.LogMessage;
import org.pentaho.di.job.Job;
import org.pentaho.di.job.JobMeta;

public class GenericKettleJobService extends Task {
	
	
	boolean jobStatus;
	private DMTLogger logger;
	private String relPathToKettleJob;
	private List<String> jobQueue;
	private String jobDescription;
	
	
	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}

	public GenericKettleJobService() {
		super();
		jobStatus = true;
		logger = (DMTLogger) DMTLogger.getLogger(GenericKettleJobService.class.getName());
		this.relPathToKettleJob = DMTConfig.DMT_CONFIG_DIR;
		jobQueue = new LinkedList<String>();
	}
	
	@Override
	public boolean execute() throws DMTException {
		ListIterator<String> listItr = jobQueue.listIterator();
		while (listItr.hasNext() && jobStatus) {
			String jobRelPath = (String) listItr.next();
			jobStatus = delegateToExecute(jobRelPath);
		}
		return jobStatus;
	}

	private boolean delegateToExecute(String jobRelPath) throws DMTException {
		boolean jobSuccess = false;
		logger.info("Executing "+jobRelPath.substring(jobRelPath.lastIndexOf("\\")+1, jobRelPath.lastIndexOf(".")));
		String pathToJob = jobRelPath;
		boolean preConditions = preCheckConditions(pathToJob, jobRelPath);
		String absJobPath = relPathToKettleJob + pathToJob;
		if (preConditions) {
			//execute job
			jobSuccess = executeJob(absJobPath);
		} else {
			logger.error("DMT cannot proceed with Job execution due to previous errors");
			throw new DMTException("DMT cannot proceed with Job execution due to previous errors"); 
		}
		return jobSuccess;
	}

	private boolean executeJob(String absJobPath) throws DMTException {
		try {
			KettleEnvironment.init();
			JobMeta jobMeta = new JobMeta(absJobPath, null);
			Job job = new Job(null, jobMeta);
			job.start();
			job.setLogLevel(LogLevel.ERROR);
			job.waitUntilFinished();
			if (LogMessage.logs.size() > 0) {
				for (int i = 0; i < LogMessage.logs.size(); i++) {
					if (LogMessage.logs.get(i).get(0).equalsIgnoreCase("error"))
						logger.error(LogMessage.logs.get(i).get(1));
				}
			}
			LogMessage.logs.clear();
			if (job.getErrors() >= 0) {
				//logger.error("Errors in executing kettle job "+absJobPath.substring(absJobPath.lastIndexOf("\\")));
			}
		} catch (KettleException e) {
			LogMessage.logs.clear();
			logger.error("Kettle Exception thrown, halting migration:"+ e);
			return false;
		}
		return true;
	}

	private boolean preCheckConditions(String pathToJob, String jobName) {
		if(pathToJob.equalsIgnoreCase("")||relPathToKettleJob.equalsIgnoreCase("")) {
			logger.error(" Missing value for job : "+jobName);
			return false;
		}
		
		return true;
	}

	public void populateTaskQueue(String taskName) throws DMTException {
		DMTPropertiesLoader prop;
		try {
			prop = DMTPropertiesLoader.getInstance();
			if (prop.getString(taskName) != null
					&& prop.getString(taskName) != "x1001") {
				jobQueue.add(prop.getString(taskName));
			} else {
				throw new DMTException(
						"error creating task queue, missing value in DMT.properties for "
								+ taskName);
			}

		} catch (ConfigurationException e) {
			throw new DMTException(
					"error creating task queue, missing value in DMT.properties for "
							+ taskName);
		}
	}
	public String toString() {
		return "generic kettle job service";
	}

	@Override
	public String getMessage() {
		return jobDescription;
	}
}
