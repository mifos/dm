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
import java.util.ArrayList;
import java.util.HashMap;

import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;


public class LoanFeesDAO {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(LoanFeesDAO.class.getName());
	private Connection con;
	private PreparedStatement pstmt;
	
	MigrationParams iparams;
	int id;
	private ArrayList<HashMap<String, Object>> loanFeeParams;
	private HashMap<String , Object> loanFeeParam;
	private BigDecimal feesPaid;
	
	private final String INSERT_LOAN_FEE_SCHEDULE = "INSERT INTO loan_fee_schedule (id, installment_id, fee_id, account_fee_id, amount, amount_currency_id, amount_paid, amount_paid_currency_id, version_no) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private final String GET_ID = "select id from loan_schedule where installment_id =1 and account_id =";
	public LoanFeesDAO(MigrationParams loanMigrationParams, ArrayList<HashMap<String, Object>> loanFeeDetails, BigDecimal feesPaid) {
		this.feesPaid = feesPaid;
		loanFeeParam = new HashMap<String, Object>();
		iparams = loanMigrationParams;
		loanFeeParams = loanFeeDetails;
		this.con = null;
		try {
			
			con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
			pstmt = con.prepareStatement(this.INSERT_LOAN_FEE_SCHEDULE);
		} catch (Exception e){
			logger.error("Error inserting the fee schedule :" + e);
		}
	}
	
	public void insertIntoDb() throws DMTException {
		id = getID();
		try {
			for(int i=0; i<loanFeeParams.size(); i++) {
				loanFeeParam = loanFeeParams.get(i);
				pstmt.setInt(1, id);
				pstmt.setInt(2, 1);
				pstmt.setInt(3, (Integer) loanFeeParam.get("feeId"));
				pstmt.setInt(4, (Integer) loanFeeParam.get("accountFeeId"));
				pstmt.setBigDecimal(5, (BigDecimal) loanFeeParam.get("feeAmount"));
				pstmt.setInt(6, iparams.getCurrency_id());
				pstmt.setBigDecimal(7, feesPaid);
				pstmt.setInt(8, iparams.getCurrency_id());
				pstmt.setInt(9, 0);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			logger.error("Error inserting the fee schedule :" + e);
			throw new DMTException("Error inserting the fee schedule");
		}
	}

	private int getID() {
		int scheduleid=-1;
		try {
			
			java.sql.Statement stmt = con.createStatement();
			String query = this.GET_ID+this.iparams.getAccount_id();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				scheduleid = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return scheduleid;
	}
}
