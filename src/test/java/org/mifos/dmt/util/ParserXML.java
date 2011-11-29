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
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
 
public class ParserXML
{      
	  //method to parse the XML file and store the data in an object
    	public static DMTXMLHandler populateObject(String xml) throws ParserConfigurationException, SAXException
    	 {
    		SAXParserFactory factory = SAXParserFactory.newInstance();
   	      	SAXParser saxParser = factory.newSAXParser();

   	      	DMTXMLHandler handler = new DMTXMLHandler();
    	      try {
    	       
 
    	      File file = new File(xml);
    	      InputStream inputStream= new FileInputStream(file);
    	      Reader reader = new InputStreamReader(inputStream,"UTF-8");
 
    	      InputSource is = new InputSource(reader);
    	      is.setEncoding("UTF-8");
 
    	      saxParser.parse(is, handler);
    	
    	    } catch (Exception e) {
    	      e.printStackTrace();
    	    }
			return handler;
           	    
    	 } // end of method
 
    } //end of main
