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

import org.joda.time.DateTime;
import org.mifos.dmt.logging.DMTLogger;

public class MigrationParams {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(MigrationParams.class.getName()); 
	

	/*
	 * The static final strings should be fully qualified class names so that
	 * we can instantiate them @runtime
	 */
	static final String flat = "org.mifos.dmt.business.Meetings.interest.Flat";
	static final String declining = "org.mifos.dmt.business.Meetings.interest.Declining";
	

	static final String decliningBalanceEPI = "org.mifos.dmt.business.Meetings.interest."; 
		
	static final String weekly = "org.mifos.dmt.business.Meetings.schedule.WeeklySchedule";
	static final String monthlyDOM = "org.mifos.dmt.business.Meetings.schedule.MonthlyScheduleWithDOM";
	static final String monthlyROD = "org.mifos.dmt.business.Meetings.schedule.MonthlyScheduleWithROD";
	
	Integer account_id;
	Integer customer_id;
	Integer currency_id;
	Integer parent_flag;
	Integer version;
	
	DateTime createdDate;
	DateTime disbursementDate;
	Integer recurrenceId;
	Integer interestType;
	
	Integer recurAfter;
	Integer days;
	Integer rankOfDays;
	Integer dayNumber;
	
	BigDecimal loanAmount;
	BigDecimal amountPaid;
	BigDecimal interestRate;
	Integer numberOfInstallments;
	Integer scheduleLength;
	BigDecimal loanDuration;
	BigDecimal lengthOfPeriod;
	
	String scheduleTypeInternal;
	String inerestTypeInternal;
	
	public MigrationParams(Integer account_id, Integer customer_id, Integer currency_id,
			DateTime createdDate, Integer recurrenceId, Integer recurAfter,
			Integer days, Integer rankOfDays, Integer dayNumber) {
		this.account_id = account_id;
		this.customer_id = customer_id;
		this.createdDate = createdDate;
		this.currency_id = currency_id;
		this.recurrenceId = recurrenceId;
		this.recurAfter = recurAfter;
		this.days = days;
		this.rankOfDays = rankOfDays;
		this.dayNumber = dayNumber;
		if(this.recurrenceId == 1) {
			this.scheduleTypeInternal = weekly;
		} else if (this.recurrenceId == 2) {
			if (!(dayNumber == 0)) {
				this.scheduleTypeInternal = monthlyDOM;
			} else {
				this.scheduleTypeInternal = monthlyROD;
			}
		} else {
			logger.error("Invalid recurrence ID for customer_id:"+customer_id+" at stage1 database");
		}
	}
	public MigrationParams(Integer account_id, Integer customer_id, Integer currency_id,
			DateTime createdDate, DateTime disbursementDate, Integer recurrenceId,
			Integer interestType, Integer recurAfter, Integer days, Integer rankOfDays, Integer dayNumber,
			BigDecimal loanAmount, BigDecimal amountPaid, BigDecimal interestRate,
			Integer numberOfInstallments) {
		this.account_id = account_id;
		this.customer_id = customer_id;
		this.currency_id = currency_id;
		this.createdDate = createdDate;
		this.disbursementDate = disbursementDate;
		this.recurrenceId = recurrenceId;
		this.interestType = interestType;
		this.recurAfter = recurAfter;
		this.days = days;
		this.rankOfDays = rankOfDays;
		this.dayNumber = dayNumber;
		this.loanAmount = loanAmount;
		this.amountPaid = amountPaid;
		this.interestRate = interestRate;
		this.numberOfInstallments = numberOfInstallments;
		this.scheduleLength = 10;
		
		if(this.recurrenceId == 1) {
			this.scheduleTypeInternal = weekly;
		} else if (this.recurrenceId == 2) {
			if (!(dayNumber == 0)) {
				this.scheduleTypeInternal = monthlyDOM;
			} else {
				this.scheduleTypeInternal = monthlyROD;
			}
		} else {
			logger.error("Invalid recurrence ID for customer_id:"+customer_id+" at stage1 database");
		}
		
		if(this.interestType == 1) {
			this.inerestTypeInternal = flat;
		} else if (this.interestType == 2) {
			this.inerestTypeInternal = declining;
		} else if (this.interestType == 3) {
			this.inerestTypeInternal = decliningBalanceEPI;
		} else {
			logger.error("Invalid interest type for customer_id:"+customer_id+" at stage1 database");
		}
		
		
	}

	public Integer getAccount_id() {
		return account_id;
	}

	public void setAccount_id(Integer account_id) {
		this.account_id = account_id;
	}

	public Integer getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(Integer customer_id) {
		this.customer_id = customer_id;
	}

	public Integer getCurrency_id() {
		return currency_id;
	}

	public void setCurrency_id(Integer currency_id) {
		this.currency_id = currency_id;
	}

	public DateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(DateTime createdDate) {
		this.createdDate = createdDate;
	}

	public DateTime getDisbursementDate() {
		return disbursementDate;
	}

	public void setDisbursementDate(DateTime disbursementDate) {
		this.disbursementDate = disbursementDate;
	}

	public Integer getRecurrenceId() {
		return recurrenceId;
	}

	public void setRecurrenceId(Integer recurrenceId) {
		this.recurrenceId = recurrenceId;
	}

	public Integer getRecurAfter() {
		return recurAfter;
	}

	public void setRecurAfter(Integer recurAfter) {
		this.recurAfter = recurAfter;
	}

	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	public Integer getRankOfDays() {
		return rankOfDays;
	}

	public void setRankOfDays(Integer rankOfDays) {
		this.rankOfDays = rankOfDays;
	}

	public Integer getDayNumber() {
		return dayNumber;
	}

	public void setDayNumber(Integer dayNumber) {
		this.dayNumber = dayNumber;
	}

	public BigDecimal getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(BigDecimal loanAmount) {
		this.loanAmount = loanAmount;
	}

	public BigDecimal getAmountPaid() {
		if( amountPaid!=null) {
			return amountPaid;
		} else {
			return BigDecimal.ZERO;
		}
	}

	public void setAmountPaid(BigDecimal amountPaid) {
		this.amountPaid = amountPaid;
	}

	public BigDecimal getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(BigDecimal interestRate) {
		this.interestRate = interestRate;
	}

	public Integer getNumberOfInstallments() {
		return numberOfInstallments;
	}

	public void setNumberOfInstallments(Integer numberOfInstallments) {
		this.numberOfInstallments = numberOfInstallments;
	}
	
	public Integer getScheduleLength() {
		return scheduleLength;
	}
	
	public BigDecimal getLoanDuration() {
		return loanDuration;
	}

	public void setLoanDuration(BigDecimal loanDuration) {
		this.loanDuration = loanDuration;
	}

	public BigDecimal getLengthOfPeriod() {
		return lengthOfPeriod;
	}

	public void setLengthOfPeriod(BigDecimal lengthOfPeriod) {
		this.lengthOfPeriod = lengthOfPeriod;
	}

	public String getScheduleTypeInternal() {
		return scheduleTypeInternal;
	}

	public void setScheduleTypeInternal(String scheduleTypeInternal) {
		this.scheduleTypeInternal = scheduleTypeInternal;
	}

	public String getInerestTypeInternal() {
		return inerestTypeInternal;
	}

	public void setInerestTypeInternal(String inerestTypeInternal) {
		this.inerestTypeInternal = inerestTypeInternal;
	}
}