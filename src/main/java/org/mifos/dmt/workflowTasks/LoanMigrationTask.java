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
import java.util.Iterator;

import org.mifos.dmt.business.Meetings.dao.LoanDAO;
import org.mifos.dmt.business.Meetings.entity.LoanAccount;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;

public class LoanMigrationTask extends Task {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(LoanMigrationTask.class.getName());
	
	@Override
	public boolean execute() throws DMTException {
		try {
			LoanDAO loandao = new LoanDAO();
			ArrayList<MigrationParams> loanParams = loandao.fetchAllLoanParamsForMigration();
			Iterator<MigrationParams> itr = loanParams.iterator();
			while (itr.hasNext()) {
				MigrationParams loanMigrationParams = (MigrationParams) itr
						.next();
				LoanAccount loanAccount = new LoanAccount(loanMigrationParams);
				loandao.insertIntoDb(loanAccount.getLoanDetailsForCustomer());
				if(loanAccount.isFeeAttached()) {
					loanAccount.getInsertFees().insertIntoDb();
				}
			}
			return true;
		} catch (Exception e) {
			logger.error("Exception while generating loan schedule" + e.getMessage());
			throw new DMTException("Exception while generating loan schedule" + e.getMessage());
		} 
	}

	@Override
	public String getMessage() {
		return "Generating loan schedules";
	}

}
