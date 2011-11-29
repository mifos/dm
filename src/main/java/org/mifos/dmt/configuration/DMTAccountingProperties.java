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

import java.math.RoundingMode;

import org.apache.commons.configuration.ConfigurationException;
import org.mifos.dmt.logging.DMTLogger;


public class DMTAccountingProperties {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DMTAccountingProperties.class.getName());
	
	public static RoundingMode INITIAL_ROUNDING_MODE;
	public static RoundingMode FINAL_ROUNDING_MODE;
	public static Double INITIAL_ROUNDOFF_MULTIPLE;
	public static Double FINAL_ROUNDOFF_MULTIPLE;
	public static Integer  DIGITS_AFTER_DECIMAL;
	public static Integer  DIGITS_AFTER_DECIMAL_FOR_INTEREST;
	public static Integer  CURRENCY_ID;
	
	static {
		try {
			DMTPropertiesLoader prop = DMTPropertiesLoader.getInstance();
			DIGITS_AFTER_DECIMAL = prop.getInt("AccountingRules.DigitsAfterDecimal");
			DIGITS_AFTER_DECIMAL_FOR_INTEREST = prop.getInt("AccountingRules.DigitsAfterDecimalForInterest");
			INITIAL_ROUNDOFF_MULTIPLE = prop.getDouble("AccountingRules.InitialRoundOffMultiple");
			FINAL_ROUNDOFF_MULTIPLE = prop.getDouble("AccountingRules.FinalRoundOffMultiple");
			INITIAL_ROUNDING_MODE = Enum.valueOf(RoundingMode.class,prop.getString("AccountingRules.InitialRoundingMode"));
			FINAL_ROUNDING_MODE = Enum.valueOf(RoundingMode.class,prop.getString("AccountingRules.FinalRoundingMode"));
			CURRENCY_ID = prop.getInt("AccountingRules.CurrencyId");
		} catch (ConfigurationException e) {
			logger.error("Error while fetching accounting values from properties file - " + e.getMessage());
			e.printStackTrace();
		}
	}
}
