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

package org.mifos.dmt.business.Meetings.schedule;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.ListIterator;

import org.joda.time.DateTime;
import org.mifos.dmt.business.Meetings.MeetingsSuiteData;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;
import org.mifos.dmt.configuration.DMTAccountingProperties;
import org.mifos.dmt.util.Configuration;
import org.mifos.dmt.util.DMTSet;
import org.mifos.dmt.util.DMTXMLHandler;
import org.mifos.dmt.util.InputData;
import org.mifos.dmt.util.Installment;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.AfterTest;

public class WeeklyScheduleTest {
	
	MigrationParams inputParams;
	public ArrayList<String> scheduleList;
	Installment _installmentNode;
	ArrayList<Installment> emiNode;
	InputData inputDataNode;
	DMTSet setNode;
	Configuration configNode;
	Integer account;
	Integer customer;
	Integer currency;
	DateTime createdDate;
	DateTime discursementDate;
	Integer recurrenceId;
	Integer interestType;
	Integer recurAfter;
	Integer days;
	Integer rankOfDays;
	Integer dayNumber;
	BigDecimal loanAmount;
	BigDecimal amountPaid;
	BigDecimal interestRate;
	Integer numberOfInstallments;
	BigDecimal loanDuration;
	BigDecimal lengthOfPeriod;
	RoundingMode initialRoundingMode;
	RoundingMode finalRoundingMode;
	Double initialRoundOffMultiple;
	Double finalRoundOffMultiple;
	Integer  digitsAfterDecimal;
	Integer  digitsAfterDecimalForInterest;
	RoundingMode originalInitialRoundingMode;
	RoundingMode originalFinalRoundingMode;
	Double originalInitialRoundOffMultiple;
	Double originalFinalRoundOffMultiple;
	Integer  originalDigitsAfterDecimal;
	Integer  originalDigitsAfterDecimalForInterest;
	Integer id;
	String actionDate;
	BigDecimal principal;
	BigDecimal Interest;
	BigDecimal principalPaid;
	BigDecimal interestPaid;
	Integer paymentStatus;
	String paymentDate;
	
  @BeforeTest
  public void beforeTest() {
  }

  @AfterTest
  public void afterTest() {
  }


  @Test(groups={"method1", "method2"})
  public void generateSchedule() {
	  
	  DMTXMLHandler handler=MeetingsSuiteData.xmlHandler;
	  ArrayList<DMTSet> schedule=handler.schedule;
	  ListIterator<DMTSet> itr=schedule.listIterator();
	 
	  while (itr.hasNext()) {
		 
		DMTSet dmtSet = (DMTSet) itr.next();
		
		//Configuration Data for the test data
		initialRoundingMode=dmtSet.getConfig().getInitialRoundingMode();
		finalRoundingMode=dmtSet.getConfig().getFinalRoundingMode();
		initialRoundOffMultiple=dmtSet.getConfig().getInitialRoundOffMultiple();
		finalRoundOffMultiple=dmtSet.getConfig().getFinalRoundOffMultiple();
		digitsAfterDecimal=dmtSet.getConfig().getDigitsAfterDecimal();
		digitsAfterDecimalForInterest=dmtSet.getConfig().getDigitsAfterDecimalForInterest();
		
		//overriding the existing configuration values with test configuration
		DMTAccountingProperties.INITIAL_ROUNDING_MODE=initialRoundingMode;
		DMTAccountingProperties.FINAL_ROUNDING_MODE=finalRoundingMode;
		DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE=initialRoundOffMultiple;
		DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE=finalRoundOffMultiple;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL=digitsAfterDecimal;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST=digitsAfterDecimalForInterest;
		
		//input parameters for the test data
		account=dmtSet.getInputData().getAccount();
		customer=dmtSet.getInputData().getCustomer();
		currency=dmtSet.getInputData().getCurrency();
		createdDate=dmtSet.getInputData().getCreatedDate();
		discursementDate=dmtSet.getInputData().getDiscursementDate();
		recurrenceId=dmtSet.getInputData().getRecurrenceId();
		interestType=dmtSet.getInputData().getInterestType();
		recurAfter=dmtSet.getInputData().getRecurAfter();
		days=dmtSet.getInputData().getDays();
		rankOfDays=dmtSet.getInputData().getRankOfDays();
		dayNumber=dmtSet.getInputData().getDayNumber();
		loanAmount=dmtSet.getInputData().getLoanAmount();
		amountPaid=dmtSet.getInputData().getAmountPaid();
		interestRate=dmtSet.getInputData().getInterestRate();
		numberOfInstallments=dmtSet.getInputData().getNumberOfInstallments();
		loanDuration=dmtSet.getInputData().getLoanDuration();
		lengthOfPeriod=dmtSet.getInputData().getLengthOfPeriod();
		
		//calling of the Weekly Schedule generation method
		emiNode=dmtSet.getEmi();
		inputParams=new MigrationParams(account, customer, currency,createdDate,discursementDate, recurrenceId ,interestType, recurAfter, days, rankOfDays, dayNumber, loanAmount, amountPaid, interestRate,numberOfInstallments);
		WeeklySchedule weeklySchedule =  new WeeklySchedule(inputParams);
		weeklySchedule.generateSchedule(numberOfInstallments);
		scheduleList=weeklySchedule.scheduleList;
		
		//storing the expected output
		ListIterator<Installment> emiSet=emiNode.listIterator();
	    
	    while (emiSet.hasNext()) {
	    	
	    	int no=emiSet.nextIndex();
			Installment installments = (Installment) emiSet.next();
			id=installments.getId();
			actionDate=installments.getActionDate();
			
		   
			//calling the assert to check the expected and actual principal values of installment.
			Assert.assertTrue(scheduleList.get(no).equals(actionDate));
			
		}
		
	  }    
  }

