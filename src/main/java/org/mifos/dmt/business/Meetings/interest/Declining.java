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
import java.util.Iterator;

import org.mifos.dmt.business.Meetings.entity.MigrationParams;

public class Declining extends Interest {
	
	//private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Declining.class.getName());
	
	BigDecimal EMI;
	BigDecimal rawEMI;
	
	public Declining(MigrationParams inputParams) {
		super(inputParams);
	}

	@Override
	public void calculateLoanPayments() {
		/*
		 * Declining balance calculations:
		 * 
		 * 1. calculate the EMI as follows: EMI = i*P / [1- (1+i)^-n]
		 * 		apply the finalcial currency rules on this amount (digits after decimal and
		 * 			initial round off multiple)
		 * 2. for a given period interest = P * (r/n) where P == remaining principle
		 * 		apply the financial rules on the interest.
		 * 3. calculate the principle for the given EMI and populate the repayment charts
		 * 4.a. Find total interest and apply all financial rules (Initian round mode and num digits after decimal)
		 * 4.b Find summation of the principle of the various installments.
		 * <h2>Summary of rounding and adjustment logic</h2>
		 *
		 * Assume we've calculated exact values for each installment's principal, interest, and fees payment, and
		 * installment's total payment (their sum).
		 * <p/>
		 * The concept here is that exact values will be rounded and the amounts that the customer actually pays will drift
		 * away from what's actually due, resulting in the components of each installment not exactly adding up to the total
		 * payment.
		 * <p/>
		 * Generally, within each installment but the last, the principal payment is the "fall guy", making up for any
		 * difference. For the last installment, the interest payment is the fall guy.
		 * <p/>
		 * Differences in total paid across all installments are made up in the last installment.
		 * <p/>
		 * <h4>Rounding and adjusting total payments</h4>
		 * First compute the rounded and adjusted totals for the loan. These are used to adjust the final installment's
		 * payments.
		 * <ul>
		 * <li>Round the loan's exact total payments (sum of exact principal, exact interest, exact fees) using final
		 * rounding.
		 * <li>No need to round the principal, since it is entered using precision of the prevailing currency.
		 * <li>Round total fees using currency rounding
		 * <li>Adjust the total interest so that rounded fees, principal, and adjusted interest sum to the rounded total
		 * payments.
		 * </ul>
		 * </ul>
		 * <h4>Non-grace-period installments except the last:</h4>
		 * <ul>
		 * <li>Round the installment's exact total payment using initial rounding.
		 * <li>Round the installment's exact interest and fee payments using currency rounding.
		 * <li>Round each of the installment's account fees using currency rounding.
		 * <li>Adjust the installment's principal to make up the difference between the installment's rounded total payment
		 * and its rounded interest and fee payments.
		 * <li>After rounding and adjusting, the installment's (rounded) total payment is exactly the sum of (rounded)
		 * principal, interest and fees.
		 * </ul>
		 */
		this.interestRate = this.interestRate.divide(new BigDecimal(100.0));

		BigDecimal standingPrinciple = this.loanAmount;

		BigDecimal interesstPerYear = this.interestRate;
		BigDecimal lengthOfPeriod = this.lengthOfPeriod;

		int termOfLoan = 1;
		BigDecimal interestRatePerPeriod = getInterestPerPeriod(interesstPerYear, lengthOfPeriod);
		EMI = calculateEMI(interestRatePerPeriod, standingPrinciple, this.numberOfInstallments);

		BigDecimal adjustedEMI = applyInitialFinancialRules(EMI);

		boolean finalInstallmentFlag = false;
		BigDecimal interest;
		BigDecimal principal;
		for(termOfLoan =1; termOfLoan <= this.numberOfInstallments; termOfLoan++) {
			interest = getInterestForPeriod(standingPrinciple, interestRatePerPeriod, finalInstallmentFlag);
			principal = getPrincipalForPeriod(interest, adjustedEMI);
			insertInterestAndPrinciple(interest, principal);
			standingPrinciple = updateStandingPrinciple();
		}
		fixFinalInstallment();
		
	}
	
