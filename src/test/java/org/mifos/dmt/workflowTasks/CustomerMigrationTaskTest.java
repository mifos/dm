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
import java.math.RoundingMode;
import java.util.HashMap;
import org.dbunit.Assertion;
import org.dbunit.IDatabaseTester;
import org.dbunit.JdbcDatabaseTester;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.ITable;
import org.mifos.dmt.configuration.DMTAccountingProperties;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class CustomerMigrationTaskTest {
	
    CustomerMigrationTask customerMigrationTask;
    IDatabaseTester databaseTester;
    RoundingMode initialRoundingMode;
	RoundingMode finalRoundingMode;
	Double initialRoundOffMultiple;
	Double finalRoundOffMultiple;
	Integer  digitsAfterDecimal;
	Integer  digitsAfterDecimalForInterest;
	
	@BeforeTest(groups="method5")
	public void setUp() throws Exception
	{
		
		customerMigrationTask=new CustomerMigrationTask();
		  HashMap<String, String>stage1DbVal = DMTDatabaseConfigurations.STAGING_1;	  
		    String stage1User = stage1DbVal.get("user");
			String stage1Pass = stage1DbVal.get("password");
			String stage1Schema = stage1DbVal.get("schema");
			String stage1dbHost = stage1DbVal.get("host");
			String stage1dbPort = stage1DbVal.get("port");
			String connectionURL="jdbc:mysql://"+stage1dbHost+":"+stage1dbPort+"/"+stage1Schema;
			databaseTester = new JdbcDatabaseTester("com.mysql.jdbc.Driver",connectionURL, stage1User, stage1Pass);
			String stage2jobFilePath= DMTConfig.DMT_CONFIG_DIR
			                         + "\\prepStaging.bat";
			String stage1Sql= "src/test/resources/org/mifos/dmt/workflowTasks/customer_schedule.sql";
			
			try{
				
			String space = " ";
			String arg = stage2jobFilePath + space + stage1dbHost
					+ space + stage1User + space + stage1Pass + space
					+ stage1Schema + space + stage1Sql + space + stage1dbPort;
			Process thread = Runtime.getRuntime().exec(arg);
			thread.waitFor();
	         }catch (Exception e) {
			e.printStackTrace();
		}
	}

    @SuppressWarnings("unused")
	@Test(groups="method5")
    public void execute() throws Exception 
    {    
    	
    	initialRoundingMode=RoundingMode.HALF_UP;
    	finalRoundingMode=RoundingMode.CEILING;
    	initialRoundOffMultiple=(double) 1;
    	finalRoundOffMultiple=(double)1;
    	digitsAfterDecimal=1;
    	digitsAfterDecimalForInterest=5;
  		//overriding the existing configuration values with test configuration
  		DMTAccountingProperties.INITIAL_ROUNDING_MODE=initialRoundingMode;
  		DMTAccountingProperties.FINAL_ROUNDING_MODE=finalRoundingMode;
  		DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE=initialRoundOffMultiple;
  		DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE=finalRoundOffMultiple;
  		DMTAccountingProperties.DIGITS_AFTER_DECIMAL=digitsAfterDecimal;
  		DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST=digitsAfterDecimalForInterest;
  		
		boolean status=customerMigrationTask.execute();
    	IDatabaseConnection connection = databaseTester.getConnection();
        ITable actualTable = connection.createQueryTable("CUSTOMER_SCHEDULE","select * from customer_schedule"); 
        ITable expectedTable =connection.createQueryTable("CUSTOMER_SCHEDULE_TEST","select * from customer_schedule_test");
        ITable actualTableFee = connection.createQueryTable("CUSTOMER_FEE_SCHEDULE","select * from customer_fee_schedule"); 
        ITable expectedTableFee =connection.createQueryTable("CUSTOMER_FEE_SCHEDULE_TEST","select * from customer_fee_schedule_test");
        Assertion.assertEquals(expectedTable, actualTable);
        Assertion.assertEquals(expectedTableFee, actualTableFee);
    	  	 
    }
}
