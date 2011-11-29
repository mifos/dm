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

package org.mifos.dmt.configuration;

import java.util.HashMap;
import java.util.Iterator;

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.logging.DMTLogger;

public class DMTDatabaseConfigurations {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DMTDatabaseConfigurations.class.getName());

	public static HashMap<String, String> STAGING_1;
	public static HashMap<String, String> STAGING_2;
	public static HashMap<String, String> PRODUCTION;
	
	static {
		try {
			STAGING_1 = getValues("DatabaseConfig.Stage1");
			STAGING_2 = getValues("DatabaseConfig.Stage2");
			PRODUCTION = getValues("DatabaseConfig.Production");
		} catch (ConfigurationException e) {
			logger.error("Error while fetching database config values from properties file - "+e.getMessage());
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("rawtypes")
	private static HashMap<String, String> getValues(String preFix) throws ConfigurationException {
		DMTPropertiesLoader prop = DMTPropertiesLoader.getInstance();
		Iterator itr = prop.getKeys(preFix);
		HashMap<String, String> valueMap = new HashMap<String, String>();
		while (itr.hasNext()) {
			String key = (String) itr.next();
			valueMap.put(key.substring(key.lastIndexOf(".")+1).toLowerCase(), prop.getString(key));
		}
		return valueMap;
	}
	
}
