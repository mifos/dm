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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import org.mifos.dmt.configuration.DMTDatabaseConfigurations;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DBConnection;

public class ConfigSheet {
	
private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(ConfigSheet.class.getName());
	
	HashMap<String ,ArrayList<String>> excelValues;
	Connection conn;
	Statement stmt;
	
	public ConfigSheet() {
		
		excelValues = new HashMap<String, ArrayList<String>>();
		try {
			conn = DBConnection.getConnection(DMTDatabaseConfigurations.PRODUCTION);
			stmt = conn.createStatement();
		} catch (Exception e){
			logger.error("Error creating the production connection :" + e);
		}
	}
	
	private ArrayList<String> fetchLoopUpValue(String entityName) throws SQLException {
		ArrayList<String> configFields = new ArrayList<String>();
		String query = "SELECT lv.lookup_name FROM lookup_value as lv inner join lookup_entity as le on lv.entity_id = le.entity_id where le.entity_name = '";
		query = query.concat(entityName).concat("'");
		
		ResultSet rs;
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			configFields.add(rs.getString("lv.lookup_name"));
		}
		return configFields;
	}
	private ArrayList<String> executeCustomQuery(String query) throws SQLException {
		ArrayList<String> configFields = new ArrayList<String>();
		Statement stmt = conn.createStatement();
		ResultSet rs;
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			configFields.add(rs.getString("val"));
		}
		return configFields;
	}
	
	public void fetchMaritalStatus() throws SQLException {
		excelValues.put("MaritalStatus",fetchLoopUpValue("MaritalStatus"));
	}
	public void fetchGender() throws SQLException {
		excelValues.put("gender",fetchLoopUpValue("gender"));
	}
	public void fetchPersonnelStatus() throws SQLException {
		excelValues.put("PersonnelStatus",fetchLoopUpValue("PersonnelStatus"));
	}
	public void fetchPersonnelLevels() throws SQLException {
		excelValues.put("PersonnelLevels",fetchLoopUpValue("PersonnelLevels"));
	}
	public void fetchRoles() throws SQLException {
		ArrayList<String> temp = new ArrayList<String>();
		temp.add("Admin");
		temp.add("Loan Officer");
		excelValues.put("Role", temp);
	}
	public void fetchPersonnelTitles() throws SQLException {
		excelValues.put("PersonnelTitles",fetchLoopUpValue("PersonnelTitles"));
	}
	public void fetchLocale() throws SQLException {
		ArrayList<String> temp = new ArrayList<String>();
		temp.add("EN");
		excelValues.put("Locale", temp);
	}
	public void fetchOffice() throws SQLException {
		String query = "select convert (concat(office_id,'-',display_name) using utf8) as val from office where status_id=1";
		excelValues.put("Offices" , executeCustomQuery(query));
	}
	public void fetchPersonnel() throws SQLException {
		String query = "select convert (concat(personnel_id,'-',display_name) using utf8) as val from personnel where personnel_status=1 and personnel_id > 1 and level_id=1";
		excelValues.put("Personnel", executeCustomQuery(query));
	}
	public void fetchBranch() throws SQLException {
		String query = "select convert (concat(office_id,'-',display_name) using utf8) as val from office where status_id=1 and office_level_id=5";
		excelValues.put("Branch", executeCustomQuery(query));
	}
	public void fetchSalutation() throws SQLException {
		excelValues.put("Salutation", fetchLoopUpValue("Salutation"));
	}
	public void fetchCitizenship() throws SQLException {
		excelValues.put("Citizenship", fetchLoopUpValue("Citizenship"));
	}
	public void fetchEthinicity() throws SQLException {
		excelValues.put("Ethinicity", fetchLoopUpValue("Ethinicity"));
	}
	public void fetchEducation() throws SQLException {
		excelValues.put("EducationLevel", fetchLoopUpValue("EducationLevel"));
	}
	public void fetchHandicapped() throws SQLException {
		excelValues.put("Handicapped", fetchLoopUpValue("Handicapped"));
	}
	public void fetchBusinessActivities() throws SQLException {
		excelValues.put("BusinessActivities", fetchLoopUpValue("BusinessActivities"));
	}
	public void fetchPovertyStatus() throws SQLException {
		excelValues.put("PovertyStatus", fetchLoopUpValue("PovertyStatus"));
	}
	public void fetchRelationship() throws SQLException {
		String query = "SELECT lookup_name as val FROM lookup_value where entity_id = 52";
		excelValues.put("Relationship", executeCustomQuery(query));
	}
	public void fetchCustomerStatus() throws SQLException {
		excelValues.put("CustomerStatus", fetchLoopUpValue("CustomerStatus"));
	}
	public void fetchCenterStatus() throws SQLException {
		excelValues.put("CenterStatus", fetchLoopUpValue("CenterStatus"));
	}
	public void fetchGroupStatus() throws SQLException {
		excelValues.put("GroupStatus", fetchLoopUpValue("GroupStatus"));
	}
	public void fetchClientStatus() throws SQLException {
		excelValues.put("ClientStatus", fetchLoopUpValue("ClientStatus"));
	}
	public void fetchLivingStatus() throws SQLException {
		excelValues.put("LivingStatus", fetchLoopUpValue("LivingStatus"));
	}
	public void fetchRecurrence() throws SQLException {
		String query = "SELECT description as val FROM recurrence_type";
		excelValues.put("Recurrence", executeCustomQuery(query));
	}
	public void fetchVersion() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("2");
		excelValues.put("Version", value);
	}
	public void fetchLoanProducts() throws SQLException {
		String query = "SELECT prd_offering_name as val FROM prd_offering as po  inner join prd_type as pt on po.prd_type_id = pt.prd_type_id where pt.prd_type_lookup_id = 54 and po.offering_status_id = 1";
		excelValues.put("Loan Products", executeCustomQuery(query));
	}
	public void fetchLoanAccountState() throws SQLException {
		String query = "SELECT status_description as val FROM account_state where account_state_id in (3,5,6,7,8,9)";
		excelValues.put("Loan Account State", executeCustomQuery(query));
	}
	public void fetchFund() throws SQLException {
		String query = "select fund_name as val from fund";
		excelValues.put("Fund", executeCustomQuery(query));
	}
	public void fetchLoanPurposes() throws SQLException {
		excelValues.put("LoanPurposes", fetchLoopUpValue("LoanPurposes"));
	}
	public void fetchSavingsProduct() throws SQLException {
		String query = "SELECT prd_offering_name as val FROM prd_offering as po  inner join prd_type as pt on po.prd_type_id = pt.prd_type_id where pt.prd_type_lookup_id = 55 and po.offering_status_id=2";
		excelValues.put("Savings Product", executeCustomQuery(query));
	}
	public void fetchClientType() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("Clients");
		value.add("IndividualClient");
		excelValues.put("ClientType", value);
	}
	public void fetchQGCenter() throws SQLException {
		String query = "select question_text as val from questions  inner join sections_questions on sections_questions.question_id=questions.question_id inner join sections on sections.id=sections_questions.section_id  inner join question_group_event_sources on question_group_event_sources.question_group_id=sections.question_group_id inner join event_sources on event_sources.id=question_group_event_sources.event_source_id  where event_sources.entity_type_id=20";
		excelValues.put("Center-QuestionGroups", executeCustomQuery(query));
	}
	public void fetchQGgroup() throws SQLException {
		String query = "select question_text as val from questions inner join sections_questions on sections_questions.question_id=questions.question_id inner join sections on sections.id=sections_questions.section_id inner join question_group_event_sources on question_group_event_sources.question_group_id=sections.question_group_id inner join event_sources on event_sources.id=question_group_event_sources.event_source_id where event_sources.entity_type_id=12";
		excelValues.put("Group-QuestionGroups", executeCustomQuery(query));
	}
	public void fetchQGClient() throws SQLException {
		String query = "select question_text as val from questions inner join sections_questions on sections_questions.question_id=questions.question_id inner join sections on sections.id=sections_questions.section_id inner join question_group_event_sources on question_group_event_sources.question_group_id=sections.question_group_id inner join event_sources on event_sources.id=question_group_event_sources.event_source_id where event_sources.entity_type_id=1";
		excelValues.put("Client-QuestionGroups", executeCustomQuery(query));
	}
	public void fetchQGLoan() throws SQLException {
		String query = "select question_text as val from questions inner join sections_questions on sections_questions.question_id=questions.question_id inner join sections on sections.id=sections_questions.section_id inner join question_group_event_sources on question_group_event_sources.question_group_id=sections.question_group_id inner join event_sources on event_sources.id=question_group_event_sources.event_source_id where event_sources.entity_type_id=22";
		excelValues.put("Loan-QuestionGroups", executeCustomQuery(query));
	}
	public void fetchFeeCategory() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("LoanAccountIdentifier");
		value.add("Clients");
		excelValues.put("Fee Category", value);
	}
	public void fetchFeeFrequency() throws SQLException {
		excelValues.put("FeeFrequency", fetchLoopUpValue("FeeFrequency"));
	}
	public void fetchFeePayment() throws SQLException {
		excelValues.put("FeePayment", fetchLoopUpValue("FeePayment"));
	}
	public void fetchFees() throws SQLException {
		String query = "SELECT fee_name as val FROM fees";
		excelValues.put("Fees", executeCustomQuery(query));
	}
	public void fetchGroupType() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("GroupCenter");
		value.add("GroupNoCenter");
		excelValues.put("Group Type", value);
	}
	public void fetchGroupNoCenter() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("N/A");
		excelValues.put("GroupNoCenter", value);
	}
	public void fetchCustomerType() throws SQLException {
		ArrayList<String> value = new ArrayList<String>();
		value.add("Group");
		value.add("GroupCenter");
		excelValues.put("CustomerType", value);
	}
}
