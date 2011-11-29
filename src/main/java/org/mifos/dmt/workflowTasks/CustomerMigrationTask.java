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
import java.util.HashMap;
import java.util.Iterator;

import org.mifos.dmt.business.Meetings.dao.CustomerDAO;
import org.mifos.dmt.business.Meetings.dao.CustomerFeesDAO;
import org.mifos.dmt.business.Meetings.dao.FeesLookUp;
import org.mifos.dmt.business.Meetings.entity.CustomerAccount;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;

public class CustomerMigrationTask extends Task {
	
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(CustomerMigrationTask.class.getName());
	
	public boolean execute() throws DMTException {
		CustomerDAO custdao = new CustomerDAO();
		try {
			ArrayList<MigrationParams> custparams = custdao.fetchAllCustomerParamsForMigration();
			Iterator<MigrationParams> itr = custparams.iterator();
			while (itr.hasNext()) {
				MigrationParams custMigrationParams = (MigrationParams) itr
						.next();
				CustomerAccount cust = new CustomerAccount(custMigrationParams);
				custdao.insertIntoDb(cust.getLoanDetailsForCustomer());
				processCustomerFees(custMigrationParams);
			}
			return true;
		} catch (Exception e) {
			logger.error("Exception while generating customer schedule" + e.getMessage());
			throw new DMTException("Exception while generating customer schedule" + e.getMessage());
		} 
	}
	
	private void processCustomerFees(MigrationParams custParams) throws DMTException {
		FeesLookUp feesLookup = new FeesLookUp(custParams.getAccount_id());
		ArrayList<HashMap<String, Object>> custFeeParams = feesLookup.getCustomerFeeDetails();
		CustomerFeesDAO custFeeDAO = new CustomerFeesDAO(custParams, custFeeParams);
		
		if(feesLookup.isCustomerFeeAttached()) {
			custFeeDAO.insertIntoDb();
		}	
	}
	
	@Override
	public String getMessage() {
		return "Generating customer schedules";
	}
}
