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

package org.mifos.dmt.logging;

import java.util.ArrayList;


public class DMTLogStore {
	
	private static volatile DMTLogStore loggerObject = new DMTLogStore();
	private ArrayList<ArrayList<String>> logQueue;
	
	private DMTLogStore() {
		setLogQueue(new ArrayList<ArrayList<String>>());
	}
	
	public static synchronized DMTLogStore getInstance() {
		return loggerObject;
	}
	
	public Object clone() throws CloneNotSupportedException {
		throw new CloneNotSupportedException();
	}
	
	public void addToLogs(String logger, String level, String message) {
		ArrayList<String> temp = new ArrayList<String>();
		temp.add(level);
		temp.add(message);
		this.logQueue.add(temp);
	}

	public void setLogQueue(ArrayList<ArrayList<String>> queue) {
		this.logQueue = queue;
	}

	public ArrayList<ArrayList<String>> getLogQueue() {
		return logQueue;
	}

	public void clearLogs() {
		this.logQueue.clear();
		
	}
}
