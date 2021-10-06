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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (LSCategories)

/**
 Returns application name string.
 
 @return Application name string.
 */
- (nullable NSString *)lsName;

/**
 Returns application version string.

 @return Application version string.
 */
- (nullable NSString *)lsVersion;

/**
 Returns application build number string.
 
 @return Application build number string.
 */
- (nullable NSString *)lsBuild;

/**
 Logs the information about launching the application. This information is used when asking for app rating with minimumUsageDays greater than 0.
 */
- (void)lsLogLaunchForAppRating;

/**
 Logs the information about significant event. This information is used when asking for app rating with minimumSignificantEvents greater than 0.
 */
- (void)lsLogSignificantEventForAppRating;

/**
 Shows a dialog for rating the application in the app store if given minimum usage days condition and minimum significant events condition are met.

 @param minimumDaysOfUse Required minimum number of days from the first logged launch event.
 @param minimumSignificantEvents Required minimum number of logged significant events.
 */
- (void)lsAskForAppRatingIfReachedMinimumDaysOfUse:(NSInteger)minimumDaysOfUse minimumSignificantEvents:(NSInteger)minimumSignificantEvents;

/**
 Resets all previously saved informations related to app rating.
 */
- (void)lsResetAppRatingData;

@end

NS_ASSUME_NONNULL_END
