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

package org.mifos.dmt.business.Meetings.repayments;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

import org.mifos.dmt.business.Meetings.dao.FeesLookUp;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;

public class LoanRepayment {
		/* TODO
		 * Action Points
		 * Future support for periodic fees, taken into account
		 * 1. make loan_fee_schedule entries based on query currently used by ramya (ref mail)
		 * 2. calculate adjustments in the following order:
		 * 		get the fees of the installment, then the interest then the principal component
		 * 		in order to set the corresponding values and inset into the fees_schedule table
		 * 3. update the vlaues that needed to be entered to the loanDetailsForCustomer and return 
		 * 		the arrayList so that it can proceed with the flow of data.
		 */
	public FeesLookUp feesLookup;
	MigrationParams iparams;
	BigDecimal feesPaid;
	boolean isFeeAttached;
	public LoanRepayment(MigrationParams loanMigrationParams) {
		this.iparams = loanMigrationParams;
		feesLookup = new FeesLookUp(iparams.getAccount_id());
		isFeeAttached = isFeeAttached();
	}
	public ArrayList<HashMap<String, Object>> processRepayments(
			ArrayList<HashMap<String, Object>> loanDetailsForCustomer,
			MigrationParams inputParams) {
		
		BigDecimal amountPaid = inputParams.getAmountPaid();
		
		BigDecimal feesAmount = BigDecimal.ZERO;
		feesPaid = BigDecimal.ZERO;
		if (isFeeAttached) {
			feesAmount = getFeesAmount();
			if(amountPaid.compareTo(feesAmount) >=0){
				amountPaid = amountPaid.subtract(feesAmount);
				feesPaid = feesAmount;
			} else {
				feesPaid = amountPaid;
				if (amountPaid.compareTo(BigDecimal.ONE) >=0) {
				}
				return loanDetailsForCustomer;
			}
		}
		return calculateAndInsertRepayments(loanDetailsForCustomer, amountPaid);

	}

	private boolean isFeeAttached() {
		return feesLookup.isLoanFeeAttached();
	}

	private ArrayList<HashMap<String, Object>> calculateAndInsertRepayments(
			ArrayList<HashMap<String, Object>> loanDetailsForCustomer,
			BigDecimal amountPaid) {
		for(int i=0; i<loanDetailsForCustomer.size(); i++) {
			if(amountPaid.compareTo(BigDecimal.ZERO)<=0) {
				break;
			}
			BigDecimal repaymentPerInstallment =  ((BigDecimal) loanDetailsForCustomer.get(i).get("principal"))
			.add((BigDecimal) loanDetailsForCustomer.get(i).get("interest"));
			if(amountPaid.compareTo(repaymentPerInstallment)>=0) {
				loanDetailsForCustomer.get(i).put("paymentDate", loanDetailsForCustomer.get(i).get("actionDate"));
				loanDetailsForCustomer.get(i).put("paymentStatus", 1);
				loanDetailsForCustomer.get(i).put("principalPaid", loanDetailsForCustomer.get(i).get("principal"));
				loanDetailsForCustomer.get(i).put("interestPaid", loanDetailsForCustomer.get(i).get("interest"));
				amountPaid = amountPaid.subtract(repaymentPerInstallment);
			} else if(amountPaid.compareTo(BigDecimal.ZERO)>=0){
				if(amountPaid.compareTo((BigDecimal) loanDetailsForCustomer.get(i).get("interest"))<0) {
					loanDetailsForCustomer.get(i).put("paymentDate", loanDetailsForCustomer.get(i).get("actionDate"));
					loanDetailsForCustomer.get(i).put("interestPaid", amountPaid);
					amountPaid = BigDecimal.ZERO;
				} else {
					loanDetailsForCustomer.get(i).put("paymentDate", loanDetailsForCustomer.get(i).get("actionDate"));
					loanDetailsForCustomer.get(i).put("interestPaid", loanDetailsForCustomer.get(i).get("interest"));
					amountPaid = amountPaid.subtract((BigDecimal) loanDetailsForCustomer.get(i).get("interest"));
					loanDetailsForCustomer.get(i).put("principalPaid", amountPaid);
					amountPaid = BigDecimal.ZERO;
				}
			}
		}
		return loanDetailsForCustomer;
	}

	private BigDecimal getFeesAmount() {
		return feesLookup.getLoanFeeAmount();
	}
	
	public BigDecimal getFeesPaid() {
		return feesPaid;
	}
	public Boolean getIsFeeAttached() {
		return isFeeAttached;
	}
}
