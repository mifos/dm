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

package org.mifos.dmt.excel.cleanup;

import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.junit.Assert;
import org.mifos.dmt.util.DMTException;
import org.testng.annotations.Test;

public class PurgeEmptyRowsTest {

	  Workbook workbook;
	  PurgeEmptyRows purgeEmptyRows;
	  boolean status;

  @Test
  public void processEmptyRowsTrue() throws InvalidFormatException, IOException {
      status=true;
	  InputStream inp =this.getClass().getResourceAsStream("MigrationTemplatePassTest.xlsx");
	  workbook = WorkbookFactory.create(inp);
	  purgeEmptyRows=new PurgeEmptyRows(workbook);
	  try {
		  workbook=purgeEmptyRows.processEmptyRows();
	} catch (DMTException e) {
		status=false;
	}
	finally
	{

	 Assert.assertTrue(status);
	}
  }
  
  @Test
  public void processEmptyRowsFalse() throws InvalidFormatException, IOException {
      status=true;
      InputStream inp =this.getClass().getResourceAsStream("MigrationTemplateFailTest.xlsx");
	  workbook = WorkbookFactory.create(inp);
	  purgeEmptyRows=new PurgeEmptyRows(workbook);
	  try {
		  workbook=purgeEmptyRows.processEmptyRows();
	} catch (DMTException e) {
		status=false;
	}
	finally
	{

	 Assert.assertFalse(status);
	}
  }
  
}
