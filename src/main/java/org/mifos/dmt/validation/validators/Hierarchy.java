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

public class Hierarchy implements Validator {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Hierarchy.class.getName());
	
	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	ResultSet rs;
	boolean status;
	
	public Hierarchy() {
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		rs = null;
		status = true;
		psmt=null;
	}
		 
	    @Override
		public boolean validate(Map<String,List<String>> map,int customerLevelId) throws DMTException {
			
			try {
				
				 // This check is to find out that the given group is associated with correct loan officer 
					StringBuilder sbQuery1 = new StringBuilder(
						" select concat('Loan officer attached with Group: ',grp.display_name ," 
								+ " ' does not match with Center: ',center.display_name )  as Message_log "
								+ " from customer center inner join customer grp on center.customer_id=grp.parent_customer_id "
								+ " where grp.customer_level_id=2 and center.loan_officer_id<>grp.loan_officer_id");
				
				// This check is to find out that the given group is associated with correct branch  		
				 StringBuilder sbQuery2 = new StringBuilder(
						" select concat('Office attached with Group: ',grp.display_name ," 
						 +" ' does not match with Center: ',center.display_name )  as Message_log " 
								+ " from customer center "
								+ " inner join customer grp on center.customer_id=grp.parent_customer_id "
								+ " where grp.customer_level_id=2 and center.branch_id<>grp.branch_id ");
				 
				//This check is to find out that the given client is associated with correct loan officer 
				StringBuilder sbQuery3 = new StringBuilder(
						" select concat('Loan officer attached with Client: ',client1.display_name," +
						" ' does not match with Group: ',grp.display_name ) as Message_log " 
								+ " from customer grp "
								+ " inner join customer client1 on grp.customer_id=client1.parent_customer_id "
								+ " where client1.customer_level_id=1 and grp.loan_officer_id<>client1.loan_officer_id ");
			
				// This check is to find out that the given group is associated with correct branch 
				StringBuilder sbQuery4 = new StringBuilder(
						" select concat('Office attached with Client: ',client1.display_name," +
						" ' does not match with Group: ',grp.display_name) as Message_log " 
								+ " from customer grp "
								+ " inner join customer client1 on grp.customer_id=client1.parent_customer_id "
								+ " where client1.customer_level_id=1 and grp.branch_id<>client1.branch_id ");
				
				 //This check will find whether the independent clients are not associated with any wrong center or group
				StringBuilder sbQuery5 = new StringBuilder(
						" select concat('Customer ',client1.display_name,' with customerId: ',client1.customer_id ,"
								+ " ' is independent, should not be associated with group/center') as Message_log " 
								+ " from customer client1 "
								+ " where group_flag=0 and parent_customer_id is not null "); 
														 
				StringBuilder sbQuery6 = new StringBuilder(
						" select concat('Center: ',display_name, "
						+" 'should have loan officer assigned and should not have parent customer') as Message_log "
					    +" from customer where customer_level_id = 3 and (parent_customer_id is not null or loan_officer_id is null) ");	
				
			
				
				String[] queries = { sbQuery1.toString(), sbQuery2.toString(),
					sbQuery3.toString(), sbQuery4.toString(),sbQuery5.toString(),sbQuery6.toString() }; 
					int i = 0;
				for(String query : queries){

						psmt = con.prepareStatement(query);
						 rs = psmt.executeQuery();

						 if (rs.next()) {					 	
						    	rs.beforeFirst();
						    	while(rs.next()){
						    		logger.error(rs.getString("Message_log"));						   	
						    	}
						    	i=1;						    	 
							} 							
					}
				if(i!=0)
					status = false;
									
			} catch (Exception e) {
				status = false;
				logger.error("Exception while executing Validations on required customer(center->group->client) hierarchy " + e.getMessage());
				throw new DMTException("Exception while executing Validations on required customer(center->group->client) hierarchy " + e.getMessage());
			} 
			finally {
				try {
					if(rs != null)
						rs.close();
					if(psmt != null)
						psmt.close();				
				} catch (SQLException se) {
					logger.error("SQLException in finally while closing dbconnection "+se);
				}
			}		
			return status;
		}// end of validate()...
	 
	 
}
