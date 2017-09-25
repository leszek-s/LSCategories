// Copyright (c) 2016 Leszek S
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@interface NSDate (LSCategories)

/**
 Returns date components object.

 @return Date components object.
 */
- (NSDateComponents *)lsDateComponents;

/**
 Returns year.

 @return Year.
 */
- (NSInteger)lsYear;

/**
 Returns month.

 @return Month.
 */
- (NSInteger)lsMonth;

/**
 Returns day.
 
 @return Day.
 */
- (NSInteger)lsDay;

/**
 Returns hour.
 
 @return Hour.
 */
- (NSInteger)lsHour;

/**
 Returns minute.
 
 @return Minute.
 */
- (NSInteger)lsMinute;

/**
 Returns second.
 
 @return Second.
 */
- (NSInteger)lsSecond;

/**
 Returns beginning of day.

 @return Beginning of day.
 */
- (NSDate *)lsBeginningOfDay;

/**
 Returns end of day (last second of day).
 
 @return End of day (last second of day).
 */
- (NSDate *)lsEndOfDay;

/**
 Returns beginning of next day.
 
 @return Beginning of next day.
 */
- (NSDate *)lsBeginningOfNextDay;

/**
 Returns end of previous day (last second of previous day).
 
 @return End of previous day (last second of previous day).
 */
- (NSDate *)lsEndOfPreviousDay;

/**
 Returns beginning of month.
 
 @return Beginning of month.
 */
- (NSDate *)lsBeginningOfMonth;

/**
 Returns end of month (last second of month).
 
 @return End of month (last second of month).
 */
- (NSDate *)lsEndOfMonth;

/**
 Returns beginning of next month.
 
 @return Beginning of next month.
 */
- (NSDate *)lsBeginningOfNextMonth;

/**
 Returns end of previous month (last second of previous month).
 
 @return End of previous month (last second of previous month).
 */
- (NSDate *)lsEndOfPreviousMonth;

/**
 Returns beginning of year.
 
 @return Beginning of year.
 */
- (NSDate *)lsBeginningOfYear;

/**
 Returns end of year (last second of year).
 
 @return End of year (last second of year).
 */
- (NSDate *)lsEndOfYear;

/**
 Returns beginning of next year.
 
 @return Beginning of next year.
 */
- (NSDate *)lsBeginningOfNextYear;

/**
 Returns end of previous year (last second of previous year).
 
 @return End of previous year (last second of previous year).
 */
- (NSDate *)lsEndOfPreviousYear;

/**
 Returns YES if date is today.

 @return YES if date is today.
 */
- (BOOL)lsIsToday;

/**
 Returns YES if date is yesterday.
 
 @return YES if date is yesterday.
 */
- (BOOL)lsIsYesterday;

/**
 Returns YES if date is tomorrow.
 
 @return YES if date is tomorrow.
 */
- (BOOL)lsIsTomorrow;

/**
 Returns YES if date is leap year.
 
 @return YES if date is leap year.
 */
- (BOOL)lsIsLeapYear;

/**
 Returns YES if is earlier that given date.

 @param date Date to compare.
 @return YES if is earlier that given date.
 */
- (BOOL)lsIsEarlierThanDate:(NSDate *)date;

/**
 Returns YES if is earlier or equal to given date.
 
 @param date Date to compare.
 @return YES if is earlier or equal to given date.
 */
- (BOOL)lsIsEarlierOrEqualToDate:(NSDate *)date;

/**
 Returns YES if is later that given date.
 
 @param date Date to compare.
 @return YES if is later that given date.
 */
- (BOOL)lsIsLaterThanDate:(NSDate *)date;

/**
 Returns YES if is later or equal to given date.
 
 @param date Date to compare.
 @return YES if is later or equal to given date.
 */
- (BOOL)lsIsLaterOrEqualToDate:(NSDate *)date;

/**
 Returns YES if is later than startDate and earlier than endDate.

 @param startDate Date to compare.
 @param endDate Date to compare.
 @return YES if is later than startDate and earlier than endDate.
 */
- (BOOL)lsIsInBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**
 Returns YES if is later or equal to startDate and earlier or equal to endDate.
 
 @param startDate Date to compare.
 @param endDate Date to compare.
 @return YES if is later than startDate and earlier than endDate.
 */
- (BOOL)lsIsInBetweenOrEqualStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**
 Returns distance from given date in given calendar unit.

 @param date Date to compare.
 @param calendarUnit Calendar unit.
 @return Distance from given date in given calendar unit.
 */
- (NSDateComponents *)lsDifferenceFromDate:(NSDate *)date calendarUnit:(NSCalendarUnit)calendarUnit;

/**
 Returns difference from given date in years unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2015-11-11T15:00:00+01:00 returns 1.

 @param date Date to compare.
 @return Difference from given date in years unit.
 */
- (NSInteger)lsYearsDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in months unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2015-11-11T15:00:00+01:00 returns 3.
 
 @param date Date to compare.
 @return Difference from given date in months unit.
 */
- (NSInteger)lsMonthsDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in weeaks unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2016-01-29T15:00:00+01:00 returns 1.
 
 @param date Date to compare.
 @return Difference from given date in weeks unit.
 */