  @Test(groups={"method1","method2"})
  public void getLengthOfPeriod() {
	  

	  DMTXMLHandler handler=MeetingsSuiteData.xmlHandler;
	  ArrayList<DMTSet> schedule=handler.schedule;
	  ListIterator<DMTSet> itr=schedule.listIterator();
	  BigDecimal lengthOfPeriodActual;
	 
	  while (itr.hasNext()) {
		 
		DMTSet dmtSet = (DMTSet) itr.next();
		
		//Configuration Data for the test data
		initialRoundingMode=dmtSet.getConfig().getInitialRoundingMode();
		finalRoundingMode=dmtSet.getConfig().getFinalRoundingMode();
		initialRoundOffMultiple=dmtSet.getConfig().getInitialRoundOffMultiple();
		finalRoundOffMultiple=dmtSet.getConfig().getFinalRoundOffMultiple();
		digitsAfterDecimal=dmtSet.getConfig().getDigitsAfterDecimal();
		digitsAfterDecimalForInterest=dmtSet.getConfig().getDigitsAfterDecimalForInterest();
		
		//overriding the existing configuration values with test configuration
		DMTAccountingProperties.INITIAL_ROUNDING_MODE=initialRoundingMode;
		DMTAccountingProperties.FINAL_ROUNDING_MODE=finalRoundingMode;
		DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE=initialRoundOffMultiple;
		DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE=finalRoundOffMultiple;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL=digitsAfterDecimal;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST=digitsAfterDecimalForInterest;
		
		//input parameters for the test data
		account=dmtSet.getInputData().getAccount();
		customer=dmtSet.getInputData().getCustomer();
		currency=dmtSet.getInputData().getCurrency();
		createdDate=dmtSet.getInputData().getCreatedDate();
		discursementDate=dmtSet.getInputData().getDiscursementDate();
		recurrenceId=dmtSet.getInputData().getRecurrenceId();
		interestType=dmtSet.getInputData().getInterestType();
		recurAfter=dmtSet.getInputData().getRecurAfter();
		days=dmtSet.getInputData().getDays();
		rankOfDays=dmtSet.getInputData().getRankOfDays();
		dayNumber=dmtSet.getInputData().getDayNumber();
		loanAmount=dmtSet.getInputData().getLoanAmount();
		amountPaid=dmtSet.getInputData().getAmountPaid();
		interestRate=dmtSet.getInputData().getInterestRate();
		numberOfInstallments=dmtSet.getInputData().getNumberOfInstallments();
		loanDuration=dmtSet.getInputData().getLoanDuration();
		lengthOfPeriod=dmtSet.getInputData().getLengthOfPeriod();
		
		//calling of the Weekly Schedule generation method
		emiNode=dmtSet.getEmi();
		inputParams=new MigrationParams(account, customer, currency,createdDate,discursementDate, recurrenceId ,interestType, recurAfter, days, rankOfDays, dayNumber, loanAmount, amountPaid, interestRate,numberOfInstallments);
		WeeklySchedule weeklySchedule =  new WeeklySchedule(inputParams);
		lengthOfPeriodActual=weeklySchedule.getLengthOfPeriod();
			
		   
			//calling the assert to check the expected and actual lengthofperiodvalues
			Assert.assertTrue(lengthOfPeriod.equals(lengthOfPeriodActual));
			
   }
}

