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

import java.math.RoundingMode;

public class Configuration implements Cloneable {

	public RoundingMode initialRoundingMode;
	public RoundingMode finalRoundingMode;
	public Double initialRoundOffMultiple;
	public Double finalRoundOffMultiple;
	public Integer  digitsAfterDecimal;
	public Integer  digitsAfterDecimalForInterest;
	
	
	public RoundingMode getInitialRoundingMode() {
		return initialRoundingMode;
	}
	public void setInitialRoundingMode(RoundingMode initialRoundingMode) {
		this.initialRoundingMode = initialRoundingMode;
	}
	public RoundingMode getFinalRoundingMode() {
		return finalRoundingMode;
	}
	public void setFinalRoundingMode(RoundingMode finalRoundingMode) {
		this.finalRoundingMode = finalRoundingMode;
	}
	public Double getInitialRoundOffMultiple() {
		return initialRoundOffMultiple;
	}
	public void setInitialRoundOffMultiple(Double initialRoundOffMultiple) {
		this.initialRoundOffMultiple = initialRoundOffMultiple;
	}
	public Double getFinalRoundOffMultiple() {
		return finalRoundOffMultiple;
	}
	public void setFinalRoundOffMultiple(Double finalRoundOffMultiple) {
		this.finalRoundOffMultiple = finalRoundOffMultiple;
	}
	public Integer getDigitsAfterDecimal() {
		return digitsAfterDecimal;
	}
	public void setDigitsAfterDecimal(Integer digitsAfterDecimal) {
		this.digitsAfterDecimal = digitsAfterDecimal;
	}
	public Integer getDigitsAfterDecimalForInterest() {
		return digitsAfterDecimalForInterest;
	}
	public void setDigitsAfterDecimalForInterest(
			Integer digitsAfterDecimalForInterest) {
		this.digitsAfterDecimalForInterest = digitsAfterDecimalForInterest;
	}
	
	public Configuration clone() throws CloneNotSupportedException {
		return (Configuration) super.clone();
	}
	
}
