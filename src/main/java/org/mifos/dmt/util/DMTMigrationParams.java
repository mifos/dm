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

package org.mifos.dmt.util;

import org.mifos.dmt.configuration.DMTMigrationConfigurations;

public class DMTMigrationParams {

	private boolean MIGRATE_CENTER;
	private boolean MIGRATE_INDIVIDUAL_CLIENTS;
	private boolean MIGRATE_GROUP_LOANS;
	private boolean MIGRATE_CUSTOM_FEILDS;
	private boolean MIGRATE_FEES;
	
	public DMTMigrationParams() {
		this.MIGRATE_CENTER = DMTMigrationConfigurations.MIGRATE_CENTER;
		this.MIGRATE_INDIVIDUAL_CLIENTS = DMTMigrationConfigurations.MIGRATE_INDIVIDUAL_CLIENTS;
		this.MIGRATE_GROUP_LOANS = DMTMigrationConfigurations.MIGRATE_GROUP_LOANS;
		this.MIGRATE_CUSTOM_FEILDS = DMTMigrationConfigurations.MIGRATE_CUSTOM_FEILDS;
		this.MIGRATE_FEES = DMTMigrationConfigurations.MIGRATE_FEES;
	}
	
	public DMTMigrationParams(boolean center, boolean individualClients, boolean groupLoans, boolean customFeilds, boolean fees) {
		this.MIGRATE_CENTER = center;
		this.MIGRATE_INDIVIDUAL_CLIENTS = individualClients;
		this.MIGRATE_GROUP_LOANS = groupLoans;
		this.MIGRATE_CUSTOM_FEILDS = customFeilds;
		this.MIGRATE_FEES = fees;
	}

	public boolean isMIGRATE_CENTER() {
		return MIGRATE_CENTER;
	}

	public boolean isMIGRATE_INDIVIDUAL_CLIENTS() {
		return MIGRATE_INDIVIDUAL_CLIENTS;
	}

	public boolean isMIGRATE_GROUP_LOANS() {
		return MIGRATE_GROUP_LOANS;
	}

	public boolean isMIGRATE_CUSTOM_FEILDS() {
		return MIGRATE_CUSTOM_FEILDS;
	}

	public boolean isMIGRATE_FEES() {
		return MIGRATE_FEES;
	}

	
}
