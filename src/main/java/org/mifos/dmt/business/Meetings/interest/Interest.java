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

package org.mifos.dmt.business.Meetings.interest;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;

import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.configuration.DMTAccountingProperties;

public abstract class Interest {

	protected RoundingMode initialRoundingMode;
	protected RoundingMode finalRoundingMode;
	protected double initialRoundOffMultiple;
	protected double finalRoundOffMultiple;
	protected int digitsAfterDecimal;
	protected int digitsAfterDecimalForInterest;
	protected int currencyId;
	
	protected BigDecimal loanAmount;
	protected BigDecimal amountPaid;
	protected BigDecimal interestRate;
	protected int numberOfInstallments;
	protected BigDecimal duration;
	protected BigDecimal lengthOfPeriod;
	
	protected ArrayList<BigDecimal> principalPerInstallment;
	protected ArrayList<BigDecimal> interestPerInstallment;

	
	public Interest(MigrationParams inputParams) {
		loadConfig();
		this.loanAmount = inputParams.getLoanAmount();
		this.amountPaid = inputParams.getAmountPaid();
		this.interestRate = inputParams.getInterestRate();
		this.numberOfInstallments = inputParams.getNumberOfInstallments();
		this.interestPerInstallment = new ArrayList<BigDecimal>();
		this.principalPerInstallment = new ArrayList<BigDecimal>();
		this.duration = inputParams.getLoanDuration();
		this.lengthOfPeriod = inputParams.getLengthOfPeriod();
	}
	
	private void loadConfig() {
		this.initialRoundingMode = DMTAccountingProperties.INITIAL_ROUNDING_MODE;
		this.finalRoundingMode = DMTAccountingProperties.FINAL_ROUNDING_MODE;
		this.initialRoundOffMultiple = DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE;
		this.finalRoundOffMultiple = DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE;
		this.digitsAfterDecimal = DMTAccountingProperties.DIGITS_AFTER_DECIMAL;
		this.currencyId = DMTAccountingProperties.CURRENCY_ID;
		this.digitsAfterDecimalForInterest = DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST;
		
	}
	public abstract void calculateLoanPayments();

	public ArrayList<BigDecimal> getPrincipalPerInstallment() {
		return principalPerInstallment;
	}

	public ArrayList<BigDecimal> getInterestPerInstallment() {
		return interestPerInstallment;
	}
}
