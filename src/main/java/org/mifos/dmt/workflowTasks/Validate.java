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

package org.mifos.dmt.workflowTasks;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.mifos.dmt.validation.ParsingValidators;
import org.mifos.dmt.validation.validators.ClientLoanAccountRecurrence;
import org.mifos.dmt.validation.validators.DateCheck;
import org.mifos.dmt.validation.validators.Duplicate;
import org.mifos.dmt.validation.validators.GroupLoans;
import org.mifos.dmt.validation.validators.Hierarchy;
import org.mifos.dmt.validation.validators.LoanAccountProductRecurrence;
import org.mifos.dmt.validation.validators.Mandatory;
import org.mifos.dmt.validation.validators.Range;

public class Validate extends Task {

	private static Logger logger = Logger.getLogger(Validate.class.getName());

		private Mandatory validateMandatory;
 		private Duplicate validateDuplicate;
 		private Hierarchy validateHierarchy; 		
 		private Range validateRange; 	
 		private DateCheck validateDateCheck;
 		private GroupLoans validateGroupLoans;
 		private LoanAccountProductRecurrence validateLoanAccountProductRecurrence;
 		private ClientLoanAccountRecurrence validateClientLoanAccountRecurrence;
 		
 		

		public ClientLoanAccountRecurrence getValidateClientLoanAccountRecurrence() {
			return validateClientLoanAccountRecurrence;
		}

		public void setValidateClientLoanAccountRecurrence(
				ClientLoanAccountRecurrence validateClientLoanAccountRecurrence) {
			this.validateClientLoanAccountRecurrence = validateClientLoanAccountRecurrence;
		}

		public LoanAccountProductRecurrence getValidateLoanAccountProductRecurrence() {
			return validateLoanAccountProductRecurrence;
		}

		public void setValidateLoanAccountProductRecurrence(
				LoanAccountProductRecurrence validateLoanAccountProductRecurrence) {
			this.validateLoanAccountProductRecurrence = validateLoanAccountProductRecurrence;
		}

		public GroupLoans getValidateGroupLoans() {
			return validateGroupLoans;
		}

		public void setValidateGroupLoans(GroupLoans validateGroupLoans) {
			this.validateGroupLoans = validateGroupLoans;
		}

		public DateCheck getValidateDateCheck() {
			return validateDateCheck;
		}

		public void setValidateDateCheck(DateCheck validateDateCheck) {
			this.validateDateCheck = validateDateCheck;
		}

		/**
		 * @return the validateMandatory
		 */
		public Mandatory getValidateMandatory() {
			return validateMandatory;
		}

		/**
		 * @param validateMandatory the validateMandatory to set
		 */
		public void setValidateMandatory(Mandatory validateMandatory) {
			this.validateMandatory = validateMandatory;
		}

		/**
		 * @return the validateDuplicate
		 */
		public Duplicate getValidateDuplicate() {
			return validateDuplicate;
		}

		/**
		 * @param validateDuplicate the validateDuplicate to set
		 */
		public void setValidateDuplicate(Duplicate validateDuplicate) {
			this.validateDuplicate = validateDuplicate;
		}

		/**
		 * @return the validateHierarchy
		 */
		public Hierarchy getValidateHierarchy() {
			return validateHierarchy;
		}

		/**
		 * @param validateHierarchy the validateHierarchy to set
		 */
		public void setValidateHierarchy(Hierarchy validateHierarchy) {
			this.validateHierarchy = validateHierarchy;
		}

		/**
		 * @return the validateRange
		 */
		public Range getValidateRange() {
			return validateRange;
		}

		/**
		 * @param validateRange the validateRange to set
		 */
		public void setValidateRange(Range validateRange) {
			this.validateRange = validateRange;
		}

	public void compensate() {
		System.out.println("compensate method not being used...");
	}

	@Override
	public boolean execute() {
		boolean vaidationStatus = true;
	  try{
		 if(!executeValidate() ){
			 
			 //logger.error("Validations failed");
			 vaidationStatus = false;
			 throw new Exception("DMT Validation failed ");				
		 }else{
			 	logger.info("DMT Validations are passed");
		 }
	  }catch(Exception e){
		  logger.error(e);
		 // System.exit(1);
		  logger.error("The validation should be stopped now");
	  }	  
	return vaidationStatus;	 
	}// end of execute ...

	
	private List<String> getValidatorsList(){
		
		List<String> validatorsList = new ArrayList<String>();

		//For Centers
		validatorsList.add(0,"Center_mandatory_cols");
		validatorsList.add(1,"Center_duplicate_cols");
		
		//For Groups
		validatorsList.add(2,"Group_mandatory_cols");
		validatorsList.add(3,"Group_duplicate_cols");
		
		//For Clients
		validatorsList.add(4,"mandatory_cols");
		validatorsList.add(5,"duplicate_cols");
		
	 return validatorsList;	
	}
	
