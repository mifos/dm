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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.validation.Validator;
  

public class Mandatory implements Validator {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Mandatory.class.getName());
		
	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	ResultSet rs;
	boolean status;
	
	public Mandatory() {
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		rs = null;
		status = true;
		psmt=null;
	}

	@Override
	public boolean validate(Map<String,List<String>> map,int customerLevelId) throws DMTException {

		
		String tableName = null;
		String field = null;
		String customer=null;
		
		Map<String, List<String>> mandatoryFieldsMap = null; 
	
		try {
							
		  if(!map.isEmpty()){			 
			  
			mandatoryFieldsMap = map; 
			
			
			List<String> mandatoryFieldsList = new ArrayList<String>();
			Set<Map.Entry<String, List<String>>> set = mandatoryFieldsMap.entrySet();
			
			
			StringBuilder sbQuery = new StringBuilder();
			StringBuilder sbWhereQuery = new StringBuilder();

			 for (Map.Entry<String, List<String>> entrySet : set) {
				 
				sbQuery.append("SELECT ");
				sbWhereQuery.append(" WHERE ");
				
				tableName = entrySet.getKey(); // Get the key
				/*logger.info("key is: "+tableName);*/
				mandatoryFieldsList = entrySet.getValue(); // Get the Value
//				logger.info("values are: "+mandatoryFieldsList);
				
				if(tableName.equalsIgnoreCase("customer"))
					sbWhereQuery.append(" customer_level_id ="+customerLevelId+" AND ");
				
				sbWhereQuery.append("( ");
				
		 		if (!mandatoryFieldsList.isEmpty()) {
					
					for (int i = 0; i < mandatoryFieldsList.size(); i++) {
						if (i != mandatoryFieldsList.size() - 1) {
							sbQuery.append(mandatoryFieldsList.get(i) + " ,");
							sbWhereQuery.append(mandatoryFieldsList.get(i) + " IS NULL OR ");

						} else {
							sbQuery.append(mandatoryFieldsList.get(i));
							sbQuery.append(" , display_name ");
							sbWhereQuery.append(mandatoryFieldsList.get(i) + " IS NULL )");
						}
					}										
					
					sbQuery.append(" FROM " + tableName);
					sbQuery.append(" " + sbWhereQuery);

					 psmt = con.prepareStatement(sbQuery.toString());
					 rs = psmt.executeQuery();

					 if (rs.next()) {
						rs.beforeFirst();
							
					   	while (rs.next()) {
							for (int i = 0; i < mandatoryFieldsList.size(); i++) {
								field = rs.getString(mandatoryFieldsList.get(i).toString());
							    customer= rs.getString("display_name");
								if (!validateNotNull(field)) {
									logger.error("In Table "  + tableName
											+ " field: " + mandatoryFieldsList.get(i)
											+ " is null for " + customer);									 					
								}
							}// end of for...
						}// end of while...
					   	
					   	status = false;
					   	
 					} else {
 						if(customerLevelId==3) logger.info("Mandatory field validation passed for center ");
 						if(customerLevelId==2) logger.info("Mandatory field validation passed for group ");
 						if(customerLevelId==1) logger.info("Mandatory field validation passed for client ");						
					} 
				}// ends isEmpty condition....
				 
				//Clearing the buffer and list				 
				mandatoryFieldsList.clear();
				sbQuery.setLength(0);
				sbWhereQuery.setLength(0);
			 }// map is empty condition
			 
			} else{
				logger.info("the map doesn't have any values inside");				
			}
		} catch (Exception e) {
			status = false;
			logger.error("Exception while executing Validations on the mandatory fields " + e.getMessage());
			throw new DMTException("Exception while executing Validations on the mandatory fields " + e.getMessage());
		} 
		finally {
			try {
				if(rs != null)
					rs.close();
				if(psmt != null)
					psmt.close();				
			
				//con.close();
				
			} catch (SQLException se) {
				logger.error("SQLException in finally block "+se);
			}
		}		
		return status;
	}// end of validate()...

		 
	// Validate not null values
	private boolean validateNotNull(String field) {
		if (field == null || field.equals(null)) {
			return false;
		}
		return true;
	}// end of validateNotNull
	 			
}// end of class...
