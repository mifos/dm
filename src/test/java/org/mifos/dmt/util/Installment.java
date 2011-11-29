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

import java.math.BigDecimal;

public class Installment implements Cloneable {

	Integer id;
	String actionDate;
	BigDecimal principal;
	BigDecimal Interest;
	BigDecimal principalPaid;
	BigDecimal interestPaid;
	Integer paymentStatus;
	String paymentDate;
	
	

	public Integer getId() {
		return id;
	}




	public void setId(Integer id) {
		this.id = id;
	}




	public String getActionDate() {
		return actionDate;
	}




	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}




	public BigDecimal getPrincipal() {
		return principal;
	}




	public void setPrincipal(BigDecimal principal) {
		this.principal = principal;
	}




	public BigDecimal getInterest() {
		return Interest;
	}




	public void setInterest(BigDecimal interest) {
		Interest = interest;
	}




	public BigDecimal getPrincipalPaid() {
		return principalPaid;
	}




	public void setPrincipalPaid(BigDecimal principalPaid) {
		this.principalPaid = principalPaid;
	}




	public BigDecimal getInterestPaid() {
		return interestPaid;
	}




	public void setInterestPaid(BigDecimal interestPaid) {
		this.interestPaid = interestPaid;
	}




	public Integer getPaymentStatus() {
		return paymentStatus;
	}




	public void setPaymentStatus(Integer paymentStatus) {
		this.paymentStatus = paymentStatus;
	}




	public String getPaymentDate() {
		return paymentDate;
	}




	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}




	public Installment clone() throws CloneNotSupportedException {
		return (Installment) super.clone();
	}
	
	
}
