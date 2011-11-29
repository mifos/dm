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

package org.mifos.dmt.business.Meetings.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

import org.mifos.dmt.business.Meetings.dao.FeesLookUp;
import org.mifos.dmt.business.Meetings.schedule.Schedule;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;

public class CustomerAccount {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(CustomerAccount.class.getName());
	private String scheduleType;
	
	private MigrationParams inputParams;
	private int account_id;
	private int customer_id;
	private int currency_id;
	private int parent_flag;
	private int version;
	private ArrayList<String> schedule;
	private Integer numberOfDates;
	private ArrayList<HashMap<String, Object>> detailsForCustomer;
	
	public CustomerAccount(MigrationParams inputParams) throws DMTException {
		this.inputParams = inputParams;
		this.account_id = inputParams.getAccount_id();
		this.customer_id = inputParams.getCustomer_id();
		this.currency_id = inputParams.getCurrency_id();
		this.numberOfDates = 10;
		this.scheduleType = inputParams.getScheduleTypeInternal();
		this.parent_flag = 0;
		this.version = 0;
		detailsForCustomer = new ArrayList<HashMap<String, Object>>();
		process();
	}
	
	private void generateSchedule() throws DMTException { 
		try {
			Schedule scheduleGenerator = (Schedule) Class.forName(scheduleType).getConstructor(MigrationParams.class).newInstance(inputParams);
			scheduleGenerator.generateSchedule(this.numberOfDates);
			this.schedule = scheduleGenerator.scheduleList;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new DMTException(e.getMessage());
		} 
	}
	
	private void populateScheduleToCustomer() {
		HashMap<String, Object> actionDateMap = new HashMap<String, Object>();
		FeesLookUp feeLookup = new FeesLookUp(inputParams.getAccount_id());
		int paymentStatus = (feeLookup.isCustomerFeeAttached()) ? 1 : 0;
		for(int i=0;i<this.numberOfDates;i++) {
			//actionDateMap.clear();
			actionDateMap.put("accountId", this.account_id);
			actionDateMap.put("customerId", this.customer_id);
			actionDateMap.put("currencyId", this.currency_id);
			actionDateMap.put("actionDate", this.schedule.get(i));
			actionDateMap.put("miscFees", BigDecimal.ZERO);
			actionDateMap.put("miscPenalty", BigDecimal.ZERO);
			actionDateMap.put("penaltyPaid", BigDecimal.ZERO);
			actionDateMap.put("miscFeesPaid", BigDecimal.ZERO);
			actionDateMap.put("miscPenaltyPaid", BigDecimal.ZERO);
			actionDateMap.put("paymentStatus", ((i==0) ? paymentStatus : 0));
			actionDateMap.put("installmentId", (i+1));
			actionDateMap.put("paymentDate", ((i==0&&paymentStatus==1)?this.schedule.get(i):null));			
			actionDateMap.put("parentFlag", this.parent_flag);
			actionDateMap.put("versionNumber", this.version);
			this.detailsForCustomer.add(extracted(actionDateMap));
		}
		
	}
	
	@SuppressWarnings("unchecked")
	private HashMap<String, Object> extracted(
			HashMap<String, Object> actionDateMap) {
		HashMap<String, Object> obj = (HashMap<String, Object>) actionDateMap.clone();
		return obj;
	}
	
	private void process() throws DMTException {
		generateSchedule();
		populateScheduleToCustomer();
	}

	public ArrayList<HashMap<String, Object>> getLoanDetailsForCustomer() {
		return detailsForCustomer;
	}

	
}
