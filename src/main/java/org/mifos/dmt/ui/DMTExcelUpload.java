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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.excel.cleanup.PurgeEmptyRows;
import org.mifos.dmt.excel.columnValidator.ColumnStructure;
import org.mifos.dmt.excel.workbookValidator.SheetStructure;
import org.mifos.dmt.logging.DMTLogStore;
import org.mifos.dmt.logging.DMTLogger;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.util.DMTLock;
 
 
@SuppressWarnings("serial")
public class DMTExcelUpload extends HttpServlet {
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DMTExcelUpload.class.getName());
	private static final String TMP_DIR_PATH = DMTConfig.DMT_CONFIG_DIR + "\\temp";
	private File tmpDir;
	private static final String DESTINATION_DIR_PATH = DMTConfig.DMT_CONFIG_DIR + "\\ExcelMappings";
	private File destinationDir;
 
	@SuppressWarnings("rawtypes")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		DMTLock migrationLock = DMTLock.getInstance();
		if(!migrationLock.isLocked()) {
			migrationLock.getLock();

			clearLogs();
			response.setContentType("text/plain");
			

			DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
			fileItemFactory.setSizeThreshold(5 * 1024 * 1024);
			fileItemFactory.setRepository(tmpDir);
			ServletFileUpload uploadHandler = new ServletFileUpload(
					fileItemFactory);
			
			try {
				List items = uploadHandler.parseRequest(request);
				Iterator itr = items.iterator();
				while (itr.hasNext()) {
					FileItem item = (FileItem) itr.next();
					
						File file = new File(destinationDir,
								"MigrationTemplate.xlsx");
						/*System.out.println("i got here " + destinationDir.toString());*/
						Workbook workbook = WorkbookFactory.create(item.getInputStream());
					
						SheetStructure sheetStructure = new SheetStructure(workbook);
						if(!sheetStructure.processWorkbook()) {
							logger.error("Excel upload failed!!Please check if necessary sheets are present in the excel");
							throw new DMTException("Excel upload failed!!Please check if necessary sheets are present in the excel");	
						}
						
						
						String baseTemplate = DMTConfig.DMT_CONFIG_DIR+"\\DMTMigrationTemplateBase.xlsx";
						ColumnStructure columnstructure = new ColumnStructure(workbook, baseTemplate);
						workbook = columnstructure.processSheetStructure();
						
						PurgeEmptyRows excessrows = new PurgeEmptyRows(workbook);
						workbook = excessrows.processEmptyRows();
						
						
						FileOutputStream fileoutputstream = new FileOutputStream(file);
						workbook.write(fileoutputstream);
					    logger.info("Uploading of Excel has been successful!!");
						migrationLock.releaseLock();
				}
			} catch (FileUploadException ex) {
				logger.error("Error encountered while parsing the request", ex);
				logger.error("Uploading of Excel has not been successful!!");
				migrationLock.releaseLock();
				ex.printStackTrace();
			} catch (Exception ex) {
				logger.error("Error encountered while uploading file", ex);
				logger.error("Uploading of Excel has not been successful!!");
				migrationLock.releaseLock();
				ex.printStackTrace();
			}

		} else {
			request.setAttribute("action", "info");
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/x");
			requestDispatcher.forward(request, response);
		}
	}
 
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		tmpDir = new File(TMP_DIR_PATH);
		if(!tmpDir.isDirectory()) {
			throw new ServletException(TMP_DIR_PATH + " is not a directory");
		}
		//String realPath = getServletContext().getRealPath(DESTINATION_DIR_PATH);
		destinationDir = new File(DESTINATION_DIR_PATH);
		if(!destinationDir.isDirectory()) {
			throw new ServletException(DESTINATION_DIR_PATH+" is not a directory");
		}
	}
	
	private void clearLogs() {
		DMTLogStore temp = DMTLogStore.getInstance();
		temp.clearLogs();

	}

}