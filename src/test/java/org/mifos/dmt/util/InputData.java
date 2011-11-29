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

import java.math.BigDecimal;

import org.joda.time.DateTime;

public class InputData implements Cloneable {
	
	Integer account;
	Integer customer;
	Integer currency;
	DateTime createdDate;
	DateTime discursementDate;
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
	BigDecimal loanDuration;
	BigDecimal lengthOfPeriod;
	
	
	public BigDecimal getLengthOfPeriod() {
		return lengthOfPeriod;
	}


	public void setLengthOfPeriod(BigDecimal lengthOfPeriod) {
		this.lengthOfPeriod = lengthOfPeriod;
	}


	public Integer getAccount() {
		return account;
	}


	public void setAccount(Integer account) {
		this.account = account;
	}


	public Integer getCustomer() {
		return customer;
	}


	public void setCustomer(Integer customer) {
		this.customer = customer;
	}


	public Integer getCurrency() {
		return currency;
	}


	public void setCurrency(Integer currency) {
		this.currency = currency;
	}


	public DateTime getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(DateTime createdDate) {
		this.createdDate = createdDate;
	}


	public DateTime getDiscursementDate() {
		return discursementDate;
	}


	public void setDiscursementDate(DateTime discursementDate) {
		this.discursementDate = discursementDate;
	}


	public Integer getRecurrenceId() {
		return recurrenceId;
	}


	public void setRecurrenceId(Integer recurrenceId) {
		this.recurrenceId = recurrenceId;
	}


	public Integer getInterestType() {
		return interestType;
	}


	public void setInterestType(Integer interestType) {
		this.interestType = interestType;
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
		return amountPaid;
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


	public BigDecimal getLoanDuration() {
		return loanDuration;
	}


	public void setLoanDuration(BigDecimal loanDuration) {
		this.loanDuration = loanDuration;
	}


	public InputData clone() throws CloneNotSupportedException {
		return (InputData) super.clone();
	}
	
	
}
