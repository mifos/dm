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

package org.mifos.dmt.workflow;

import java.util.ArrayList;

import org.mifos.dmt.configuration.DMTMigrationConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.serviceFactory.GenericKettleJobService;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.workflowTasks.Task;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TaskQueue {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(TaskQueue.class.getName());
	private static final String[] LOCATIONS = {"context.xml"};
	public ArrayList<Task> taskQueue;
	private GenericKettleJobService excelJobPreScheduleGeneration;
	private GenericKettleJobService excelJobPostScheduleGeneration;
	private GenericKettleJobService loadToStage2;
	
	public TaskQueue() {
		taskQueue = new ArrayList<Task>();
		excelJobPreScheduleGeneration = new GenericKettleJobService();
		excelJobPreScheduleGeneration.setJobDescription("loading data from excel to DMT staging");
		excelJobPostScheduleGeneration = new GenericKettleJobService();
		excelJobPostScheduleGeneration.setJobDescription("Loading data from excel to DMT staging");
		loadToStage2 = new GenericKettleJobService();
	}
	
	public void  createDMTRoute() throws DMTException {
		logger.info("Creating DMT task queue");
		configurePreScheduleGenerationJob();
		configurePostScheduleGenerationJob();
		configureLoadToStage2();
		/*
		 * Create tasks from bean def
		 */
		ApplicationContext context = new ClassPathXmlApplicationContext(LOCATIONS);
		taskQueue.add((Task) context.getBean("prepStaging"));
		taskQueue.add((Task) context.getBean("dmtParamInjection"));
		taskQueue.add((GenericKettleJobService) excelJobPreScheduleGeneration);
		taskQueue.add((Task) context.getBean("generateCustomerSchedule"));
		taskQueue.add((Task) context.getBean("generateLoanSchedule"));
		taskQueue.add((Task) excelJobPostScheduleGeneration);
		taskQueue.add((Task) context.getBean("validate"));
		taskQueue.add((Task) context.getBean("loadProductionDataToDMT"));
		taskQueue.add((Task) loadToStage2);
		taskQueue.add((Task) context.getBean("finalStepOfMigration"));
	}

	private void configureLoadToStage2() throws DMTException {
		final String migrateCustomer = "DMT.Task.migrateCustomer";
		final String migrateCustomerMeetings = "DMT.Task.migrateCustomerMeetings";
		final String migrateAccounts = "DMT.Task.migrateAccounts";
		final String migrateloanAccounts = "DMT.Task.migrateLoanAccounts";
		final String migrateTrxn = "DMT.Task.migrateTrxn";
		final String migrateCustomFeilds = "DMT.Task.migrateCustomFeilds";
	
		loadToStage2.populateTaskQueue(migrateCustomer);
		loadToStage2.populateTaskQueue(migrateCustomerMeetings);
		loadToStage2.populateTaskQueue(migrateAccounts);
		loadToStage2.populateTaskQueue(migrateloanAccounts);
		loadToStage2.populateTaskQueue(migrateTrxn);
		loadToStage2.populateTaskQueue(migrateCustomFeilds);
		
	}

	private void configurePostScheduleGenerationJob() throws DMTException {
		final String feesUpdation = "DMT.Task.feesUpdation";
		final String updateLoanAccounts = "DMT.Task.updateLoanAccounts";
		final String generateTrxn = "DMT.Task.generateTrxn";
		final String alterTablesFinal = "DMT.Task.alterTablesFinal";
		
		excelJobPostScheduleGeneration.populateTaskQueue(feesUpdation);
		excelJobPostScheduleGeneration.populateTaskQueue(updateLoanAccounts);
		excelJobPostScheduleGeneration.populateTaskQueue(generateTrxn);
		excelJobPostScheduleGeneration.populateTaskQueue(alterTablesFinal);
	}

	private void configurePreScheduleGenerationJob() throws DMTException {
		final String alterTables = "DMT.Task.alterTables";
		final String migrateCenter = "DMT.Task.loadCenter";
		final String migrateGroups = "DMT.Task.loadGroups";
		final String migrateClients = "DMT.Task.loadClients";
		final String migrateIndividualClients = "DMT.Task.loadIndividualClients";
		final String migrateMeetings = "DMT.Task.loadMeetings";
		final String migrateIndividualMeetings = "DMT.Task.loadIndividualMeetings";
		final String migrateFamily = "DMT.Task.loadFamily";
		final String migrateLoanAccounts = "DMT.Task.loadLoanAccounts";
		final String migrateGroupLoans = "DMT.Task.loadGroupLoans";
		final String migrateCustomFeilds = "DMT.Task.loadCustomFeilds";
		final String migrateFees = "DMT.Task.loadFees";
		
		excelJobPreScheduleGeneration.populateTaskQueue(alterTables);
		
		if(DMTMigrationConfigurations.MIGRATE_CENTER)
				excelJobPreScheduleGeneration.populateTaskQueue(migrateCenter);
		excelJobPreScheduleGeneration.populateTaskQueue(migrateGroups);
		excelJobPreScheduleGeneration.populateTaskQueue(migrateClients);
		if(DMTMigrationConfigurations.MIGRATE_INDIVIDUAL_CLIENTS)
			excelJobPreScheduleGeneration.populateTaskQueue(migrateIndividualClients);
		excelJobPreScheduleGeneration.populateTaskQueue(migrateMeetings);
		if(DMTMigrationConfigurations.MIGRATE_INDIVIDUAL_CLIENTS)
			excelJobPreScheduleGeneration.populateTaskQueue(migrateIndividualMeetings);
		excelJobPreScheduleGeneration.populateTaskQueue(migrateFamily);
		excelJobPreScheduleGeneration.populateTaskQueue(migrateLoanAccounts);	
		if(DMTMigrationConfigurations.MIGRATE_GROUP_LOANS)
			excelJobPreScheduleGeneration.populateTaskQueue(migrateGroupLoans);
		if(DMTMigrationConfigurations.MIGRATE_CUSTOM_FEILDS)
			excelJobPreScheduleGeneration.populateTaskQueue(migrateCustomFeilds);
		if(DMTMigrationConfigurations.MIGRATE_FEES)
			excelJobPreScheduleGeneration.populateTaskQueue(migrateFees);
	}
}
