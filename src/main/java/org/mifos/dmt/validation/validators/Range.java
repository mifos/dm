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
 
public class Range implements Validator {
  
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Range.class.getName());

	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	ResultSet rs;
	boolean status;
	
	public Range() {
	
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
				" select concat('The grace period does not match with the assigned product for loan associated with customer : ',"
						+ " cust.display_name) as Message_log " 
						+ " from loan_account la "
						+ " inner join account a on a.account_id = la.account_id "
						+ " inner join customer as cust on cust.customer_id = a.customer_id "
						+ " inner join loan_offering lo on lo.prd_offering_id = la.prd_offering_id "
						+ " where la.grace_period_duration > lo.grace_period_duration ");

			// This check is to find out that the given interest rate is in the actual range 
			StringBuilder sbQuery2 = new StringBuilder(								
				" select concat('The interest rate does not match with the assigned product for loan associated with customer: ',"
						+ " cust.display_name) as Message_log " 
						+ " from loan_account la "
						+ " inner join account a on a.account_id = la.account_id "
						+ " inner join customer as cust on cust.customer_id = a.customer_id "
						+ " inner join loan_offering lo on lo.prd_offering_id = la.prd_offering_id "						
						+ " where la.interest_rate  not between lo.min_interest_rate and lo.max_interest_rate ");
			
			// This check is to find out that the given loan amount is in the actual range 
			StringBuilder sbQuery3 = new StringBuilder(
			   " select concat('The amount does not match with the assigned product for loan associated with customer: ',"
						+ " cust.display_name) as Message_log " 
						+ " from loan_account la "						
						+ " inner join account a on a.account_id = la.account_id "
						+ " inner join customer as cust on cust.customer_id = a.customer_id "
						+ " inner join loan_amount_same_for_all_loan lamount on lamount.prd_offering_id = la.prd_offering_id "						
						+ " where  la.loan_amount  not between lamount.min_loan_amount and lamount.max_loan_amnt ");
			
			// This check is to find out that the given installments are in the actual range 
			StringBuilder sbQuery4 = new StringBuilder(
			   " select concat('The installments does not match with the assigned product for loan associated with customer: ',"
						+ " cust.display_name) as Message_log " 
						+ " from loan_account la "						
						+ " inner join account a on a.account_id = la.account_id "
						+ " inner join customer as cust on cust.customer_id = a.customer_id "
						+ " inner join no_of_install_same_for_all_loan linstl on linstl.prd_offering_id = la.prd_offering_id "	
						+ " where la.no_of_installments not between linstl.min_no_install  and linstl.max_no_install ");
			
			String[] queries = { sbQuery1.toString(), sbQuery2.toString(),
					sbQuery3.toString(), sbQuery4.toString() };

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
			logger.error("Exception while executing Validations on the interest/installmentno/loan amount ranges of loan product " + e.getMessage());
			throw new DMTException("Exception while executing Validations on the interest/installmentno/loan amount ranges of loan product " + e.getMessage());
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
