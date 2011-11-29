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

package org.mifos.dmt.validation;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.stream.XMLStreamException;

import org.mifos.dmt.configuration.DMTConfig;
import org.mifos.dmt.logging.DMTLogger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class ParsingValidators {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(ParsingValidators.class.getName());
	
	public static Map<String,Map<String,String>> readValidators() throws FileNotFoundException,
			XMLStreamException {
				
		Map<String,Map<String,String>> mainMap = new HashMap<String,Map<String,String>>();
		Map<String,String> subMap = null; 
				
		NodeList tableNodeList = null;
		Node tableNode = null;
		Element tableElement = null;
		NodeList tableNameNodeList = null;
		Element tableNameNodeListElement = null;
		NodeList tableNameChildNodeList = null;
		
		//Mandatory Column Variables For Clients
		NodeList mandatory_colsNodeList = null;
		Element mandatory_colsElement = null;
		NodeList mandatory_colsChildNodeList = null;
		 
		//Mandatory Column Variables For Center
		NodeList Center_mandatory_colsNodeList = null; 
		Element Center_mandatory_colsElement = null;
		NodeList Center_mandatory_colsChildNodeList = null;
		
		//Mandatory Column Variables For Group
		NodeList Group_mandatory_colsNodeList = null; 
		Element Group_mandatory_colsElement = null;
		NodeList Group_mandatory_colsChildNodeList = null;
				
		//Duplicate Column Variables For Client 
		NodeList duplicate_colsNodeList = null;
		Element duplicate_colsElement = null;
		NodeList duplicate_colsChildNodeList = null;	
		
		//Duplicate Column Variables For Group 
		NodeList Group_duplicate_colsNodeList = null; 
		Element Group_duplicate_colsElement = null;
		NodeList Group_duplicate_colsChildNodeList = null;
		
		//Duplicate Column Variables For Center
		NodeList Center_duplicate_colsNodeList = null; 
		Element Center_duplicate_colsElement = null;
		NodeList Center_duplicate_colsChildNodeList = null;	
	
		try {			
			
			String fileName = DMTConfig.DMT_CONFIG_DIR + "\\validators.xml"; 
				
			File file = new File(fileName);
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document document = db.parse(file);
			document.getDocumentElement().normalize();

			 tableNodeList = document.getElementsByTagName("table");

			 String tablename = null;

			if (tableNodeList.getLength() != 0) {

				for (int i = 0; i < tableNodeList.getLength(); i++) {
					 tableNode = tableNodeList.item(i);
					 
					subMap =  new HashMap<String,String>();
					 
					if (tableNode.getNodeType() == Node.ELEMENT_NODE) {
						 tableElement = (Element) tableNode;

						 tableNameNodeList = tableElement.getElementsByTagName("tableName");
						 tableNameNodeListElement = (Element) tableNameNodeList.item(0);
						if (tableNameNodeListElement != null) {
							tableNameChildNodeList = tableNameNodeListElement.getChildNodes();
							tablename = ((Node) tableNameChildNodeList.item(0)).getNodeValue().toString().trim();							
						}/*else{
							logger.info("There is no columns in Node: tableName");
						}*/
						
						Center_mandatory_colsNodeList = tableElement.getElementsByTagName("Center_mandatory_cols");
						Center_mandatory_colsElement = (Element) Center_mandatory_colsNodeList.item(0);
						if (Center_mandatory_colsElement != null) {
							Center_mandatory_colsChildNodeList = Center_mandatory_colsElement.getChildNodes();
							if(Center_mandatory_colsChildNodeList.item(0).getNodeValue().trim().length() > 0)
							subMap.put(Center_mandatory_colsNodeList.item(0).getNodeName(), (Center_mandatory_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: Center_mandatory_cols");
						}*/
						
						Group_mandatory_colsNodeList = tableElement.getElementsByTagName("Group_mandatory_cols");
						Group_mandatory_colsElement = (Element) Group_mandatory_colsNodeList.item(0);
						if (Group_mandatory_colsElement != null) {
							Group_mandatory_colsChildNodeList = Group_mandatory_colsElement.getChildNodes();
							if(Group_mandatory_colsChildNodeList.item(0).getNodeValue().trim().length() > 0)
							 subMap.put(Group_mandatory_colsNodeList.item(0).getNodeName(), (Group_mandatory_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: Group_mandatory_cols");
						}*/
						
						Center_duplicate_colsNodeList = tableElement.getElementsByTagName("Center_duplicate_cols");
						Center_duplicate_colsElement = (Element) Center_duplicate_colsNodeList.item(0);
						if (Center_duplicate_colsElement != null) {
							Center_duplicate_colsChildNodeList = Center_duplicate_colsElement.getChildNodes();
							if(Center_duplicate_colsChildNodeList.item(0).getNodeValue().trim().length() > 0)
							 subMap.put(Center_duplicate_colsNodeList.item(0).getNodeName(), (Center_duplicate_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: Center_duplicate_cols");
						} */
						
						Group_duplicate_colsNodeList = tableElement.getElementsByTagName("Group_duplicate_cols");
						Group_duplicate_colsElement = (Element) Group_duplicate_colsNodeList.item(0);
						if (Group_duplicate_colsElement != null) {
							Group_duplicate_colsChildNodeList = Group_duplicate_colsElement.getChildNodes();
							if(Group_duplicate_colsChildNodeList.item(0).getNodeValue().trim().length() > 0)
							 subMap.put(Group_duplicate_colsNodeList.item(0).getNodeName(), (Group_duplicate_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: Group_duplicate_cols");
						}*/
						
						mandatory_colsNodeList = tableElement.getElementsByTagName("mandatory_cols");
						mandatory_colsElement = (Element) mandatory_colsNodeList.item(0);
						if (mandatory_colsElement != null) {
							mandatory_colsChildNodeList = mandatory_colsElement.getChildNodes();
							subMap.put(mandatory_colsNodeList.item(0).getNodeName(), (mandatory_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: mandatory_cols");
						}*/

						duplicate_colsNodeList = tableElement.getElementsByTagName("duplicate_cols");
						duplicate_colsElement = (Element) duplicate_colsNodeList.item(0);
						if (duplicate_colsElement != null) {
							duplicate_colsChildNodeList = duplicate_colsElement.getChildNodes();
							subMap.put(duplicate_colsNodeList.item(0).getNodeName(), (duplicate_colsChildNodeList.item(0)).getNodeValue().toString().trim());
						}/*else{
							logger.info("There is no columns in Node: duplicate_cols");
						}	*/											
						
					}// end of inner if
	
					mainMap.put(tablename, subMap);
				}// end of for
				
			}// end of outer if table node length check					    
			
		}catch(FileNotFoundException fnf){
			logger.error("The validation xml file is not found in the proper path, please make sure the file is exists in kettle folder ");
		}
		catch (Exception e) {
			logger.error("Exception in parsing method "+e);
		 }
		
		return mainMap;
		
	}// end of method
	 
}// end of class...
