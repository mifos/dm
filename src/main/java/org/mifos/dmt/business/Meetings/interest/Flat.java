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
import java.math.MathContext;

import org.mifos.dmt.business.Meetings.entity.MigrationParams;

public class Flat extends Interest {
	
	public Flat(MigrationParams inputParams) {
		super(inputParams);
	}
	
	@Override
	public void calculateLoanPayments() {
		/*
		 * Brief of the process thats followed for calculation
		 * of flat interest of loans
		 * 1. Total interest is calculated
		 * 2. Interest per installment is calculated as total interest/number of installments
		 * 3. Total repayment is calculated as total interest + principle
		 * 4. The repayment is rounded based on rounding mode, 
		 * 		digits after decimal is set for all currency values
		 * 5. The repayment of that installment is calculated as a sum of interest + 
		 * 		principle per installment in reverse order
		 * 6. The remaining interest and principle is adjusted in the last installment,
		 * 		rounding is done according to the final rounding mode.
		 */
		
		BigDecimal numInstall = getNumberOfInstallments(this.numberOfInstallments);
		BigDecimal principle = this.loanAmount;
		BigDecimal duration = this.duration;
		BigDecimal totalInterest = getTotalInterest(principle, duration,
				this.interestRate);
		BigDecimal totalRepayment = totalInterest.add(principle);
		BigDecimal repaymentPerInstallment = getRepaymentPerInstallment(
				totalRepayment, numInstall);
		BigDecimal interestPerInstallment = getInterestPerInstallment(
				totalInterest, numInstall);
		BigDecimal principlePerInstallment = getPrinciplePerInstallment(
				repaymentPerInstallment, interestPerInstallment, numInstall);
		BigDecimal principleLastInstallment = getPrincipleLastInstallment(
				principle, principlePerInstallment, numInstall);
		BigDecimal interestLastInstallment = getInterestLastInstallment(
				totalInterest, interestPerInstallment, numInstall);	
		
		for(int i=0; i<this.numberOfInstallments-1;i++) {
			this.principalPerInstallment.add(principlePerInstallment);
			this.interestPerInstallment.add(interestPerInstallment);
		}
		this.principalPerInstallment.add(principleLastInstallment);
		this.interestPerInstallment.add(interestLastInstallment);
	}
	
	private BigDecimal getNumberOfInstallments(int numberOfInstallments) {
		return new BigDecimal(numberOfInstallments);
	}
	
	protected BigDecimal getTotalInterest(BigDecimal principle,
			BigDecimal duration, BigDecimal interestRate) {
		interestRate = interestRate.setScale(
				this.digitsAfterDecimalForInterest, this.initialRoundingMode);
		BigDecimal totalInterest;
		totalInterest = principle.multiply(duration).multiply(interestRate)
				.divide(new BigDecimal(100), this.digitsAfterDecimal,
						this.initialRoundingMode);
		totalInterest = totalInterest.setScale(this.digitsAfterDecimal,
				this.initialRoundingMode);
		return totalInterest;
	}
	
	protected BigDecimal getRepaymentPerInstallment(BigDecimal totalRepayment,
			BigDecimal numInstall) {
		BigDecimal repayment = totalRepayment.divide(numInstall,
				this.digitsAfterDecimal, this.initialRoundingMode);
		int scale = 0;
		MathContext mc = new MathContext(this.digitsAfterDecimal,
				this.initialRoundingMode);
		BigDecimal roundingMultiple = new BigDecimal(
				this.initialRoundOffMultiple, mc);
		repayment = (repayment.divide(roundingMultiple, scale,
				this.initialRoundingMode)).multiply(roundingMultiple);
		repayment = repayment.setScale(this.digitsAfterDecimal, this.initialRoundingMode);
		return repayment;
	}
	
	protected BigDecimal getInterestPerInstallment(BigDecimal totalInterest,
			BigDecimal numInstall) {
		BigDecimal interestPerInstallment = totalInterest.divide(numInstall,
				this.digitsAfterDecimal, this.initialRoundingMode);
		return interestPerInstallment;
	}
	
	protected BigDecimal getPrinciplePerInstallment(BigDecimal repaymentPerInstallment,
			BigDecimal interestPerInstallments, BigDecimal numInstall) {
		
		BigDecimal principlePerInstallment = repaymentPerInstallment.subtract(interestPerInstallments);
		return principlePerInstallment;
	}
	
	protected BigDecimal getPrincipleLastInstallment(BigDecimal principle,
			BigDecimal principlePerInstallment, BigDecimal numInstall) {
		
		BigDecimal principleLastInstallment = principle.subtract(
				principlePerInstallment.multiply(numInstall)).add(
				principlePerInstallment);
		principleLastInstallment = principleLastInstallment.setScale(
				this.digitsAfterDecimal, this.finalRoundingMode);
		return principleLastInstallment;
	}
	
	protected BigDecimal getInterestLastInstallment(BigDecimal totalInterest,
			BigDecimal interestPerInstallment, BigDecimal numInstall) {
		
		BigDecimal interestLastInstallment = totalInterest.subtract(
				interestPerInstallment.multiply(numInstall)).add(
				interestPerInstallment);
		
		interestLastInstallment = interestLastInstallment.setScale(this.digitsAfterDecimal, this.finalRoundingMode);
		return interestLastInstallment;
	}
}
