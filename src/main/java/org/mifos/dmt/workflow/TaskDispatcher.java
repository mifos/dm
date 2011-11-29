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
import java.util.ListIterator;

import org.mifos.dmt.logging.DMTLogStore;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTLock;
import org.mifos.dmt.workflowTasks.Task;

public class TaskDispatcher {

	static final DMTLogger logger = (DMTLogger) DMTLogger
			.getLogger(TaskDispatcher.class.getName());

	public void dispatchDMTTasks() {
		try {
			DMTLock migrationLock = DMTLock.getInstance();
			if (!migrationLock.isLocked()) {
				migrationLock.getLock();
				TaskQueue dmtTasks = new TaskQueue();
				dmtTasks.createDMTRoute();
				//FIXME create a getter for taskqueue
				ArrayList<Task> taskQueue = dmtTasks.taskQueue;
				ListIterator<Task> iterator = taskQueue.listIterator();
				boolean status = true;
				clearLogs();
				while (iterator.hasNext() && status) {
					Task task = (Task) iterator.next();
					// TODO remove the null message from the queue.
					logger.info(task.getMessage() + task.getClass().getName());
					status = task.execute();
				}
				migrationLock.releaseLock();
				logger.info("Data Migration Toolkit successfully completed migration");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void clearLogs() {
		DMTLogStore temp = DMTLogStore.getInstance();
		temp.clearLogs();

	}

}
