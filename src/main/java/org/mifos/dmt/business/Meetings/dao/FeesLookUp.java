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

package org.mifos.dmt.business.Meetings.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.util.DBConnection;

public class FeesLookUp {

	private Connection con;
	private ResultSet rs;
	private java.sql.Statement stmt;
	int accountid;
	HashMap<String, Object> loanFeeDetail;
	ArrayList<HashMap<String, Object>> loanFeeDetails;
	HashMap<String, Object> customerFeeDetail;
	ArrayList<HashMap<String, Object>> customerFeeDetails;
	
	//private final String IS_LOAN_FEE_ATTACHED = "SELECT * from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=1 and account.account_id =";
	private final String GET_LOAN_FEE_DETAILS = "SELECT * from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=1 and account.account_id =";
	private final String GET_LOAN_FEE_AMOUNT = "SELECT sum(account_fees.account_fee_amnt) as fee from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=1 and account.account_id =";
	//private final String IS_CUSTOMER_FEE_ATTACHED = "SELECT * from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=3 and account.account_id =";
	private final String GET_CUSTOMER_FEE_DETAILS = "SELECT * from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=3 and account.account_id =";
	private final String IS_CUSTOMER_FEE_PAID = "SELECT sum(account_fees.account_fee_amnt) as fee, sum(account_fees.amount_paid) as feepaid from account_fees inner join account on account.account_id=account_fees.account_id inner join fee_frequency on fee_frequency.fee_id=account_fees.fee_id where  fee_frequency.FREQUENCY_PAYMENT_ID<>2 and account.account_type_id=3 and account.account_id =";
	
	
	public FeesLookUp(int accountId) {
		this.loanFeeDetail = new HashMap<String, Object>();
		this.loanFeeDetails = new ArrayList<HashMap<String,Object>>();
		this.customerFeeDetail = new HashMap<String, Object>();
		this.customerFeeDetails = new ArrayList<HashMap<String,Object>>();
		this.accountid = accountId;
		try {
			
			con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
			stmt = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean isLoanFeeAttached() {
		String query = this.GET_LOAN_FEE_DETAILS + accountid;
		boolean isLoanAttached = false;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				isLoanAttached = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isLoanAttached;
	}

	public BigDecimal getLoanFeeAmount() {
		String query = this.GET_LOAN_FEE_AMOUNT + accountid;
		BigDecimal fee = BigDecimal.ZERO;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				fee = rs.getBigDecimal("fee");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return fee;
		
	}
	
	@SuppressWarnings("unchecked")
	public ArrayList<HashMap<String, Object>> getLoanFeeDetails() {
		String query = this.GET_LOAN_FEE_DETAILS + accountid;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				loanFeeDetail.put("accountFeeId", rs.getInt("account_fees.account_fee_id"));
				loanFeeDetail.put("feeId", rs.getInt("account_fees.fee_id"));
				loanFeeDetail.put("feeAmount", rs.getBigDecimal("account_fees.account_fee_amnt"));
				loanFeeDetails.add((HashMap<String, Object>) loanFeeDetail.clone());
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return loanFeeDetails;
	}
	
	public boolean isCustomerFeeAttached() {
		String query = this.GET_CUSTOMER_FEE_DETAILS + accountid;
		boolean isLoanAttached = false;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				isLoanAttached = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isLoanAttached;
	}

	@SuppressWarnings("unchecked")
	public ArrayList<HashMap<String, Object>> getCustomerFeeDetails() {
		String query = this.GET_CUSTOMER_FEE_DETAILS + accountid;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				customerFeeDetail.put("accountFeeId", rs.getInt("account_fees.account_fee_id"));
				customerFeeDetail.put("feeId", rs.getInt("account_fees.fee_id"));
				customerFeeDetail.put("feeAmount", rs.getBigDecimal("account_fees.account_fee_amnt"));
				customerFeeDetail.put("amountPaid", rs.getBigDecimal("account_fees.amount_paid"));
				customerFeeDetails.add((HashMap<String, Object>) customerFeeDetail.clone());
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return customerFeeDetails;
	}

	public int isCustomerFeesPaid() {
		int retVal =0;
		BigDecimal fee = BigDecimal.ONE;
		BigDecimal feePaid = BigDecimal.ZERO;
		String query = this.IS_CUSTOMER_FEE_PAID + accountid;
		try {
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				fee = rs.getBigDecimal("fee");
				feePaid = rs.getBigDecimal("feepaid");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(feePaid.compareTo(fee)>=0)
			retVal=1;
		return retVal;
	}
}
