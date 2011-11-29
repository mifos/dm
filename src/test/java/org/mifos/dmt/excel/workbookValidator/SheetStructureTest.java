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

package org.mifos.dmt.excel.workbookValidator;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.mifos.dmt.configuration.DMTMigrationConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.testng.Assert;
import org.testng.annotations.Test;

public class SheetStructureTest {

	private Workbook workbook;
	SheetStructure sheetStructure;
	File file;
	boolean status;
	private static final DMTLogger logger=(DMTLogger)DMTLogger.getLogger(SheetStructureTest.class.getName());

	public SheetStructureTest()
	{
		 DMTMigrationConfigurations.MIGRATE_CENTER=true;
		 DMTMigrationConfigurations.MIGRATE_CUSTOM_FEILDS=false;
		 DMTMigrationConfigurations.MIGRATE_FEES=true;
		 DMTMigrationConfigurations.MIGRATE_GROUP_LOANS=true;
		 DMTMigrationConfigurations.MIGRATE_INDIVIDUAL_CLIENTS=false;
		 
		
	}
	
  @Test
  public void processWorkbookTrue() throws InvalidFormatException, IOException, Exception {
	  
	
		InputStream inp =this.getClass().getResourceAsStream("MigrationTemplatePassTest.xlsx");
		workbook = WorkbookFactory.create(inp);
		sheetStructure = new SheetStructure(this.workbook);
		status=false;
		status=sheetStructure.processWorkbook();
		Assert.assertTrue(status);
  }
  
  @Test
    public void processWorkbookFalse() throws InvalidFormatException, IOException, Exception{
	  
		InputStream inp =this.getClass().getResourceAsStream("MigrationTemplateFailTest.xlsx");
		workbook = WorkbookFactory.create(inp);
		sheetStructure = new SheetStructure(this.workbook);
		status=true;
		status=sheetStructure.processWorkbook();
		Assert.assertFalse(status);
  }
}
