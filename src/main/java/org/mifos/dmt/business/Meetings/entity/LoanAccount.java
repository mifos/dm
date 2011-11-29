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
import java.util.List;

import org.mifos.dmt.business.Meetings.dao.LoanFeesDAO;
import org.mifos.dmt.business.Meetings.interest.Interest;
import org.mifos.dmt.business.Meetings.repayments.LoanRepayment;
import org.mifos.dmt.business.Meetings.schedule.Schedule;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;


public class LoanAccount {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(LoanAccount.class.getName());
	private String scheduleType;
	private String interestType;
	private boolean isFeeAttached;
	private LoanFeesDAO insertFees;
	
	private MigrationParams inputParams;
	private int account_id;
	private int customer_id;
	private int currency_id;
	private int parent_flag;
	private int version;
	private int numberOfInstallments;
	private ArrayList<String> schedule;
	
	private ArrayList<HashMap<String, Object>> loanDetailsForCustomer;
	private ArrayList<BigDecimal> principalPerInstallment;
	private ArrayList<BigDecimal> interestPerInstallment;
	private ArrayList<HashMap<String, Object>> loanFeeDetails;
	
	public LoanAccount(MigrationParams inputParams) throws DMTException {
		this.isFeeAttached = false;
		this.inputParams = inputParams;
		this.account_id = inputParams.getAccount_id();
		this.customer_id = inputParams.getCustomer_id();
		this.currency_id = inputParams.getCurrency_id();
		this.numberOfInstallments = inputParams.getNumberOfInstallments();
		this.scheduleType = inputParams.getScheduleTypeInternal();
		this.interestType = inputParams.getInerestTypeInternal();
		
		
		this.schedule = new ArrayList<String>();
		new HashMap<String, Object>();
		this.loanDetailsForCustomer = new ArrayList<HashMap<String, Object>>();
		this.principalPerInstallment = new ArrayList<BigDecimal>();
		this.interestPerInstallment = new ArrayList<BigDecimal>();
		process();
	}
	
	private void populateScheduleToCustomer() {
		HashMap<String, Object> actionDateMap = new HashMap<String, Object>();
		for(int i=0;i<this.numberOfInstallments;i++) {
			//actionDateMap.clear();
			actionDateMap.put("accountId", this.account_id);
			actionDateMap.put("customerId", this.customer_id);
			actionDateMap.put("currencyId", this.currency_id);
			actionDateMap.put("actionDate", this.schedule.get(i));
			actionDateMap.put("installmentId", (i+1));
			actionDateMap.put("penalty", BigDecimal.ZERO);
			actionDateMap.put("miscFees", BigDecimal.ZERO);
			actionDateMap.put("miscPenalty", BigDecimal.ZERO);
			actionDateMap.put("penaltyPaid", BigDecimal.ZERO);
			actionDateMap.put("miscFeesPaid", BigDecimal.ZERO);
			actionDateMap.put("miscPenaltyPaid", BigDecimal.ZERO);
			actionDateMap.put("principalPaid", BigDecimal.ZERO);
			actionDateMap.put("interestPaid", BigDecimal.ZERO);
			actionDateMap.put("paymentStatus", 0);
			actionDateMap.put("installmentId", (i+1));
			actionDateMap.put("paymentDate", null);
			actionDateMap.put("parentFlag", this.parent_flag);
			actionDateMap.put("versionNumber", this.version);
			this.loanDetailsForCustomer.add(extracted(actionDateMap));
		}
	}

	@SuppressWarnings("unchecked")
	private HashMap<String, Object> extracted(
			HashMap<String, Object> actionDateMap) {
		HashMap<String, Object> obj = (HashMap<String, Object>) actionDateMap.clone();
		return obj;
	}
	
	/*
	 * call after interest is calculated, and the principal and interest components 
	 * are calculated for every installment
	 */
	private void insertValuesForActionDate() {
		for(int index=0; index<this.numberOfInstallments; index++) {
			loanDetailsForCustomer.get(index).put("principal", principalPerInstallment.get(index));
			loanDetailsForCustomer.get(index).put("interest", interestPerInstallment.get(index));
		}
	}

	private void calculateInstallments() throws DMTException {
		try {
			Interest interestCalculator = (Interest) Class.forName(interestType).getConstructor(MigrationParams.class).newInstance(inputParams);
			interestCalculator.calculateLoanPayments();
			this.principalPerInstallment = interestCalculator.getPrincipalPerInstallment();
			this.interestPerInstallment = interestCalculator.getInterestPerInstallment();
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new DMTException(e.getMessage());
		} 
		
	}
	
	private void generateScheduleAndDuration() throws DMTException { 
		try {
			Schedule scheduleGenerator = (Schedule) Class.forName(scheduleType).getConstructor(MigrationParams.class).newInstance(inputParams);
			scheduleGenerator.generateSchedule(this.numberOfInstallments);
			this.inputParams.setLoanDuration(scheduleGenerator.getLoanDuration(this.numberOfInstallments));
			this.inputParams.setLengthOfPeriod(scheduleGenerator.getLengthOfPeriod());
			this.schedule = scheduleGenerator.scheduleList;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new DMTException(e.getMessage());
		} 
	}

	
	private List<Object> adjustRepayments() {
		List<Object> feeDetails = new ArrayList<Object>();
		LoanRepayment loanRepayment = new LoanRepayment(this.inputParams);
		this.loanDetailsForCustomer = loanRepayment.processRepayments(this.loanDetailsForCustomer, this.inputParams);
		feeDetails.add(loanRepayment.getFeesPaid());
		feeDetails.add(loanRepayment.getIsFeeAttached());
		this.loanFeeDetails = loanRepayment.feesLookup.getLoanFeeDetails();
		return feeDetails;
	}

	private void process() throws DMTException {
		//FIXME order of execution needs to be changed
		List<Object> feesDetails = new ArrayList<Object>();
		this.generateScheduleAndDuration();
		this.calculateInstallments();
		this.populateScheduleToCustomer();
		this.insertValuesForActionDate();
		feesDetails = this.adjustRepayments();
		BigDecimal feesPaid = (BigDecimal) feesDetails.get(0);
		isFeeAttached = (Boolean) feesDetails.get(1);
		if(isFeeAttached) {
			this.insertValuesForFeesPayment(feesPaid);
		}
	}

	private void insertValuesForFeesPayment(BigDecimal feesPaid) {
		insertFees = new LoanFeesDAO(this.inputParams, loanFeeDetails, feesPaid);
	}

	public LoanFeesDAO getInsertFees() {
		return insertFees;
	}

	public boolean isFeeAttached() {
		return isFeeAttached;
	}

	public ArrayList<HashMap<String, Object>> getLoanDetailsForCustomer() {
		return loanDetailsForCustomer;
	}
}
