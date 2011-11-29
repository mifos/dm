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

package org.mifos.dmt.validation.validators;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.validation.Validator;

public class ClientLoanAccountRecurrence implements Validator {
  
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(ClientLoanAccountRecurrence.class.getName());

	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	Map<Integer, String> stageFirstDBMap;
	ResultSet rs;
	boolean status;
	
	public ClientLoanAccountRecurrence() {
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		rs = null;
		status = true;
		psmt=null;
	}
	 
	@Override
	public boolean validate(Map<String, List<String>> map,int customerLevelId) throws DMTException {
		
		try {
			
			// This check is to find out that the given loan amount,interest rate, installments are in the actual range 

			// This check is to find out that the given grace period is in the actual range 
			StringBuilder sbQuery1 = new StringBuilder(
				" select concat('The meeting recurrence for the loan account is not matching with the associated client/group. One is weekly and other is monthly. It fails for the following loan account : ',"
						+ " loan_account_freq_type.identifier) as Message_log " 
						+ " from "
						+ " (select recurrence_id,loan_account.account_id,account.customer_id,account.identifier from loan_account"
						+ " inner join account on account.account_id=loan_account.account_id "
						+ " inner join recurrence_detail on loan_account.meeting_id=recurrence_detail.meeting_id "
						+ " inner join recur_on_day on recurrence_detail.details_id=recur_on_day.details_id) loan_account_freq_type "
						+ " inner join (select recurrence_id,customer.customer_id "
						+ " from customer "
						+ " inner join customer_meeting on customer_meeting.customer_id=customer.customer_id "
						+ " inner join recurrence_detail on customer_meeting.meeting_id=recurrence_detail.meeting_id "
						+ " inner join recur_on_day on recurrence_detail.details_id=recur_on_day.details_id "
						+ " where customer.customer_level_id in (1,2)) prd_freq_type "
						+ " on prd_freq_type.customer_id=loan_account_freq_type.customer_id "
						+ " where prd_freq_type.recurrence_id<>loan_account_freq_type.recurrence_id ");

			// This check is to find out that the given interest rate is in the actual range 
			StringBuilder sbQuery2 = new StringBuilder(								
				" select concat('The meeting recurrence for the loan account is not matching with associated client/group. They are not in the multiples. It fails for the following loan account : ',"
						+ " loan_account_freq_type.identifier) as Message_log " 
						+ " from "
						+ " (select recurrence_id,loan_account.account_id,account.customer_id,account.identifier,recurrence_detail.recur_after from loan_account"
						+ " inner join account on account.account_id=loan_account.account_id "
						+ " inner join recurrence_detail on loan_account.meeting_id=recurrence_detail.meeting_id "
						+ " inner join recur_on_day on recurrence_detail.details_id=recur_on_day.details_id) loan_account_freq_type "
						+ " inner join (select recurrence_id,customer.customer_id,recurrence_detail.recur_after "
						+ " from customer "
						+ " inner join customer_meeting on customer.customer_id=customer_meeting.customer_id "
						+ " inner join recurrence_detail on customer_meeting.meeting_id=recurrence_detail.meeting_id "
						+ " inner join recur_on_day on recurrence_detail.details_id=recur_on_day.details_id "
						+ " where customer.customer_level_id in (1,2)) prd_freq_type "
						+ " on prd_freq_type.customer_id=loan_account_freq_type.customer_id "
						+ " where prd_freq_type.recurrence_id=loan_account_freq_type.recurrence_id "
						+ " and (prd_freq_type.recur_after<loan_account_freq_type.recur_after "
						+ " or mod(prd_freq_type.recur_after,loan_account_freq_type.recur_after)<>0) ");
			
			
			
			String[] queries = { sbQuery1.toString(), sbQuery2.toString(),
				};

			int i = 0;
			for (String query : queries) {
				
				psmt = con.prepareStatement(query);
				rs = psmt.executeQuery();

				if (rs.next()) {
					rs.beforeFirst();

					while (rs.next()) {

						logger.error(rs.getString("Message_log"));
					}
					i=1;
				}
			}

			if (i != 0)
				status = false;
			 
		} catch (Exception e) {
			status = false;
			logger.error("Exception while executing Validations on matching meeting recurrences of a client with its loan account " + e.getMessage());
			throw new DMTException("Exception while executing Validations on matching meeting recurrences of a client with its loan account " + e.getMessage());
		} 
		finally {
			try {
				if(rs != null)
					rs.close();
				if(psmt != null)
					psmt.close();	
			} catch (SQLException se) {
				logger.error("SQLException in finally block "+se);
			}
		}		
		return status;
	}// end of validate()...

}
