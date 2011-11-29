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

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.logging.DMTLogger;

public class DMTConfig {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DMTConfig.class.getName());
	
	public static String DMT_CONFIG_DIR;
	public static String DUMP_DATABASE_ROUTINE;
	public static String BACKUP_TEMP_DIR;
	public static String LOAD_TO_DATABASE_ROUTINE;
	public static String MIGRATION_BASE_SQL_TEMPLATE;
	public static String JNDI_ROOT_DIR;
	
	static {
		try {
			DMTPropertiesLoader prop = DMTPropertiesLoader.getInstance();
			DMT_CONFIG_DIR = prop.getString("DMT_CONF");
			DUMP_DATABASE_ROUTINE = prop.getString("DUMP_DATABASE_ROUTINE");
			BACKUP_TEMP_DIR = prop.getString("BACKUP_TEMP_DIR");
			LOAD_TO_DATABASE_ROUTINE = prop.getString("LOAD_TO_DATABASE_ROUTINE");
			MIGRATION_BASE_SQL_TEMPLATE = prop.getString("MIGRATION_BASE_SQL_TEMPLATE");
			JNDI_ROOT_DIR = prop.getString("JNDI_ROOT_DIR");
		} catch (ConfigurationException e) {
			logger.error("Error while fetching config values from properties file - " + e.getMessage());
			e.printStackTrace();
		}
	}
}
