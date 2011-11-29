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
import java.math.MathContext;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.joda.time.DateTime;
import org.mifos.dmt.business.Meetings.entity.MigrationParams;

public class MonthlyScheduleWithROD extends Schedule {
	//ROD - Rank of day
	private int days;
	private int rankOfDays;
	public MonthlyScheduleWithROD(MigrationParams scheduleParams) {
		super(scheduleParams.getCreatedDate());
		this.recAfter = scheduleParams.getRecurAfter();
		this.days = scheduleParams.getDays();
		this.scheduleList = new ArrayList<String>();
		this.rankOfDays = scheduleParams.getRankOfDays();
		this.disbursementDate = scheduleParams.getDisbursementDate();
	}
	
	private void sanitizeDays() {
		//to match the constant values used in JODA package and in mifos
		this.days--;
		if (this.days==0)  { this.days=7; } 
	}
	
	protected void getMeetingStartDate() {
		sanitizeDays();
		DateTime initialDate = this.createdDate;
		initialDate = initialDate.withDayOfMonth(1);
		initialDate = initialDate.plusWeeks((this.rankOfDays -1));
		initialDate = initialDate.withDayOfWeek(this.days);
		if(initialDate.isBefore(this.createdDate) || initialDate.isEqual(this.createdDate)) {
			initialDate = initialDate.plusMonths(1);
			initialDate = initialDate.withDayOfMonth(1);
			initialDate = initialDate.plusWeeks((this.rankOfDays -1));
			initialDate = initialDate.withDayOfWeek(this.days);
		}
		this.startDate = initialDate;	
	}
	
	public void generateSchedule(int numberOfDates) {
		numberOfDates--;
		getMeetingStartDate();
		fastForwardTillDisbursement();
		DateTime meetingScheduleDate = this.startDate;
		Date meetingDateInMifosFormat;
		for (int i=0; i<=numberOfDates ; i++) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			meetingDateInMifosFormat = getWorkingDay(meetingScheduleDate).toDate();
			this.scheduleList.add(formatter.format(meetingDateInMifosFormat));
			meetingScheduleDate = meetingScheduleDate.plusMonths(this.recAfter);
			meetingScheduleDate = meetingScheduleDate.withDayOfMonth(1);
			meetingScheduleDate = meetingScheduleDate.plusWeeks((this.rankOfDays -1));
			meetingScheduleDate = meetingScheduleDate.withDayOfWeek(this.days);
		}
	}
	
	public BigDecimal getLoanDuration(int numberOfInstallments) {
		MathContext mc = new MathContext(5);
		double duration = 0;
		duration = this.recAfter * numberOfInstallments;
		duration /=12;
		return new BigDecimal(duration, mc);
	}

	@Override
	public BigDecimal getLengthOfPeriod() {
		MathContext mc = new MathContext(5);
		double duration = 0;
		duration = this.recAfter;
		duration /=12;
		return new BigDecimal(duration, mc);
	}

	@Override
	protected void fastForwardTillDisbursement() {
		while(!this.startDate.isAfter(this.disbursementDate)) {
			this.startDate = this.startDate.plusMonths(this.recAfter);
			this.startDate = this.startDate.withDayOfMonth(1);
			this.startDate = this.startDate.plusWeeks((this.rankOfDays -1));
			this.startDate = this.startDate.withDayOfWeek(this.days);
		}
		
	}
}