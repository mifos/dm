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

import java.sql.Connection;
import java.sql.SQLException;

import org.mifos.dmt.configuration.DMTAccountingProperties;
import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.util.DBConnection;
import org.mifos.dmt.util.DMTException;

public class DMTParamInjection extends Task {

	private Connection con;
	private java.sql.Statement stmt;
	private int currencyId;

	public DMTParamInjection() {
		super();
		currencyId = DMTAccountingProperties.CURRENCY_ID;
		try {
			con = DBConnection.getConnection(DMTDatabaseConfigurations.STAGING_1);
			stmt = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean execute() throws DMTException {
		String query = "create table dmt_parameters (param_name varchar(100) NOT NULL, param_value varchar(100))";
		try {
			stmt.execute("DROP TABLE IF EXISTS dmt_parameters");
			stmt.execute(query);
			stmt.execute("insert into dmt_parameters values ('currency_id','"+currencyId+"')");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public String getMessage() {
		return "Initialising DMT properties";
	}

}
