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

#import "NSDate+LSCategories.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

@implementation NSDate (LSCategories)

- (NSDateComponents *)lsDateComponents
{
    NSCalendarUnit flags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:flags fromDate:self];
    return components;
}

- (NSInteger)lsYear
{
    return [self lsDateComponents].year;
}

- (NSInteger)lsMonth
{
    return [self lsDateComponents].month;
}

- (NSInteger)lsDay
{
    return [self lsDateComponents].day;
}

- (NSInteger)lsHour
{
    return [self lsDateComponents].hour;
}

- (NSInteger)lsMinute
{
    return [self lsDateComponents].minute;
}

- (NSInteger)lsSecond
{
    return [self lsDateComponents].second;
}

- (NSDate *)lsBeginningOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)lsEndOfDay
{
    return [[[self lsBeginningOfDay] lsDateByAddingDays:1] dateByAddingTimeInterval:-1];
}

- (NSDate *)lsBeginningOfNextDay
{
    return [[self lsBeginningOfDay] lsDateByAddingDays:1];
}

- (NSDate *)lsEndOfPreviousDay
{
    return [[self lsBeginningOfDay] dateByAddingTimeInterval:-1];
}

- (NSDate *)lsBeginningOfMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)lsEndOfMonth
{
    return [[[self lsBeginningOfMonth] lsDateByAddingMonths:1] dateByAddingTimeInterval:-1];
}

- (NSDate *)lsBeginningOfNextMonth
{
    return [[self lsBeginningOfMonth] lsDateByAddingMonths:1];
}

- (NSDate *)lsEndOfPreviousMonth
{
    return [[self lsBeginningOfMonth] dateByAddingTimeInterval:-1];
}

- (NSDate *)lsBeginningOfYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)lsEndOfYear
{
    return [[[self lsBeginningOfYear] lsDateByAddingYears:1] dateByAddingTimeInterval:-1];
}

- (NSDate *)lsBeginningOfNextYear
{
    return [[self lsBeginningOfYear] lsDateByAddingYears:1];
}

- (NSDate *)lsEndOfPreviousYear
{
    return [[self lsBeginningOfYear] dateByAddingTimeInterval:-1];
}

- (BOOL)lsIsToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:todayComponents];
    NSDateComponents *selfComponents = [calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDate *selfDate = [calendar dateFromComponents:selfComponents];
    return [today isEqualToDate:selfDate];
}

- (BOOL)lsIsYesterday
{
    NSDate *nextDay = [self lsDateByAddingDays:1];
    return [nextDay lsIsToday];
}

- (BOOL)lsIsTomorrow
{
    NSDate *prevDay = [self lsDateByAddingDays:-1];
    return [prevDay lsIsToday];
}

- (BOOL)lsIsLeapYear
{
    NSInteger year = [self lsDateComponents].year;
    return (year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0));
}

- (BOOL)lsIsEarlierThanDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] < 0;
}

- (BOOL)lsIsEarlierOrEqualToDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] <= 0;
}

- (BOOL)lsIsLaterThanDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] > 0;
}

- (BOOL)lsIsLaterOrEqualToDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] >= 0;
}

- (BOOL)lsIsInBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    return [self timeIntervalSinceDate:startDate] > 0 && [self timeIntervalSinceDate:endDate] < 0;
}

- (BOOL)lsIsInBetweenOrEqualStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    return [self timeIntervalSinceDate:startDate] >= 0 && [self timeIntervalSinceDate:endDate] <= 0;
}

- (NSDateComponents *)lsDifferenceFromDate:(NSDate *)date calendarUnit:(NSCalendarUnit)calendarUnit
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *fromDateStart;
    NSDate *toDateStart;
    [calendar rangeOfUnit:calendarUnit startDate:&fromDateStart interval:NULL forDate:date];
    [calendar rangeOfUnit:calendarUnit startDate:&toDateStart interval:NULL forDate:self];
    NSDateComponents *difference = [calendar components:calendarUnit fromDate:fromDateStart toDate:toDateStart options:0];
    return difference;
}

- (NSInteger)lsYearsDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitYear];
    return difference.year;
}

- (NSInteger)lsMonthsDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitMonth];
    return difference.month;
}

- (NSInteger)lsWeeksDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitWeekOfYear];
    return difference.weekOfYear;
}

- (NSInteger)lsDaysDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitDay];
    return difference.day;
}

- (NSInteger)lsHoursDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitHour];
    return difference.hour;
}

- (NSInteger)lsMinutesDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitMinute];
    return difference.minute;
}

