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
import org.testng.Assert;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.validation.validators.Mandatory;
import org.testng.annotations.Test;

public class MandatoryTest {

	//method to pass the correct data functionality
	  @Test(groups="method1")
	  public void validateTrueGroups() throws DMTException {
		  boolean retStatus = false;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("parent_customer_id");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 2);
		  Assert.assertTrue(retStatus);
	  }
	  
	  @Test(groups="method1")
	  public void validateTrueCenters() throws  DMTException {
		  boolean retStatus = false;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("loan_officer_id");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 3);
		  Assert.assertTrue(retStatus);
	  }
	  
	  @Test(groups="method1")
	  public void validateTrueClients() throws  DMTException {
		  boolean retStatus = false;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("date_of_birth");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 1);
		  Assert.assertTrue(retStatus);
	  }
	  
	//method to fail the wrong data functionality
	  @Test(groups="method2")
	  public void validateFalseGroups() throws DMTException {
		  boolean retStatus = true;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("parent_customer_id");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 2);
		  Assert.assertFalse(retStatus);
	  }
	  
	  @Test(groups="method2")
	  public void validateFalseCenters() throws  DMTException {
		  boolean retStatus = true;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("loan_officer_id");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 3);
		  Assert.assertFalse(retStatus);
	  }
	  
	  @Test(groups="method2")
	  public void validateFalseClients() throws DMTException {
		  boolean retStatus = true;
		  Map <String,List<String>> map = new HashMap<String,List<String>>();
		  List<String> columnsList = new ArrayList<String>();
		  columnsList.add("display_name");
		  columnsList.add("date_of_birth");	
		  String tableName="customer";
		  map.put(tableName, columnsList);
		  Mandatory x = new Mandatory();
		  retStatus= x.validate(map, 1);
		  Assert.assertFalse(retStatus);
	  }	
}