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

package org.mifos.dmt.excel.columnValidator;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;

public class ColumnStructure {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(ColumnStructure.class.getName());
	private Workbook workbook;
	private Workbook baseworkbook;
	public static boolean sheetPass;
	
	public ColumnStructure(Workbook workbook, String baseTemplate) throws InvalidFormatException, IOException {
		this.workbook = workbook;
		InputStream inputstream = new FileInputStream(baseTemplate);
		this.baseworkbook = WorkbookFactory.create(inputstream);
	}
	
	public Workbook processSheetStructure() throws DMTException {
		ArrayList<String> sheetsToBeProcessed = getSheetsToBeProcessed();
		Iterator<String> itr = sheetsToBeProcessed.iterator();
		while (itr.hasNext()) {
			sheetPass = true;
			String sheetName = (String) itr.next();
			Sheet baseComparisonSheet = baseworkbook.getSheet(sheetName);
			Row baseComparisonRow = baseComparisonSheet.getRow(0);
			Sheet compareToSheet = workbook.getSheet(sheetName);
			Row comparisonRow = compareToSheet.getRow(0);
			short lastCell = comparisonRow.getLastCellNum();
			int j=0;
			for(short i=0; i<=lastCell-1; i++,j++) {
				if(!baseComparisonRow.getCell(j).toString().equals(comparisonRow.getCell(j).toString())) 
				{
					sheetPass=false;
					logger.error("Following Column value for the sheet "+comparisonRow.getSheet().getSheetName()+" does not match with base template "+comparisonRow.getCell(j).toString());
				}
			}
			
			if(!sheetPass) 
			{
				logger.error("Failed column validations for the sheet"); 
				throw new DMTException("Failed column validations for the sheet");
			}
		}
		logger.info("Excel sheet passed structural validations");
		return workbook;
		
	}

	private ArrayList<String> getSheetsToBeProcessed() {
		ArrayList<String> sheetList = new ArrayList<String>();
		for(int i=1; i<=(workbook.getNumberOfSheets()-1);i++) {
			sheetList.add(workbook.getSheetAt(i).getSheetName());
		}
		return sheetList;
	}
}
