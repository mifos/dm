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

package org.mifos.dmt.ui;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mifos.dmt.configuration.DMTAccountingProperties;
import org.mifos.dmt.configuration.DMTMigrationConfigurations;
import org.mifos.dmt.util.DMTLock;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@SuppressWarnings("serial")
public class DispatcherServlet extends HttpServlet {
	private Configuration cfg;
	
	@Override
	public void init() {
		cfg = new Configuration();
		cfg.setServletContextForTemplateLoading(getServletContext(), "WEB-INF/templates");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		
		DMTLock lock = DMTLock.getInstance();
		String lockStatus = ((Boolean)lock.isLocked()).toString();
		String action = "action";
		String actionRequest = (req.getParameter(action)==null) ? "info" : req.getParameter(action);
		Map<String, String> root = processActionRequest(actionRequest);
		root.put("isLocked", lockStatus);
		Template template = cfg.getTemplate("default_layout.ftl");
		resp.setContentType("text/html; charset=" + template.getEncoding());
		Writer out = resp.getWriter();
		try {
			template.process(root, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		DMTLock lock = DMTLock.getInstance();
		String lockStatus = ((Boolean)lock.isLocked()).toString();
		String action = "action";
		
		String actionRequest = (req.getParameter(action)==null) ? "info" : req.getParameter(action);
		Map<String, String> root = processActionRequest(actionRequest);
		root.put("isLocked", lockStatus);
		Template template = cfg.getTemplate("default_layout.ftl");
		resp.setContentType("text/html; charset=" + template.getEncoding());
		Writer out = resp.getWriter();
		try {
			template.process(root, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}
	
	private Map<String, String> processActionRequest(String actionRequest) {
		Map<String, String> tagsMap = new HashMap<String, String>();
		if(actionRequest.equalsIgnoreCase("info")) {
			tagsMap = processInfoRequest(tagsMap);
		} else if (actionRequest.equalsIgnoreCase("upload")) {
			tagsMap = processUploadRquest(tagsMap);
		} else if (actionRequest.equalsIgnoreCase("migrate")) {
			tagsMap = processMigrateRquest(tagsMap);
		} else if (actionRequest.equalsIgnoreCase("help")) {
			tagsMap = processHelpRquest(tagsMap);
		} else if (actionRequest.equalsIgnoreCase("download")) {
			tagsMap = processDownloadRquest(tagsMap);
		} else if (actionRequest.equalsIgnoreCase("locked")) {
			tagsMap = processLockedRquest(tagsMap);
		} 
		return tagsMap;
	}

	private Map<String, String> processLockedRquest(Map<String, String> tagsMap) {
		tagsMap.put("content", "locked_content.ftl");
		return tagsMap;
	}

	private Map<String, String> processDownloadRquest(
			Map<String, String> tagsMap) {
		tagsMap.put("content", "download_content.ftl");
		return tagsMap;
	}

	private Map<String, String> processHelpRquest(Map<String, String> tagsMap) {
		tagsMap.put("content", "help_content.ftl");
		return tagsMap;
	}

	private Map<String, String> processMigrateRquest(Map<String, String> tagsMap) {
		tagsMap.put("content", "migrate_content.ftl");
		return tagsMap;
	}

	private Map<String, String> processUploadRquest(Map<String, String> tagsMap) {
		tagsMap.put("content", "upload_content.ftl");
		return tagsMap;
	}

	private Map<String, String> processInfoRequest(Map<String, String> tagsMap) {
		tagsMap.put("content", "info_content.ftl");
		tagsMap.put("InitialRoundingMode", DMTAccountingProperties.INITIAL_ROUNDING_MODE.toString());
		tagsMap.put("FinalRoundingMode", DMTAccountingProperties.FINAL_ROUNDING_MODE.toString());
		tagsMap.put("InitialRoundOffMultiple", DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE.toString());
		tagsMap.put("FinalRoundOffMultiple", DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE.toString());
		tagsMap.put("DigitsAfterDecimal", DMTAccountingProperties.DIGITS_AFTER_DECIMAL.toString());
		tagsMap.put("DigitsAfterDecimalForInterest", DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST.toString());
		tagsMap.put("CurrencyId", DMTAccountingProperties.CURRENCY_ID.toString());


		tagsMap.put("MigrateCenter", (DMTMigrationConfigurations.MIGRATE_CENTER) ? "True" : "False");
		tagsMap.put("MigrateIndividualClient", (DMTMigrationConfigurations.MIGRATE_INDIVIDUAL_CLIENTS) ? "True" : "False");
		tagsMap.put("MigrateGroupLoans", (DMTMigrationConfigurations.MIGRATE_GROUP_LOANS)  ? "True" : "False");
		tagsMap.put("MigrateCustomFeild", (DMTMigrationConfigurations.MIGRATE_CUSTOM_FEILDS) ? "True" : "False");
		tagsMap.put("MigrateFees", (DMTMigrationConfigurations.MIGRATE_FEES) ? "True" : "False");
		
		return tagsMap;
	}

}
