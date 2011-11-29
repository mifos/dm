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
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.joda.time.DateTime;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class DMTXMLHandler extends DefaultHandler {

	public ArrayList<DMTSet> schedule;
	//public ArrayList<Configuration> configurationElements;
	
	Installment _installmentNode;
	ArrayList<Installment> emiNode;
	InputData inputDataNode;
	DMTSet setNode;
	Configuration configNode;

	public DMTXMLHandler() {
		_installmentNode = new Installment();
		emiNode = new ArrayList<Installment>();
		inputDataNode = new InputData();
		setNode = new DMTSet();
		schedule = new ArrayList<DMTSet>();
		
		//configurationElements = new ArrayList<Configuration>();
		configNode = new Configuration();
	}

	static boolean configData = false;
	static boolean set = false;
	static boolean inputData = false;
	static boolean emi = false;
	static boolean installment = false;
	
	static boolean initialRoundingMode = false;
	static boolean finalRoundingMode = false;
	static boolean initialRoundOffMultiple = false;
	static boolean finalRoundOffMultiple = false;
	static boolean digitsAfterDecimal = false;
	static boolean digitsAfterDecimalInterest = false;

	static boolean account = false;
	static boolean customer = false;
	static boolean currency = false;
	static boolean createdDate = false;
	static boolean disbursementDate = false;
	static boolean recurrenceId = false;
	static boolean interestType = false;
	static boolean recurAfter = false;
	static boolean days = false;
	static boolean rankOfDays = false;
	static boolean dayNumber = false;
	static boolean loanAmount = false;
	static boolean amountPaid = false;
	static boolean interestRate = false;
	static boolean numberOfInstallments = false;
	static boolean loanDuration = false;
	static boolean lengthOfPeriod = false;

	static boolean id = false;
	static boolean actionDate = false;
	static boolean principal = false;
	static boolean interest = false;
	static boolean principalPaid = false;
	static boolean interestPaid = false;
	static boolean paymentStatus = false;
	static boolean paymentDate = false;

	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes attributes) throws SAXException {
		
		if (qName.equalsIgnoreCase("Set"))
			set = true;
		if (qName.equalsIgnoreCase("configData"))
			configData = true;
		if (qName.equalsIgnoreCase("InputData")) 
			inputData = true;
		if (qName.equalsIgnoreCase("EMI")) 
			emi = true;
		if (qName.equalsIgnoreCase("InitialRoundingMode"))
			initialRoundingMode = true;
		if (qName.equalsIgnoreCase("FinalRoundingMOde"))
			finalRoundingMode = true;
		if (qName.equalsIgnoreCase("InitialRoundOffMultiple"))
			initialRoundOffMultiple = true;
		if (qName.equalsIgnoreCase("FinalRoundOffMultiple"))
			finalRoundOffMultiple = true;
		if (qName.equalsIgnoreCase("DigitsAfterDecimal"))
			digitsAfterDecimal = true;
		if (qName.equalsIgnoreCase("DigitsAfterDecimalInterest"))
			digitsAfterDecimalInterest = true;
		if (qName.equalsIgnoreCase("Account"))
			account = true;
		if (qName.equalsIgnoreCase("Customer"))
			customer = true;
		if (qName.equalsIgnoreCase("Currency"))
			currency = true;
		if (qName.equalsIgnoreCase("CreatedDate"))
			createdDate = true;
		if (qName.equalsIgnoreCase("DisbursementDate"))
			disbursementDate = true;
		if (qName.equalsIgnoreCase("RecurrenceID"))
			recurrenceId = true;
		if (qName.equalsIgnoreCase("InterestType"))
			interestType = true;
		if (qName.equalsIgnoreCase("RecurAfter"))
			recurAfter = true;
		if (qName.equalsIgnoreCase("Days"))
			days = true;
		if (qName.equalsIgnoreCase("rankofDays"))
			rankOfDays = true;
		if (qName.equalsIgnoreCase("daynumber"))
			dayNumber = true;
		if (qName.equalsIgnoreCase("LoanAmount"))
			loanAmount = true;
		if (qName.equalsIgnoreCase("AmountPaid"))
			amountPaid = true;
		if (qName.equalsIgnoreCase("InterestRate"))
			interestRate = true;
		if (qName.equalsIgnoreCase("numberofinstallments"))
			numberOfInstallments = true;
		if (qName.equalsIgnoreCase("LoanDuration"))
			loanDuration = true;
		if  (qName.equalsIgnoreCase("lengthOfPeriod"))
			lengthOfPeriod = true;
		if (qName.equalsIgnoreCase("Installment"))
			installment = true;
		if (qName.equalsIgnoreCase("ID"))
			id = true;
		if (qName.equalsIgnoreCase("ActionDate"))
			actionDate = true;
		if (qName.equalsIgnoreCase("Principal"))
			principal = true;
		if (qName.equalsIgnoreCase("Interest"))
			interest = true;
		if (qName.equalsIgnoreCase("PrincipalPaid"))
			principalPaid = true;
		if (qName.equalsIgnoreCase("InterestPaid"))
			interestPaid = true;
		if (qName.equalsIgnoreCase("PaymentStatus"))
			paymentStatus = true;
		if (qName.equalsIgnoreCase("PaymentDate"))
			paymentDate = true;
	}

	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		
		if (qName.equalsIgnoreCase("Set")) {
			set = false;
			addSetToSchedule(setNode);
		}
		if (qName.equalsIgnoreCase("configData")) {
			configData = false;
			addConfigToSet(configNode);
		}
		if (qName.equalsIgnoreCase("InputData")) {
			inputData = false;
			addInputToSet(inputDataNode);
		}
		if (qName.equalsIgnoreCase("Installment")) {
			installment = false;
			addInstallmentToEmi(_installmentNode);
			_installmentNode = new Installment();
		}
		if (qName.equalsIgnoreCase("EMI")) {
			emi = false;
			addEmiToSet(emiNode);
		}
		if (qName.equalsIgnoreCase("InitialRoundingMode"))
			initialRoundingMode = false;
		if (qName.equalsIgnoreCase("FinalRoundingMOde"))
			finalRoundingMode = false;
		if (qName.equalsIgnoreCase("InitialRoundOffMultiple"))
			initialRoundOffMultiple = false;
		if (qName.equalsIgnoreCase("FinalRoundOffMultiple"))
			finalRoundOffMultiple = false;
		if (qName.equalsIgnoreCase("DigitsAfterDecimal"))
			digitsAfterDecimal = false;
		if (qName.equalsIgnoreCase("DigitsAfterDecimalInterest"))
			digitsAfterDecimalInterest = false;
		if (qName.equalsIgnoreCase("Account"))
			account = false;
		if (qName.equalsIgnoreCase("Customer"))
			customer = false;
		if (qName.equalsIgnoreCase("Currency"))
			currency = false;
		if (qName.equalsIgnoreCase("CreatedDate"))
			createdDate = false;
		if (qName.equalsIgnoreCase("DisbursementDate"))
			disbursementDate = false;
		if (qName.equalsIgnoreCase("RecurrenceID"))
			recurrenceId = false;
		if (qName.equalsIgnoreCase("InterestType"))
			interestType = false;
		if (qName.equalsIgnoreCase("RecurAfter"))
			recurAfter = false;
		if (qName.equalsIgnoreCase("Days"))
			days = false;
		if (qName.equalsIgnoreCase("rankofDays"))
			rankOfDays = false;
		if (qName.equalsIgnoreCase("daynumber"))
			dayNumber = false;
		if (qName.equalsIgnoreCase("LoanAmount"))
			loanAmount = false;
		if (qName.equalsIgnoreCase("AmountPaid"))
			amountPaid = false;
		if (qName.equalsIgnoreCase("InterestRate"))
			interestRate = false;
		if (qName.equalsIgnoreCase("numberofinstallments"))
			numberOfInstallments = false;
		if (qName.equalsIgnoreCase("LoanDuration"))
			loanDuration = false;
		if  (qName.equalsIgnoreCase("lengthOfPeriod"))
			lengthOfPeriod = false;
		if (qName.equalsIgnoreCase("ID"))
			id = false;
		if (qName.equalsIgnoreCase("ActionDate"))
			actionDate = false;
		if (qName.equalsIgnoreCase("Principal"))
			principal = false;
		if (qName.equalsIgnoreCase("Interest"))
			interest = false;
		if (qName.equalsIgnoreCase("PrincipalPaid"))
			principalPaid = false;
		if (qName.equalsIgnoreCase("InterestPaid"))
			interestPaid = false;
		if (qName.equalsIgnoreCase("PaymentStatus"))
			paymentStatus = false;
		if (qName.equalsIgnoreCase("PaymentDate"))
			paymentDate = false;

	}


	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {
		 
		String val = new String(ch, start, length);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
		
		if (configData) {
			if (initialRoundingMode) {
				configNode.setInitialRoundingMode(RoundingMode.valueOf(val));
			} else if (finalRoundingMode) {
				configNode.setFinalRoundingMode(RoundingMode.valueOf(val));
			} else if (initialRoundOffMultiple) {
				configNode.setInitialRoundOffMultiple(Double.parseDouble(val));
			} else if (finalRoundOffMultiple) {
				configNode.setFinalRoundOffMultiple(Double.parseDouble(val));
			} else if (digitsAfterDecimal) {
				configNode.setDigitsAfterDecimal(Integer.parseInt(val));
			} else if (digitsAfterDecimalInterest) {
				configNode.setDigitsAfterDecimalForInterest(Integer
						.parseInt(val));
			}
		} else if (inputData) {
			if(account) {
				inputDataNode.setAccount(Integer.parseInt(val));
			} else if(customer) {
				inputDataNode.setCustomer(Integer.parseInt(val));
			} else if(currency) {
				inputDataNode.setCurrency(Integer.parseInt(val));
			} else if(createdDate) {
				try {
					inputDataNode.setCreatedDate(new DateTime(dateFormat.parse(val)));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else if(disbursementDate) {
				try {
					inputDataNode.setDiscursementDate(new DateTime(dateFormat.parse(val)));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else if(recurrenceId) {
				inputDataNode.setRecurrenceId(Integer.parseInt(val));
			} else if(interestType) {
				inputDataNode.setInterestType(Integer.parseInt(val));
			} else if(recurAfter) {
				inputDataNode.setRecurAfter(Integer.parseInt(val));
			} else if(days) {
				inputDataNode.setDays(Integer.parseInt(val));
			} else if(rankOfDays) {
				inputDataNode.setRankOfDays(Integer.parseInt(val));
			} else if(dayNumber) {
				inputDataNode.setDayNumber(Integer.parseInt(val));
			} else if(loanAmount) {
				inputDataNode.setLoanAmount(new BigDecimal(val));
			} else if(amountPaid) {
				inputDataNode.setAmountPaid(new BigDecimal(val));
			} else if(interestRate) {
				inputDataNode.setInterestRate(new BigDecimal(val));
			} else if(numberOfInstallments) {
				inputDataNode.setNumberOfInstallments(Integer.parseInt(val));
			} else if(loanDuration) {
				inputDataNode.setLoanDuration(new BigDecimal(val));
			}
			  else if(lengthOfPeriod) {
				inputDataNode.setLengthOfPeriod(new BigDecimal(val));
			}
		} else if (emi) {
			// handle installments here
			if (installment) {
				if (id) {
					_installmentNode.setId(Integer.parseInt(val));
				} else if (actionDate) {
					_installmentNode.setActionDate(val);
				} else if (principal) {
					_installmentNode.setPrincipal(new BigDecimal(val));
				} else if (interest) {
					_installmentNode.setInterest(new BigDecimal(val));
				} else if(principalPaid) {
					_installmentNode.setPrincipalPaid(new BigDecimal(val));
				} else if(interestPaid) {
					_installmentNode.setInterestPaid(new BigDecimal(val));
				} else if(paymentStatus) {
					_installmentNode.setPaymentStatus(Integer.parseInt(val));
				} else if(paymentDate) {
					_installmentNode.setPaymentDate(val);
				}
			}
		}
	}

	private void addConfigToSet(Configuration node) {
		try {
			Configuration copy;
			copy = node.clone();
			setNode.setConfig(copy);
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void addSetToSchedule(DMTSet node) {
		try {
			DMTSet copy;
			copy = node.clone();
			schedule.add(copy);
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	private void addInputToSet(InputData inputDataNode) {
		try {
			InputData copy;
			copy = inputDataNode.clone();
			setNode.setInputData(copy);
		}  catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void addInstallmentToEmi(Installment _installmentNode2) {
		try {
			Installment copy = (Installment) _installmentNode2.clone();
			_installmentNode2 = new Installment();
			emiNode.add(copy);
			
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	private void addEmiToSet(ArrayList<Installment> emiNode2) {
		ArrayList<Installment> copy = (ArrayList<Installment>) emiNode2.clone();
		setNode.setEmi(copy);
		emiNode2.clear();
	}

}
