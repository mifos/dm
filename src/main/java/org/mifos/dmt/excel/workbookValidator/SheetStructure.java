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
import java.util.ArrayList;
import java.util.Iterator;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTMigrationParams;

public class SheetStructure {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(SheetStructure.class.getName());
	private Workbook workbook;
	private DMTMigrationParams migrationParams;
	public SheetStructure(Workbook workbook) {
		this.workbook=workbook;
		migrationParams = new DMTMigrationParams();
	}
	
	public boolean processWorkbook() {
		boolean sheetAsPerConfig = true;
		Sheet testSheet = null;
		ArrayList<String> sheetIndex = createSheetIndex(migrationParams);
		Iterator<String> itr = sheetIndex.iterator();
		while (itr.hasNext()) {
			String sheetName = (String) itr.next();
			testSheet = workbook.getSheet(sheetName);
			if(testSheet == null) {
				sheetAsPerConfig= false;
				logger.error("Missing sheet is:" + sheetName);
			}
		}
		if(sheetAsPerConfig) {
			logger.info("Excel Workbook sheet structural validation is passed");
		} else {
			logger.error("Excel Workbook structural validation failed due to previous errors");
		}
		return sheetAsPerConfig;
	}
	
	private ArrayList<String> createSheetIndex(DMTMigrationParams params) {
		ArrayList<String> list = new ArrayList<String>();
		if(params.isMIGRATE_CENTER())
			list.add("Center");
		if(params.isMIGRATE_INDIVIDUAL_CLIENTS()) {
			list.add("IndividualClient");
			list.add("IndividualClientMeetings");
		}
		if(params.isMIGRATE_GROUP_LOANS())
			list.add("GroupLoans");
		if(params.isMIGRATE_CUSTOM_FEILDS()) {
			list.add("Center-QuestionGroups");
			list.add("Groups-QuestionGroups");
			list.add("Clients-QuestionGroups");
			list.add("Loans-QuestionGroups");
		}
		if(params.isMIGRATE_FEES())
			list.add("Fees");
			list.add("Group");
			list.add("Customer-Meeting");
			list.add("Client");
			list.add("Client-Family");
			list.add("Loan");
			list.add("Savings");
			return list;
	}

}
