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

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class DMTLogger extends Logger {
	private String FQCN = DMTLogger.class.getName() + ".";
	private static DMTLogFactory factory = new DMTLogFactory();

	protected DMTLogger(String name) {
		super(name);
	}

	public void debug(Object message) {
		super.log(FQCN, Level.DEBUG, message, null);
		DMTLogStore logStore = DMTLogStore.getInstance();
		logStore.addToLogs(FQCN, "Debug", (String) message);
	}

	public void info(Object message) {
		super.log(FQCN, Level.INFO, message, null);
		DMTLogStore logStore = DMTLogStore.getInstance();
		logStore.addToLogs(FQCN, "Info", (String) message);
	}
	
	public void error(Object message) {
		super.log(FQCN, Level.ERROR, message, null);
		DMTLogStore logStore = DMTLogStore.getInstance();
		logStore.addToLogs(FQCN, "Error", (String) message);
	}

	public static Logger getLogger(String name) {
		return Logger.getLogger(name, factory);
	}

}
