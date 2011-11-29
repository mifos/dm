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

import java.util.ArrayList;

public class DMTSet implements Cloneable {

	Configuration config;
	InputData inputData;
	ArrayList<Installment> emi;
	
	public DMTSet() {
		config = new Configuration();
		inputData = new InputData();
		emi = new ArrayList<Installment>();
	}
	
	
	
	public Configuration getConfig() {
		return config;
	}



	public void setConfig(Configuration config) {
		this.config = config;
	}



	public InputData getInputData() {
		return inputData;
	}



	public void setInputData(InputData inputData) {
		this.inputData = inputData;
	}



	public ArrayList<Installment> getEmi() {
		return emi;
	}



	public void setEmi(ArrayList<Installment> emi) {
		this.emi = emi;
	}



	public DMTSet clone() throws CloneNotSupportedException {
		return (DMTSet) super.clone();
		
	}
}
