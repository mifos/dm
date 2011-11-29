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

package org.mifos.dmt;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.mifos.dmt.util.JndiConfig;

public class Boot extends HttpServlet {
	
	private static final long serialVersionUID = 7126452829453748610L;

	/*
	 * Boot servlet initializes 
	 * 1.	JNDI 
	 * 
	 */
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		bootUpDmt();
		
	}

	public void bootUpDmt() {
		//JNDI Boot up
		JndiConfig.SetSysParams();
	}
	
	@Override
	public void destroy() {
		JndiConfig.unSetSysParams();
	}
}