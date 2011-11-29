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
import java.util.ArrayList;

import org.joda.time.DateTime;
import org.mifos.dmt.logging.DMTLogger;

public abstract class Schedule {
	@SuppressWarnings("unused")
	private static final DMTLogger logger = (DMTLogger) DMTLogger.getLogger(Schedule.class.getName()); 
	
	protected DateTime createdDate;
	protected DateTime startDate;
	protected DateTime disbursementDate;
	protected int recAfter;
	public ArrayList<String> scheduleList;
	
	public Schedule(DateTime createdDate) {
		this.createdDate = createdDate;
	}
	
	public abstract void generateSchedule(int numberOfDates);
	public abstract BigDecimal getLoanDuration(int numberOfInstallments);
	public abstract BigDecimal getLengthOfPeriod();
	protected abstract void fastForwardTillDisbursement();
	protected abstract void getMeetingStartDate();
	
	protected DateTime getWorkingDay(DateTime meetingDate) {
		int iDoW;
		iDoW = meetingDate.dayOfWeek().get();
		while(iDoW==7) {
			meetingDate = meetingDate.plusDays(1);
			iDoW = meetingDate.dayOfWeek().get();
		}
		return meetingDate;
	}
}
