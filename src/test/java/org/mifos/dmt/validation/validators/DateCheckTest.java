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

package org.mifos.dmt.validation.validators;
import org.testng.Assert;
import org.mifos.dmt.util.DMTException;
import org.mifos.dmt.validation.validators.DateCheck;
import org.testng.annotations.Test;

public class DateCheckTest {

//method to test the pass data functionality
  @Test(groups="method1")
  public void validateTrue() throws DMTException  {
	  boolean retStatus = false;
		DateCheck x = new DateCheck();
		retStatus= x.validate(null, 0);
		Assert.assertTrue(retStatus);
  }
  
//method to fail the wrong data functionality
  @Test(groups="method2")
  public void validateFalse() throws DMTException {
	  boolean retStatus = true;
		DateCheck x = new DateCheck();
		retStatus= x.validate(null, 0);
		Assert.assertFalse(retStatus);
  }
}
