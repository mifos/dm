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

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.EnvironmentConfiguration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.SystemConfiguration;

public class DMTPropertiesLoader {

	private static DMTPropertiesLoader propertiesObj = null;
	private CompositeConfiguration config;
	
	private DMTPropertiesLoader() throws ConfigurationException {
		config = new CompositeConfiguration();
		config.addConfiguration(new SystemConfiguration());
		config.addConfiguration(new EnvironmentConfiguration());
		String confPath = config.getString("DMT_CONF");
		if(confPath==null || confPath=="" || confPath.equalsIgnoreCase("")) {
			throw new ConfigurationException("DMT_CONF not defined");
		}
		config.addConfiguration(new PropertiesConfiguration(confPath+"\\dmt.custom.properties"));
		config.addConfiguration(new PropertiesConfiguration("dmt.properties"));
		config.setThrowExceptionOnMissing(true);
	}
	
	@SuppressWarnings("rawtypes")
	public Iterator getKeys(String key) {
		return config.getKeys(key);
	}
	
	public static DMTPropertiesLoader  getInstance() throws ConfigurationException {
		if (propertiesObj == null) {
			propertiesObj = new DMTPropertiesLoader();
		}
		return propertiesObj;
	}
	
	public Object clone() throws CloneNotSupportedException {
		throw new CloneNotSupportedException();
	}
	
	public String getString(String key) {
		return config.getString(key);
	}
	
	public int getInt(String key) {
		return config.getInt(key, 0);
	}
	
	public BigDecimal getBigDecimal(String key) {
		return config.getBigDecimal(key);
	}
	
	public boolean getBoolean(String key) {
		return config.getBoolean(key);
	}

	public double getDouble(String key) {
		return config.getDouble(key);
	}
	
	@SuppressWarnings("rawtypes")
	public List getAllValues(String key) {
		return config.getList(key);
	}
}
