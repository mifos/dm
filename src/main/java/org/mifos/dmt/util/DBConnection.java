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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;

import org.mifos.dmt.logging.DMTLogger;

public class DBConnection {

	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(DBConnection.class
			.getName());
	
	private DBConnection()
	{
		
	}
	
	private static HashMap<Integer, Connection> connectionPool = new HashMap<Integer, Connection>();
	

	public static Connection getConnection(HashMap<String,String> dbMapping) {
		Connection con = null;
		String url = "jdbc:mysql://"+ dbMapping.get("host") + ":"+dbMapping.get("port")+"/"+ dbMapping.get("schema")+"?useUnicode=true&characterEncoding=utf8";
		String user =  dbMapping.get("user"); 
		String pass = dbMapping.get("password");
		if(connectionPool.containsKey(url.hashCode())) {
			con = connectionPool.get(url.hashCode());
		} else {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url,user,pass);
				connectionPool.put(url.hashCode(), con);
			} catch (SQLException se) {
				logger.error("SQLException in creating DBConnection ", se);
			} catch (ClassNotFoundException cnfe) {
				logger.error("ClassNotFoundException in creating DBConnection ",
						cnfe);
			} catch (Exception cnfe) {
				logger.error("Exception in creating DBConnection ", cnfe);
			}
		}
		return con;
	}
	
	public DBConnection clone() throws CloneNotSupportedException {
     throw new CloneNotSupportedException();
	}
}
