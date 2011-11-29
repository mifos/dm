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

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;

public class PurgeEmptyRows {
/*
 * EOF needs to be set on every sheet 1st col so that it can be stripped 
 */
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(PurgeEmptyRows.class.getName());
	private Workbook workbook;
	
	public PurgeEmptyRows(Workbook workbook) {
		this.workbook = workbook;
	}
	
	public Workbook processEmptyRows() throws DMTException {
		for(int j=1; j<=(workbook.getNumberOfSheets()-1);j++){
		Sheet sheet = workbook.getSheetAt(j);
		int targetRow =-1;
		for(int i=0; i<=sheet.getLastRowNum();i++) {
			Row row = sheet.getRow(i);
			if(row ==null) continue;
			Cell cell = row.getCell(0);
			if(cell==null) continue;
			String val = cell.toString();
			if(val.equals("EOF")) {
				targetRow = i;
			}
		}
		if(targetRow==-1) {
			logger.error("EOF value missing @ " +sheet.getSheetName());
			throw new DMTException("EOF value missing @ " +sheet.getSheetName());
		}
		cleanUpSheet(sheet,targetRow,sheet.getLastRowNum());
		}
		return workbook;
	}

	private void cleanUpSheet(Sheet sheet, int targetRow, int lastRowNum) {
		logger.info(("sheet "+sheet.getSheetName()+" processed with "+targetRow+" rows."));
		for(int i=targetRow; i<=lastRowNum; i++) {
			Row row = sheet.getRow(i);
			if(row==null) continue;
			sheet.removeRow(row);
			
		}
		
	}


}
