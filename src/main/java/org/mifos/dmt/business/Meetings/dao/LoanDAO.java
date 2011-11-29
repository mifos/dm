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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import org.joda.time.DateTime;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.configuration.DMTAccountingProperties;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;

public class LoanDAO {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(LoanDAO.class.getName());
	private Connection con;
	private PreparedStatement pstmt;
	
	private final String CREATE_LOAN_SCHEDULE = "INSERT INTO loan_schedule (ACCOUNT_ID, CUSTOMER_ID, CURRENCY_ID, ACTION_DATE, PRINCIPAL, PRINCIPAL_CURRENCY_ID, INTEREST, INTEREST_CURRENCY_ID, PENALTY, PENALTY_CURRENCY_ID, MISC_FEES, MISC_FEES_CURRENCY_ID, MISC_FEES_PAID, MISC_FEES_PAID_CURRENCY_ID,  MISC_PENALTY, MISC_PENALTY_CURRENCY_ID, MISC_PENALTY_PAID, MISC_PENALTY_PAID_CURRENCY_ID, PRINCIPAL_PAID, PRINCIPAL_PAID_CURRENCY_ID, INTEREST_PAID,  INTEREST_PAID_CURRENCY_ID, PENALTY_PAID, PENALTY_PAID_CURRENCY_ID, PAYMENT_STATUS, INSTALLMENT_ID, PAYMENT_DATE, PARENT_FLAG, VERSION_NO ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private final String FETCH_ALL_LOAN_PARAMS = "select acc.account_id, c.created_date, c.customer_id, rd.recurrence_id, rd.recur_after, rod.days, rod.rank_of_days, rod.day_number, la.loan_amount, la.loan_balance, la.interest_type_id, la.interest_rate, la.disbursement_date, la.no_of_installments, la.amount_paid from loan_account as la inner join recurrence_detail as rd on la.meeting_id = rd.meeting_id inner join recur_on_day as rod on rd.details_id=rod.details_id inner join account as acc on la.account_id = acc.account_id inner join customer as c on acc.customer_id = c.customer_id";
	public LoanDAO() {
		this.con = null;
		try {
			con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
			pstmt = con.prepareStatement(this.CREATE_LOAN_SCHEDULE);
		} catch (Exception e){
			logger.error("Error inserting the loan schedule :" + e.getMessage());
		}
	}
	
	public void insertIntoDb(ArrayList<HashMap<String, Object>> loanDetailsForCustomer) throws DMTException {
		try {
			pstmt.setInt(1, (Integer) loanDetailsForCustomer.get(0).get("accountId"));
			pstmt.setInt(2, (Integer) loanDetailsForCustomer.get(0).get("customerId"));
			pstmt.setInt(3, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(6, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(8, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(10, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(12, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(14, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(16, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(18, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(20, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(22, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(24, (Integer) loanDetailsForCustomer.get(0).get("currencyId"));
			pstmt.setInt(28, (Integer) loanDetailsForCustomer.get(0).get("parentFlag"));
			pstmt.setInt(29, (Integer) loanDetailsForCustomer.get(0).get("versionNumber"));
			for (int i=0; i<loanDetailsForCustomer.size(); i++) {
				pstmt.setString(4, (String) loanDetailsForCustomer.get(i).get("actionDate"));
				pstmt.setBigDecimal(5, (BigDecimal) loanDetailsForCustomer.get(i).get("principal"));
				pstmt.setBigDecimal(7, (BigDecimal) loanDetailsForCustomer.get(i).get("interest"));
				pstmt.setBigDecimal(9, (BigDecimal) loanDetailsForCustomer.get(i).get("penalty"));
				pstmt.setBigDecimal(11, (BigDecimal) loanDetailsForCustomer.get(i).get("miscFees"));
				pstmt.setBigDecimal(13, (BigDecimal) loanDetailsForCustomer.get(i).get("miscFeesPaid"));
				pstmt.setBigDecimal(15, (BigDecimal) loanDetailsForCustomer.get(i).get("miscPenalty"));
				pstmt.setBigDecimal(17, (BigDecimal) loanDetailsForCustomer.get(i).get("miscPenaltyPaid"));
				pstmt.setBigDecimal(19, (BigDecimal) loanDetailsForCustomer.get(i).get("principalPaid"));
				pstmt.setBigDecimal(21, (BigDecimal) loanDetailsForCustomer.get(i).get("interestPaid"));
				pstmt.setBigDecimal(23, (BigDecimal) loanDetailsForCustomer.get(i).get("penaltyPaid"));
				pstmt.setInt(25, (Integer) loanDetailsForCustomer.get(i).get("paymentStatus"));
				pstmt.setInt(26, (Integer) loanDetailsForCustomer.get(i).get("installmentId"));
				pstmt.setString(27, (String) loanDetailsForCustomer.get(i).get("paymentDate"));
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			logger.error("SQL Exception while trying to insert into customer schedule :"+ e.getMessage());
			throw new DMTException("SQL Exception while trying to insert into customer schedule ");
		}
	}
	
	public ArrayList<MigrationParams> fetchAllLoanParamsForMigration() throws SQLException, ParseException {
		Statement stmt = con.createStatement();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<MigrationParams> loanValues = new ArrayList<MigrationParams>();
		ResultSet rs;
		rs = stmt.executeQuery(this.FETCH_ALL_LOAN_PARAMS);
		while (rs.next()) {
			Integer accountId = rs.getInt("account_id");
			DateTime createdDate = new DateTime(dateFormat.parse(rs.getString("created_date")));
			Integer custId = rs.getInt("customer_id");
			Integer recId = rs.getInt("recurrence_id");
			Integer recAfter = rs.getInt("recur_after");
			Integer days = rs.getInt("days");
			Integer rankOfDay = rs.getInt("rank_of_days");
			Integer dayNumber = rs.getInt("day_number");
			BigDecimal loanAmount = rs.getBigDecimal("loan_amount");
			BigDecimal amountPaid = rs.getBigDecimal("amount_paid");
			Integer interestTypeId = rs.getInt("interest_type_id");
			BigDecimal interestRate = rs.getBigDecimal("interest_rate");
			DateTime disbursementDate = new DateTime(dateFormat.parse(rs.getString("disbursement_date")));
			Integer numberOfInstallments = rs.getInt("no_of_installments");
			Integer currencyId = DMTAccountingProperties.CURRENCY_ID;
			MigrationParams custParams = new MigrationParams(accountId, custId, currencyId, createdDate, disbursementDate, recId, interestTypeId, recAfter, days, rankOfDay, dayNumber, loanAmount, amountPaid, interestRate, numberOfInstallments);
			loanValues.add(custParams);
		}
		return loanValues;
		
	}

}
