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

package org.mifos.dmt.excel;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.util.DMTMigrationParams;
import org.testng.Assert;
import org.testng.annotations.Test;

public class CreateExcelTest {
	
	CreateExcel excel;
	String baseTemplate = DMTConfig.DMT_CONFIG_DIR+"\\DMTMigrationTemplateBase.xlsx";
	DMTMigrationParams dmtParams;
	Workbook workbook;
	Workbook actualworkbook;
	boolean status;
	
	public CreateExcelTest()
	{
		excel=new CreateExcel();
		dmtParams=new DMTMigrationParams();
		workbook=null;
		actualworkbook=null;
	}
  @Test
  public void generate() throws InvalidFormatException, IOException, DMTException {

		File file = new File("src/test/resources/org/mifos/dmt/excel","MigrationTemplateTest.xlsx");
		FileOutputStream fileoutputstream = new FileOutputStream(file);
		workbook=excel.generate(baseTemplate, dmtParams);
		workbook.write(fileoutputstream);
		status=file.isFile();
		Assert.assertTrue(status);
			
  }
}