  @Test(groups={"method1","method2"})
  public void getLoanDuration() {
   
	  DMTXMLHandler handler=MeetingsSuiteData.xmlHandler;
	  ArrayList<DMTSet> schedule=handler.schedule;
	  ListIterator<DMTSet> itr=schedule.listIterator();
	  BigDecimal loanDurationActual;
	 
	  while (itr.hasNext()) {
		 
		DMTSet dmtSet = (DMTSet) itr.next();
		
		//Configuration Data for the test data
		initialRoundingMode=dmtSet.getConfig().getInitialRoundingMode();
		finalRoundingMode=dmtSet.getConfig().getFinalRoundingMode();
		initialRoundOffMultiple=dmtSet.getConfig().getInitialRoundOffMultiple();
		finalRoundOffMultiple=dmtSet.getConfig().getFinalRoundOffMultiple();
		digitsAfterDecimal=dmtSet.getConfig().getDigitsAfterDecimal();
		digitsAfterDecimalForInterest=dmtSet.getConfig().getDigitsAfterDecimalForInterest();
		
		//overriding the existing configuration values with test configuration
		DMTAccountingProperties.INITIAL_ROUNDING_MODE=initialRoundingMode;
		DMTAccountingProperties.FINAL_ROUNDING_MODE=finalRoundingMode;
		DMTAccountingProperties.INITIAL_ROUNDOFF_MULTIPLE=initialRoundOffMultiple;
		DMTAccountingProperties.FINAL_ROUNDOFF_MULTIPLE=finalRoundOffMultiple;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL=digitsAfterDecimal;
		DMTAccountingProperties.DIGITS_AFTER_DECIMAL_FOR_INTEREST=digitsAfterDecimalForInterest;
		
		//input parameters for the test data
		account=dmtSet.getInputData().getAccount();
		customer=dmtSet.getInputData().getCustomer();
		currency=dmtSet.getInputData().getCurrency();
		createdDate=dmtSet.getInputData().getCreatedDate();
		discursementDate=dmtSet.getInputData().getDiscursementDate();
		recurrenceId=dmtSet.getInputData().getRecurrenceId();
		interestType=dmtSet.getInputData().getInterestType();
		recurAfter=dmtSet.getInputData().getRecurAfter();
		days=dmtSet.getInputData().getDays();
		rankOfDays=dmtSet.getInputData().getRankOfDays();
		dayNumber=dmtSet.getInputData().getDayNumber();
		loanAmount=dmtSet.getInputData().getLoanAmount();
		amountPaid=dmtSet.getInputData().getAmountPaid();
		interestRate=dmtSet.getInputData().getInterestRate();
		numberOfInstallments=dmtSet.getInputData().getNumberOfInstallments();
		loanDuration=dmtSet.getInputData().getLoanDuration();
		lengthOfPeriod=dmtSet.getInputData().getLengthOfPeriod();
		
		//calling of the Weekly Schedule generation method
		emiNode=dmtSet.getEmi();
		inputParams=new MigrationParams(account, customer, currency,createdDate,discursementDate, recurrenceId ,interestType, recurAfter, days, rankOfDays, dayNumber, loanAmount, amountPaid, interestRate,numberOfInstallments);
		WeeklySchedule weeklySchedule =  new WeeklySchedule(inputParams);
		loanDurationActual=weeklySchedule.getLoanDuration(numberOfInstallments);
			
		   
			//calling the assert to check the expected and actual lengthofperiodvalues
			Assert.assertTrue(loanDuration.equals(loanDurationActual));
  }
}
}
