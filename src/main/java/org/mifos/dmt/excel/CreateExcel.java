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

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.util.DMTMigrationParams;

public class CreateExcel {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(CreateExcel.class.getName());
    
	public CreateExcel() {
		logger.info("Beginning to create excel template for migration");
	}
	
	public Workbook generate(String baseTemplate, DMTMigrationParams params) throws InvalidFormatException, IOException, DMTException {
        InputStream inp = new FileInputStream(baseTemplate);

        Workbook wb = WorkbookFactory.create(inp);
        ArrayList<String> sheetSpec = readSheetSpec(params);
        for (int i=wb.getNumberOfSheets(); i>0; i--) {
        	String sheetName = wb.getSheetName(i-1);
        	if(sheetSpec.contains(sheetName)) {
        		wb.removeSheetAt(i-1);
        	} else {
        		logger.info("Adding sheet : " + sheetName);
        	}
        	
		}
        Sheet configSheet = wb.getSheetAt(0);
        editConfigSheet(configSheet);
        
        return wb;
    }

	private void editConfigSheet(Sheet configSheet) throws DMTException {
		ConfigSheet cfSheet = new ConfigSheet();
		Method[] methods = ConfigSheet.class.getDeclaredMethods();
		for (Method method : methods) {
			
			if(Modifier.isPublic(method.getModifiers()))
				try {
					method.invoke(cfSheet);
				} catch (Exception e) {
					logger.error(e.getMessage());
					throw new DMTException("error while editing config sheet " +e.getMessage());
				}				
		}
		 Row configHeader = configSheet.getRow(1);
	     Iterator<Cell> x= configHeader.cellIterator();
	        while (x.hasNext()) {
				Cell cell = x.next();
				String label = cell.getStringCellValue();
				int index = cell.getColumnIndex();
				populateColumn(configSheet, label, index, cfSheet.excelValues);
			}
		
	}

	private void populateColumn(Sheet configSheet, String label,
			int index, HashMap<String, ArrayList<String>> excelValues) {
		ArrayList<String> values = excelValues.get(label);
		int numValues = values.size();
		for(int i =2, j = 0 ; i< 2+numValues ; i++,j++) {
			
			Row temp = (configSheet.getRow(i)==null) ? configSheet.createRow(i) : configSheet.getRow(i);
			Cell tempCell = temp.createCell(index);
			tempCell.setCellValue(values.get(j));
		}
		
	}

	private ArrayList<String> readSheetSpec(DMTMigrationParams params) {
		ArrayList<String> list = new ArrayList<String>();
		if(!params.isMIGRATE_CENTER())
			list.add("Center");
		if(!params.isMIGRATE_INDIVIDUAL_CLIENTS()) {
			list.add("IndividualClient");
			list.add("IndividualClientMeetings");
		}
		if(!params.isMIGRATE_GROUP_LOANS())
			list.add("GroupLoans");
		if(!params.isMIGRATE_CUSTOM_FEILDS()) {
			list.add("Center-QuestionGroups");
			list.add("Groups-QuestionGroups");
			list.add("Clients-QuestionGroups");
			list.add("Loans-QuestionGroups");
		}
		if(!params.isMIGRATE_FEES())
			list.add("Fees");
		return list;
	}
}