	private void fixFinalInstallment() {
		Iterator<BigDecimal> itr = this.principalPerInstallment.iterator();
	    BigDecimal calculatedPrinciple = BigDecimal.ZERO;
		while (itr.hasNext()) {
			calculatedPrinciple = calculatedPrinciple.add(itr.next());
	    }
		
		BigDecimal difference = this.loanAmount.subtract(calculatedPrinciple);

		
		BigDecimal lastPrinciple = this.principalPerInstallment.get(this.numberOfInstallments-1);
		lastPrinciple = lastPrinciple.add(difference);
		
		BigDecimal totalRawEmi = this.rawEMI;
		BigDecimal totalRawRepayment = totalRawEmi.multiply(new BigDecimal(this.numberOfInstallments));
		totalRawRepayment = applyFinalFinancialRulesToEMI(totalRawRepayment);
		BigDecimal totalRepayment = EMI.multiply(new BigDecimal(this.numberOfInstallments));
		difference = totalRawRepayment.subtract(totalRepayment);
		
		BigDecimal lastInterest = this.interestPerInstallment.get(this.numberOfInstallments-1);
		BigDecimal lastEMI = EMI;
		lastEMI = lastEMI.add(difference);
		lastEMI = this.applyFinalFinancialRulesToEMI(lastEMI);
//TODO verify UI
		if(!((lastEMI.subtract(lastPrinciple).compareTo(BigDecimal.ZERO)) >= 0))
		{
		lastInterest = BigDecimal.ZERO.setScale(digitsAfterDecimal);
		lastPrinciple=lastPrinciple.add(lastEMI.subtract(lastPrinciple));
		}
		else
		{
			lastInterest= lastEMI.subtract(lastPrinciple).setScale(digitsAfterDecimal);
		}
		/*BigDecimal old = */this.interestPerInstallment.remove(this.numberOfInstallments-1);
		
		this.interestPerInstallment.add(lastInterest);
		this.principalPerInstallment.remove(this.numberOfInstallments-1);
		this.principalPerInstallment.add(lastPrinciple);

	}

	

	private BigDecimal updateStandingPrinciple() {
		BigDecimal principalPaid = BigDecimal.ZERO;
		Iterator<BigDecimal> itr = this.principalPerInstallment.iterator();
		while (itr.hasNext()) {
			principalPaid = principalPaid.add(itr.next());
		}

		BigDecimal standingPrinciple = this.loanAmount.subtract(principalPaid);
		return standingPrinciple;
	}

	private void insertInterestAndPrinciple(BigDecimal interest,
			BigDecimal principal) {
		this.principalPerInstallment.add(principal);
		this.interestPerInstallment.add(interest);
		
	}

	private BigDecimal getPrincipalForPeriod(BigDecimal interest,
			BigDecimal adjustedEMI) {
		return adjustedEMI.subtract(interest);
	}

	private BigDecimal getInterestForPeriod(BigDecimal principle, BigDecimal rate, boolean finalFlag) {
		BigDecimal interest = principle.multiply(rate);
		if(!finalFlag) {
			return applyInitialFinancialRules(interest);
		} else {
			return applyFinalFinancialRules(interest);
		}
	}

	private BigDecimal calculateEMI(BigDecimal interestPerPeriod,
			BigDecimal standingPrinciple, int numberOfInstallments) {
		
		BigDecimal numerator = interestPerPeriod.multiply(standingPrinciple);
		MathContext mc = new MathContext(10 , this.initialRoundingMode);
		BigDecimal divisor = BigDecimal.ONE.subtract((BigDecimal.ONE.add(interestPerPeriod)).pow(-numberOfInstallments, mc));
		BigDecimal EMI = numerator.divide(divisor, 5, this.initialRoundingMode);
		this.rawEMI = EMI;
		return applyFinancialRulesToEMI(EMI);
	}
	
	private BigDecimal applyFinancialRulesToEMI(BigDecimal currency) {
		currency = currency.setScale(this.digitsAfterDecimal,
				this.finalRoundingMode);
		int scale = 0;
		MathContext mc = new MathContext(this.digitsAfterDecimal,
				this.initialRoundingMode);
		BigDecimal roundingMultiple = new BigDecimal(
				this.initialRoundOffMultiple, mc);
		currency = (currency.divide(roundingMultiple, scale,
				this.initialRoundingMode)).multiply(roundingMultiple);
		return currency;
	}
	
	private BigDecimal applyFinalFinancialRulesToEMI(BigDecimal currency) {
		currency = currency.setScale(this.digitsAfterDecimal,
				this.finalRoundingMode);
		int scale = 0;
		MathContext mc = new MathContext(this.digitsAfterDecimal,
				this.initialRoundingMode);
		BigDecimal roundingMultiple = new BigDecimal(
				this.finalRoundOffMultiple, mc);
		currency = (currency.divide(roundingMultiple, scale,
				this.initialRoundingMode)).multiply(roundingMultiple);
		return currency;
	}
	
	private BigDecimal applyFinalFinancialRules(BigDecimal currency) {
		currency = currency.setScale(this.digitsAfterDecimal,
				this.finalRoundingMode);
		return currency;
	}
	
	private BigDecimal applyInitialFinancialRules(BigDecimal currency) {
		currency = currency.setScale(this.digitsAfterDecimal,
				this.initialRoundingMode);
		return currency;
	}

	private BigDecimal getInterestPerPeriod(BigDecimal interestPerYear,
			BigDecimal lengthOfPeriod) {
		return interestPerYear.multiply(lengthOfPeriod);
	}
}