- (NSInteger)lsWeeksDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in days unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2016-02-01T20:00:00+01:00 returns 1.
 
 @param date Date to compare.
 @return Difference from given date in days unit.
 */
- (NSInteger)lsDaysDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in hours unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2016-02-02T14:50:00+01:00 returns 1.
 
 @param date Date to compare.
 @return Difference from given date in hours unit.
 */
- (NSInteger)lsHoursDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in minutes unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2016-02-02T15:09:50+01:00 returns 1.
 
 @param date Date to compare.
 @return Difference from given date in minutes unit.
 */
- (NSInteger)lsMinutesDifferenceFromDate:(NSDate *)date;

/**
 Returns difference from given date in seconds unit. Returns positive values if given date parameter is earlier, negative otherwise.
 For example difference between 2016-02-02T15:10:00+01:00 and parameter 2016-02-02T15:09:50+01:00 returns 10.
 
 @param date Date to compare.
 @return Difference from given date in seconds unit.
 */
- (NSInteger)lsSecondsDifferenceFromDate:(NSDate *)date;

/**
 Returns date with added years.

 @param years Years to add.
 @return Date with added years.
 */
- (NSDate *)lsDateByAddingYears:(NSInteger)years;

/**
 Returns date with added months.
 
 @param months Months to add.
 @return Date with added months.
 */
- (NSDate *)lsDateByAddingMonths:(NSInteger)months;

/**
 Returns date with added weeks.
 
 @param weeks Weeks to add.
 @return Date with added weeks.
 */
- (NSDate *)lsDateByAddingWeeks:(NSInteger)weeks;

/**
 Returns date with added days.
 
 @param days Days to add.
 @return Date with added days.
 */
- (NSDate *)lsDateByAddingDays:(NSInteger)days;

/**
 Returns date with added hours.
 
 @param hours Hours to add.
 @return Date with added hours.
 */
- (NSDate *)lsDateByAddingHours:(NSInteger)hours;

/**
 Returns date with added minutes.
 
 @param minutes Minutes to add.
 @return Date with added minutes.
 */
- (NSDate *)lsDateByAddingMinutes:(NSInteger)minutes;

/**
 Returns date with added seconds.
 
 @param seconds Seconds to add.
 @return Date with added seconds.
 */
- (NSDate *)lsDateByAddingSeconds:(NSInteger)seconds;

/**
 Returns string with date and/or time with given style.

 @param dateStyle Date style.
 @param timeStyle Time style.
 @return String with date and/or time with given style.
 */
- (NSString *)lsStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

/**
 Returns string with date and/or time with given style and locale.

 @param dateStyle Date style.
 @param timeStyle Time style.
 @param locale Locale.
 @return String with date and/or time with given style and locale.
 */
- (NSString *)lsStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle locale:(NSLocale *)locale;

/**
 Returns string with date and time using short style.

 @return String with date and time using short style.
 */
- (NSString *)lsStringWithShortDateTime;

/**
 Returns string with date and time using medium style.
 
 @return String with date and time using medium style.
 */
- (NSString *)lsStringWithMediumDateTime;

/**
 Returns string with date and time using long style.
 
 @return String with date and time using long style.
 */
- (NSString *)lsStringWithLongDateTime;

/**
 Returns string with date using short style.
 
 @return String with date using short style.
 */
- (NSString *)lsStringWithShortDate;

/**
 Returns string with date using medium style.
 
 @return String with date using medium style.
 */
- (NSString *)lsStringWithMediumDate;

/**
 Returns string with date using long style.
 
 @return String with date using long style.
 */
- (NSString *)lsStringWithLongDate;

/**
 Returns string with time using short style.
 
 @return String with time using short style.
 */
- (NSString *)lsStringWithShortTime;

/**
 Returns string with time using medium style.
 
 @return String with time using medium style.
 */
- (NSString *)lsStringWithMediumTime;

/**
 Returns string with time using long style.
 
 @return String with time using long style.
 */
- (NSString *)lsStringWithLongTime;

/**
 Returns string with date/time with given format.

 @param format Format string.
 @return String with date/time with given format.
 */
- (NSString *)lsStringWithFormat:(NSString *)format;

/**
 Returns string with date/time with given format and locale.

 @param format Format string.
 @param locale Locale.
 @return String with date/time with given format and locale.
 */
- (NSString *)lsStringWithFormat:(NSString *)format locale:(NSLocale *)locale;

/**
 Returns string with date and time in ISO8601 format.

 @return String with date and time in ISO8601 format.
 */
- (NSString *)lsStringWithISO8601;

/**
 Returns date combined from date and time.
 
 @param date Date.
 @param time Time.
 @return Date combined from date and time.
 */
+ (NSDate *)lsDateCombinedWithDate:(NSDate *)date time:(NSDate *)time;

/**
 Returns date from string in given format.

 @param string String with date/time.
 @param format Format string.
 @return Date from string in given format.
 */
+ (NSDate *)lsDateWithString:(NSString *)string format:(NSString *)format;

/**
 Returns date from string in ISO8601 format.

 @param stringWithISO8601 String with date in ISO8601 format.
 @return Date from string in ISO8601 format.
 */
+ (NSDate *)lsDateWithStringWithISO8601:(NSString *)stringWithISO8601;

@end
