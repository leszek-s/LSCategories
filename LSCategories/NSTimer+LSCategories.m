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

#import "NSTimer+LSCategories.h"

@implementation NSTimer (LSCategories)

+ (NSTimer *)lsCountingTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer, NSDate *createdDate, NSInteger counter))block
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    userInfo[@"lsTimerBlock"] = [block copy];
    userInfo[@"lsTimerCounter"] = @0;
    userInfo[@"lsTimerCreatedDate"] = [NSDate new];
    return [self timerWithTimeInterval:interval target:self selector:@selector(lsCountingTimerSelector:) userInfo:userInfo repeats:repeats];
}

+ (NSTimer *)lsScheduledCountingTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer, NSDate *createdDate, NSInteger counter))block
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    userInfo[@"lsTimerBlock"] = [block copy];
    userInfo[@"lsTimerCounter"] = @0;
    userInfo[@"lsTimerCreatedDate"] = [NSDate new];
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(lsCountingTimerSelector:) userInfo:userInfo repeats:repeats];
}

+ (void)lsCountingTimerSelector:(NSTimer *)timer
{
    NSMutableDictionary *userInfo = timer.userInfo;
    void (^block)(NSTimer *timer, NSDate *createdDate, NSInteger counter) = userInfo[@"lsTimerBlock"];
    NSNumber *counter = userInfo[@"lsTimerCounter"];
    NSDate *createdDate = userInfo[@"lsTimerCreatedDate"];
    
    if (!block || !counter || !createdDate)
        return;
    
    NSInteger updatedCounter = counter.integerValue + 1;
    userInfo[@"lsTimerCounter"] = @(updatedCounter);
    
    block(timer, createdDate, updatedCounter);
}

@end
