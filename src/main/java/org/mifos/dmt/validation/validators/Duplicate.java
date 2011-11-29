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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.validation.Validator;

public class Duplicate  implements Validator {
  
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Duplicate.class.getName());
		 
	Connection con;
	PreparedStatement psmt;
	DBConnection dbConnection;
	ResultSet rs;
	boolean status;
	String productionSchema;
	
	public Duplicate() {
		
		con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
		HashMap<String, String> dbVals = DMTDatabaseConfigurations.PRODUCTION;
		productionSchema=dbVals.get("schema");
		rs = null;
		status = true;
		psmt=null;
	}
		
	@Override
	public boolean validate(Map<String,List<String>> map,int customerLevelId) throws DMTException {

		
		String tableName = null;		
		Map<String, List<String>> duplicateFieldsMap = null;
	

		try {
		
			
			duplicateFieldsMap = map; 

			List<String> duplicateFieldsList = new ArrayList<String>();
			Set<Map.Entry<String, List<String>>> set = duplicateFieldsMap.entrySet();				
			
			StringBuilder sbQuery = new StringBuilder();
			StringBuilder sbQuery1 = new StringBuilder();
			StringBuilder sbQuery2 = new StringBuilder();
			StringBuilder sbQuery3 = new StringBuilder();
			StringBuilder sbQuery4 = new StringBuilder();
			StringBuilder sbQuery5 = new StringBuilder();
			StringBuilder sbWhereQuery = new StringBuilder();	
			
			 for (Map.Entry<String, List<String>> entrySet : set) {
	
				sbQuery1.append("SELECT ");
				sbQuery2.append("( SELECT ");
				sbQuery4.append("( SELECT ");
				sbWhereQuery.append(" WHERE ");

				tableName = entrySet.getKey(); // Get the key
				duplicateFieldsList = entrySet.getValue(); // Get the Value
				 
				/*logger.info("key-TableName: "+tableName);
				logger.info("values-duplicateLists: "+duplicateFieldsList);*/
				
		 		if (!duplicateFieldsList.isEmpty()) {
					
					for (int i = 0; i < duplicateFieldsList.size(); i++) {
						if (i != duplicateFieldsList.size() - 1) {
							sbQuery1.append("cust1." +duplicateFieldsList.get(i) + ",");
							sbQuery2.append(duplicateFieldsList.get(i) + ",");
							sbQuery3.append(duplicateFieldsList.get(i) + ",");
							sbQuery4.append(duplicateFieldsList.get(i) + ",");
							sbWhereQuery.append("cust1." +duplicateFieldsList.get(i) + " = ");
							sbWhereQuery.append("cust2." +duplicateFieldsList.get(i)+ " AND ");

						} else {
														
							sbQuery1.append("cust1." +duplicateFieldsList.get(i));
							sbQuery1.append(" ,cust1.display_name ");
							sbQuery2.append(duplicateFieldsList.get(i) + ", count(*) ");
							sbQuery3.append(duplicateFieldsList.get(i));
							sbQuery4.append(duplicateFieldsList.get(i) + ", count(*) ");
							sbWhereQuery.append("cust1." +duplicateFieldsList.get(i) + " = ");
							sbWhereQuery.append("cust2." +duplicateFieldsList.get(i));
						}
					}		
					//Adding customer_level_Id field if the table is customer
					if(tableName.equalsIgnoreCase("customer"))
						sbWhereQuery.append(" AND cust1.customer_level_id ="+customerLevelId);
					
					
					sbQuery1.append(" FROM " + tableName+" as cust1 INNER JOIN ");
					sbQuery2.append(" FROM "+ tableName+" GROUP BY "+sbQuery3+" HAVING COUNT(*)>1) as cust2 ");
					sbQuery4.append(" FROM "+ productionSchema + "."+tableName+" GROUP BY "+sbQuery3+" HAVING COUNT(*)>=1) as cust2 ");
					
					sbQuery.append(sbQuery1);
					sbQuery.append(sbQuery2);
					sbQuery.append(sbWhereQuery);

					/*logger.info("Duplicate Query is: " + sbQuery);*/

					 psmt = con.prepareStatement(sbQuery.toString());
					 rs = psmt.executeQuery();

					 if (rs.next()) {
						rs.beforeFirst();
							
					   	while (rs.next()) {
							for (int i = 0; i < duplicateFieldsList.size(); i++) {							
																 
								 logger.error("In Table "  + tableName
										+ " field: " + duplicateFieldsList.get(i)
										+ " is duplicate for customer: " + rs.getString("display_name"));
								 
							}// end of for...							
						}// end of while...					   	
					   	
					   	status = false;
					   	
 					} else {
 						if(customerLevelId==2) logger.info("Duplicate field validation passed for group ");
 						if(customerLevelId==1) logger.info("Duplicate field validation passed for client ");						
					} 
					// for center, compare against production data also 
					 if(customerLevelId==3)
					 {
							sbQuery5.append(sbQuery1);
							sbQuery5.append(sbQuery4);
							sbQuery5.append(sbWhereQuery);
							
							psmt = con.prepareStatement(sbQuery5.toString());
							 rs = psmt.executeQuery();

							 if (rs.next()) {
								rs.beforeFirst();
									
							   	while (rs.next()) {
									for (int i = 0; i < duplicateFieldsList.size(); i++) {							
																		 
										 logger.error("In Table "  + tableName
												+ " field: " + duplicateFieldsList.get(i)
												+ " is duplicate. Same center information exists in Production database: " + rs.getString("display_name"));
										 
									}// end of for...							
								}// end of while...					   	
							   	
							   	status = false;
							   	
		 					} else {
		 						if(customerLevelId==3) logger.info("Duplicate field validation passed for center ");
							} 
					 } // end of if
					 
				}// ends isEmpty condition....
				 
				//Clearing the buffer and list				 
				duplicateFieldsList.clear();
				sbQuery.setLength(0);
				sbQuery1.setLength(0);
				sbQuery2.setLength(0);
				sbWhereQuery.setLength(0);	
				sbQuery4.setLength(0);
				sbQuery5.setLength(0);
			} 
		}  catch (Exception e) {
			status = false;
			logger.error("Exception while executing Validations on fields that needs to be unique/non-duplicate " + e.getMessage());
			throw new DMTException("Exception while executing Validations on fields that needs to be unique/non-duplicate " + e.getMessage());
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
 
}//end of class...