	private boolean executeValidate() throws Exception{

		//boolean status = false;	
		int statusCount = 0;
						
	try{
		List<String> validatorsList = getValidatorsList();
		 
		logger.debug("The execute method started");	 		    		 

		Map<String,Map<String,String>> mainMap = ParsingValidators.readValidators();		 
	    Set<Entry<String, Map<String, String>>> mainSet = mainMap.entrySet();
	    String tableName = null;
	    Map<String,String> subMap = new HashMap<String,String>();
	    String columns = null;
	    StringTokenizer stoken = null;
	    List<String> columnsList = new ArrayList<String>();
	    Set<String>  subMapKeys= null;
	    Map <String,List<String>> map = new HashMap<String,List<String>>(); 
	    int tokenCount = 0;
	    
		for(Entry<String, Map<String, String>> mainEntrySet: mainSet){
			tableName = mainEntrySet.getKey();
			
			subMap = mainEntrySet.getValue();
			subMapKeys = subMap.keySet();
			
			 for(String key: subMapKeys){
				 //Validate For Mandatory Fields - Center				  
				 if(key.equalsIgnoreCase(validatorsList.get(0))){
					 	map.clear();
					 	columnsList.clear();
		
					 columns = subMap.get(validatorsList.get(0));
					  stoken = new StringTokenizer(columns,",");

					  tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							map.put(tableName, columnsList);
						} 
					 
						
					   if(!getValidateMandatory().validate(map,3)){
						   logger.error("Mandatory check failed at center level");
						   statusCount=1;
					   }
				 } 
				 
				 //Validate For Duplicate Fields - Center
				 if(key.equalsIgnoreCase(validatorsList.get(1))){
					 	map.clear();
					 	columnsList.clear();
				
					 columns = subMap.get(validatorsList.get(1));
					 stoken = new StringTokenizer(columns,",");
					 
					  tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							map.put(tableName, columnsList);
						} 
						
						
					 	if(!getValidateDuplicate().validate(map,3)){
							logger.error("Duplicate check failed at center level");		
							statusCount=1;
					 	}
				 }		
				 
				//Validate For Mandatory Fields	- Group			  
				 if(key.equalsIgnoreCase(validatorsList.get(2))){
					 	map.clear();
					 	columnsList.clear();
					 	
					 columns = subMap.get(validatorsList.get(2));
					  stoken = new StringTokenizer(columns,",");

					  tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							map.put(tableName, columnsList);
						} 
					 
						
					   if(!getValidateMandatory().validate(map,2)){
						  logger.error("Mandatory check failed at group level");		
						  statusCount=1;
					   }
				 } 
				 
				 //Validate For Duplicate Fields - Group
				 if(key.equalsIgnoreCase(validatorsList.get(3))){
					 	map.clear();
					 	columnsList.clear();
					 
					 columns = subMap.get(validatorsList.get(3));
					 stoken = new StringTokenizer(columns,",");
					 
					  tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							map.put(tableName, columnsList);
						} 
						
						
					 	if(!getValidateDuplicate().validate(map,2)){
					 		logger.error("Duplicate check failed at group level");
					 		statusCount=1;
					 	}
				 }		
				 
				//Validate For Mandatory Fields	- Client		  
				 if(key.equalsIgnoreCase(validatorsList.get(4))){
					 	map.clear();
					 	columnsList.clear();
					 
					 columns = subMap.get(validatorsList.get(4));
					  stoken = new StringTokenizer(columns,",");

					  tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							
							map.put(tableName, columnsList);
							
							
						} 
					 
						
					   if(!getValidateMandatory().validate(map,1))	{					  
							logger.error("Mandatory check failed at client level");
							statusCount=1;
					   }
				 } 
			
				  
				  //Validate For Duplicate Fields - Client
				 if(key.equalsIgnoreCase(validatorsList.get(5))){
					 	map.clear();
					 	columnsList.clear();
					 	
					 columns = subMap.get(validatorsList.get(5));
					 stoken = new StringTokenizer(columns,",");
					 
					 tokenCount = stoken.countTokens();
						if (tokenCount == 1) {
							columnsList.add(stoken.nextToken());     //20-04-2011 Added for single field
							map.put(tableName, columnsList);
						} else {
							for (int i = 0; i < tokenCount; i++) {
								columnsList.add(stoken.nextToken());
							}
							map.put(tableName, columnsList);
						} 
						
				
					 	if(!getValidateDuplicate().validate(map,1)){
					 		logger.error("Duplicate check failed at client level");
					 		statusCount=1;
					 	}
				 }		
			  }//subMaps key for loop
     	   }			
		
		
		  // Below are the default validations for Hierarchy and Range Check 
		 
		  // Calling Hierarchy Check Validation			

		
			 	if(!getValidateHierarchy().validate(map,0)){
			 		 logger
						.error("Hierarchy check failed, please verify the Center/Group/Client/Loan Officer link");
			 		statusCount=1;
			 	}
			

		  // Calling Range Check Validation			 	
			 	if(!getValidateRange().validate(map,0)){
			 		logger
						.error("Range check failed,please verify if the " +
								"loan_amount/interest_rate/installments match the loan product specifications");	
			 		statusCount=1;
			 	}
			 	
			 	// calling Date Check Validation
			 	if(!getValidateDateCheck().validate(map,0)){
			 		logger
						.error("Some of the checks on entered dates are failed " +
								"please check the creation, disbursement, trained dates entered");	
			 		statusCount=1;
			 	}
			
			 	// Calling Group Loan product Validation
			 	if(!getValidateGroupLoans().validate(map,0)){
			 		logger
						.error("The loan products are not correctly " +
								"associated with some of the loan accounts.");	
			 		statusCount=1;
			 	}
			 	
			 	if(!getValidateLoanAccountProductRecurrence().validate(map,0)){
			 		logger
						.error("The product recurrence is mismatching with the loan.");	
			 		statusCount=1;
			 	}
			 	
			 	if(!getValidateClientLoanAccountRecurrence().validate(map,0)){
			 		logger
						.error("The loan account recurrence is mismatching with the client.");	
			 		statusCount=1;
			 	}
	}catch(Exception e){
		
		logger.info("Exception in validate "+e);
	}
	
	//Checking status of the validation
		if (statusCount != 0)
			return false;
		else
			return true;		
	}

	@Override
	public String getMessage() {
		return "Executing Validation Framework";
	}
	
}// end of class...
