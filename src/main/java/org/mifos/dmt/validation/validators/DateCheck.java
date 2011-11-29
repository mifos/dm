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

public class DateCheck implements Validator {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DateCheck.class.getName());

	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	Map<Integer, String> stageFirstDBMap;
	ResultSet rs;
	boolean status;
	
	public DateCheck() {
		
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		rs = null;
		status = true;
	}
	
	@Override
	public boolean validate(Map<String, List<String>> map,int customerLevelId) throws DMTException {	
		try {
			
			// This check is to find out the incorrect creation dates at various entities levels

			// This check is to find out whether the creation date of loan account is not less than client's creation date 
			StringBuilder sbQuery1 = new StringBuilder(
				" select concat('The creation date for the migrated loan should be greater than or equal to the creation date of associated client. It cannot exist before its client :',"
						+ " customer.display_name) as Message_log " 
						+ " from customer "
						+ " inner join account on account.customer_id = customer.customer_id "
						+ " where customer_level_id=1 and account_type_id=1 and date(account.created_date) < date(customer.created_date) ");

			// This check is to find out that the disbursement date of loan should not less than it's creation date 
			StringBuilder sbQuery2 = new StringBuilder(								
				" select concat('A Loan cannot be disbursed before it is actually created. Date of disbursement should be greater than or equal to creation date : ',"
						+ " a.identifier) as Message_log " 
						+ " from loan_account la"
						+ " inner join account a on a.account_id = la.account_id "					
						+ " where date(a.created_date) > la.disbursement_date ");
			
			// This check is to find out that the customer creation and trained dates or client's date of birth are less than the date of migration..
			StringBuilder sbQuery3 = new StringBuilder(
			   " select concat('MFI Joining Date or trained date or date of birth of client entered in Excel should be less than current date. It fails for the following : ',"
					    + " customer.discriminator ,"
					    + " ' with name as ' , "
						+ " customer.display_name) as Message_log " 
						+ " from customer "						
						+ " where (customer.mfi_joining_date > curdate() or ifnull(customer.trained_date,curdate()) > curdate() or ifnull(customer.date_of_birth,curdate()) > curdate()) ");
			
			// This check is to find out that the loan creation and disbursement dates are less than the date of migration..
			
			StringBuilder sbQuery4 = new StringBuilder(
					   " select concat('Loan creation or disbursement date of the loan account cannot be a future date. It fails for the following account: ',"
								+ " account.identifier) as Message_log " 
								+ " from account "		
								+ "inner join loan_account on account.account_id=loan_account.account_id"
								+ " where (account.created_date > curdate() or loan_account.disbursement_date > curdate())");
			
			
			String[] queries = { sbQuery1.toString(), sbQuery2.toString(),
					sbQuery3.toString(), sbQuery4.toString()};

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
			logger.error("Exception while executing Validations on dates " + e.getMessage());
			throw new DMTException("Exception while executing Validations on dates" + e.getMessage());
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
