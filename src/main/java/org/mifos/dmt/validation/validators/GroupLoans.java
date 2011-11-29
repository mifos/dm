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

public class GroupLoans implements Validator {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(GroupLoans.class.getName());

	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	ResultSet rs;
	boolean status;
	
	public GroupLoans() {
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		rs = null;
		status = true;
		psmt=null;
	}
	
	@Override
	public boolean validate(Map<String, List<String>> map,int customerLevelId) throws DMTException {	
		try {
			
			// This check is to find out the incorrect creation dates at various entities levels

			// This check is to find out whether the individual loan is not associated with a product applicable for groups
			StringBuilder sbQuery1 = new StringBuilder(
				" select concat('The product associated with the loan account is applicable only for group loans. Please choose right product for the following customers loan : ',"
						+ " account.identifier) as Message_log " 
						+ " from account "
						+ " inner join loan_account on loan_account.account_id=account.account_id"
						+ " inner join customer on customer.customer_id=account.customer_id"
						+ " inner join prd_offering on prd_offering.prd_offering_id=loan_account.prd_offering_id"
						+ " where customer.customer_level_id=1 and prd_offering.prd_applicable_master_id<>1 ");

			// This check is to find out that the disbursement date of loan should not less than it's creation date 
			StringBuilder sbQuery2 = new StringBuilder(								
					" select concat('The product associated with the loan account is not applicable for group loans. Please choose right product for the following customers loan : ',"
					+ " account.identifier) as Message_log " 
					+ " from account "
					+ " inner join loan_account on loan_account.account_id=account.account_id"
					+ " inner join customer on customer.customer_id=account.customer_id"
					+ " inner join prd_offering on prd_offering.prd_offering_id=loan_account.prd_offering_id"
					+ " where customer.customer_level_id=2 and prd_offering.prd_applicable_master_id<>2 ");

			
			
			String[] queries = { sbQuery1.toString(), sbQuery2.toString()};

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
			logger.error("Exception while executing Validations on the loan product of group loans " + e.getMessage());
			throw new DMTException("Exception while executing Validations on the loan product of group loans " + e.getMessage());
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