- (NSInteger)lsSecondsDifferenceFromDate:(NSDate *)date
{
    NSDateComponents *difference = [self lsDifferenceFromDate:date calendarUnit:NSCalendarUnitSecond];
    return difference.second;
}

- (NSDate *)lsDateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.year = years;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.month = months;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.weekOfYear = weeks;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingHours:(NSInteger)hours
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.hour = hours;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingMinutes:(NSInteger)minutes
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.minute = minutes;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lsDateByAddingSeconds:(NSInteger)seconds
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.second = seconds;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSString *)lsStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [self lsStringWithDateStyle:dateStyle timeStyle:timeStyle locale:[NSLocale currentLocale]];
}

- (NSString *)lsStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle locale:(NSLocale *)locale
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
    });
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.locale = locale;
    return [formatter stringFromDate:self];
}

- (NSString *)lsStringWithShortDateTime
{
    return [self lsStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)lsStringWithMediumDateTime
{
    return [self lsStringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)lsStringWithLongDateTime
{
    return [self lsStringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)lsStringWithShortDate
{
    return [self lsStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)lsStringWithMediumDate
{
    return [self lsStringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)lsStringWithLongDate
{
    return [self lsStringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)lsStringWithShortTime
{
    return [self lsStringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)lsStringWithMediumTime
{
    return [self lsStringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)lsStringWithLongTime
{
    return [self lsStringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *)lsStringWithFormat:(NSString *)format
{
    return [self lsStringWithFormat:format locale:[NSLocale currentLocale]];
}

- (NSString *)lsStringWithFormat:(NSString *)format locale:(NSLocale *)locale
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
    });
    formatter.dateFormat = format;
    formatter.locale = locale;
    return [formatter stringFromDate:self];
}

- (NSString *)lsStringWithISO8601
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return [formatter stringFromDate:self];
}

+ (NSDate *)lsDateCombinedWithDate:(NSDate *)date time:(NSDate *)time
{
    NSDateComponents *dateComponents = [date lsDateComponents];
    NSDateComponents *timeComponents = [time lsDateComponents];
    dateComponents.hour = timeComponents.hour;
    dateComponents.minute = timeComponents.minute;
    dateComponents.second = timeComponents.second;
    return [dateComponents.calendar dateFromComponents:dateComponents];
}

+ (NSDate *)lsDateWithString:(NSString *)string format:(NSString *)format
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
    });
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (NSDate *)lsDateWithStringWithISO8601:(NSString *)stringWithISO8601
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return [formatter dateFromString:stringWithISO8601];
}

+ (void)lsDateFromOnlineServerWithHandler:(void (^)(NSDate *date))handler
{
    if (!handler)
        return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSDate *date = [self lsDateFromOnlineServer];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            handler(date);
        });
    });
}

+ (NSDate *)lsDateFromOnlineServer
{
    struct hostent *server = gethostbyname("time.apple.com");
    if (!server)
        return nil;
    
    int udpSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (udpSocket < 0)
        return nil;
    
    struct timeval timeout;
    timeout.tv_sec = 30;
    timeout.tv_usec = 0;
    setsockopt(udpSocket, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));
    
    struct sockaddr_in socketAddress = {0};
    socketAddress.sin_family = AF_INET;
    socketAddress.sin_port = htons(123);
    memcpy(&socketAddress.sin_addr, server->h_addr_list[0], server->h_length);
    
    if (connect(udpSocket, (struct sockaddr *)&socketAddress, sizeof(socketAddress)) < 0) {
        close(udpSocket);
        return nil;
    }
    
    unsigned char ntpPacket[48] = {0};
    ntpPacket[0] = 0x1B;
    
    if (write(udpSocket, &ntpPacket, sizeof(ntpPacket)) < 0) {
        close(udpSocket);
        return nil;
    }
    
    if (read(udpSocket, &ntpPacket, sizeof(ntpPacket)) < 0) {
        close(udpSocket);
        return nil;
    }
    
    close(udpSocket);
    
    NSTimeInterval ntpTimestampDelta = 2208988800u;
    NSTimeInterval ntpTimestamp = ntohl(*((uint32_t *)(ntpPacket + 40)));
    NSTimeInterval ntpOverflowDelta = ntpTimestamp < ntpTimestampDelta ? 0xFFFFFFFF : 0;
    
    if (ntpTimestamp == 0)
        return nil;
    
    NSTimeInterval timestamp = ntpTimestamp - ntpTimestampDelta + ntpOverflowDelta;
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

@end
