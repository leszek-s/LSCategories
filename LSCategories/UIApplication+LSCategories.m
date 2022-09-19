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

#import "UIApplication+LSCategories.h"
#import "NSDate+LSCategories.h"
#import "UIDevice+LSCategories.h"
#import <StoreKit/StoreKit.h>

static NSString * const lsAppRatingKeyFirstLaunchDate = @"lsAppRatingKeyFirstLaunchDate";
static NSString * const lsAppRatingKeySignificantEvents = @"lsAppRatingKeySignificantEvents";
static NSString * const lsAppRatingKeyIsDisabled = @"lsAppRatingKeyIsDisabled";

@implementation UIApplication (LSCategories)

- (NSString *)lsName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

- (NSString *)lsVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)lsBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)lsLogLaunchForAppRating
{
    NSDate *date = [NSUserDefaults.standardUserDefaults objectForKey:lsAppRatingKeyFirstLaunchDate];
    if (!date)
    {
        [NSUserDefaults.standardUserDefaults setObject:[NSDate new] forKey:lsAppRatingKeyFirstLaunchDate];
    }
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)lsLogSignificantEventForAppRating
{
    NSNumber *value = [NSUserDefaults.standardUserDefaults objectForKey:lsAppRatingKeySignificantEvents];
    value = @(value.integerValue + 1);
    [NSUserDefaults.standardUserDefaults setObject:value forKey:lsAppRatingKeySignificantEvents];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)lsAskForAppRatingIfReachedMinimumDaysOfUse:(NSInteger)minimumDaysOfUse minimumSignificantEvents:(NSInteger)minimumSignificantEvents
{
    #if !TARGET_OS_TV
    NSNumber *disabled = [NSUserDefaults.standardUserDefaults objectForKey:lsAppRatingKeyIsDisabled];
    BOOL isDisabled = [disabled boolValue];
    
    if (isDisabled)
        return;
    
    NSDate *firstLaunchDate = [NSUserDefaults.standardUserDefaults objectForKey:lsAppRatingKeyFirstLaunchDate];
    NSInteger daysOfUse = ABS([firstLaunchDate lsDaysDifferenceFromDate:[NSDate new]]);
    
    NSInteger significantEvents = [[NSUserDefaults.standardUserDefaults objectForKey:lsAppRatingKeySignificantEvents] integerValue];
    
    if (daysOfUse < minimumDaysOfUse || significantEvents < minimumSignificantEvents)
        return;
    
    if (![UIDevice connectedToWiFiNetwork]) {
        return;
    }
    
    if (@available(iOS 10.3, *))
    {
        [NSUserDefaults.standardUserDefaults setObject:@YES forKey:lsAppRatingKeyIsDisabled];
        [NSUserDefaults.standardUserDefaults synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [SKStoreReviewController requestReview];
        });
    }
    #endif
}

- (void)lsResetAppRatingData
{
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:lsAppRatingKeyIsDisabled];
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:lsAppRatingKeyFirstLaunchDate];
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:lsAppRatingKeySignificantEvents];
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
