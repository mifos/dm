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

package org.mifos.dmt.util;

import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.logging.DMTLogger;

public class JndiConfig {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(JndiConfig.class
			.getName());
	static String jndiPath = DMTConfig.DMT_CONFIG_DIR + DMTConfig.JNDI_ROOT_DIR;

	public static void SetSysParams() {
	//	if (!isSetSysProperty()) {
			System.setProperty("java.naming.factory.initial",
					"org.osjava.sj.SimpleContextFactory");
			System.setProperty("org.osjava.sj.root", jndiPath);
			System.setProperty("org.osjava.sj.delimiter", "/");
		//}
	}
	
	public static void unSetSysParams() { 
		logger.debug("clearing JNDI settings");
		System.clearProperty("java.naming.factory.initial");
		System.clearProperty("org.osjava.sj.root");
		System.clearProperty("org.osjava.sj.delimiter");
	}	
	
	public static boolean isSetSysProperty() {
		if(System.getProperty("java.naming.factory.initial")!=null) 
			return true;
		return false;		
	}
}
