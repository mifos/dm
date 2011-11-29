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

import java.io.OutputStream;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.excel.CreateExcel;
import org.mifos.dmt.logging.DMTLogStore;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTMigrationParams;

@SuppressWarnings("serial")
public class GenerateExcel extends HttpServlet {

	private static final DMTLogger logger = (DMTLogger) DMTLogger
			.getLogger(GenerateExcel.class.getName());

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		try {
			DMTLogStore logstore = DMTLogStore.getInstance();
			logstore.clearLogs();
			response.setContentType("application/xlsx");
			response.setHeader("Content-Disposition",
					"attachment; filename=\"MigrationTemplate.xlsx\"");
			OutputStream os = response.getOutputStream();
			CreateExcel excel = new CreateExcel();
			Workbook workBook = null;
			String baseTemplate = DMTConfig.DMT_CONFIG_DIR+"\\DMTMigrationTemplateBase.xlsx";
			DMTMigrationParams dmtParams = new DMTMigrationParams();
			workBook = excel.generate(baseTemplate, dmtParams);
			workBook.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			logger.error("Error while generating excel sheet " +e.getMessage());
		}
	}
}
