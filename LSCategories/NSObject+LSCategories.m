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

#import "NSObject+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedDictionaryKey;
static char lsEventsDictionaryKey;

@implementation NSObject (LSCategories)

+ (NSString *)lsClassName
{
    return NSStringFromClass(self);
}

- (NSString *)lsClassName
{
    return NSStringFromClass([self class]);
}

- (NSMutableDictionary *)lsAssociatedDictionary
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &lsAssociatedDictionaryKey);
    if (!dict)
    {
        dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &lsAssociatedDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary *)lsEventsDictionary
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &lsEventsDictionaryKey);
    if (!dict)
    {
        dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &lsEventsDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSString *)lsSubscribeForEvent:(NSString *)event handler:(void (^)(id data))handler
{
    if (!event || !handler)
        return nil;
    
    NSMutableDictionary *eventsDictionary = [self lsEventsDictionary];
    NSMutableArray *events = eventsDictionary[event];
    if (!events)
    {
        events = [NSMutableArray new];
        eventsDictionary[event] = events;
    }
    NSString *eventId = [NSUUID UUID].UUIDString;
    [events addObject:@[eventId, [handler copy]]];
    return eventId;
}

- (void)lsSendEvent:(NSString *)event data:(id)data
{
    NSMutableDictionary *eventsDictionary = [self lsEventsDictionary];
    NSMutableArray *events = eventsDictionary[event];
    for (NSArray *ev in events)
    {
        void (^handler)(id data) = ev.lastObject;
        handler(data);
    }
}

- (void)lsRemoveSubscriptionWithId:(NSString *)subscriptionId
{
    if (!subscriptionId)
        return;
    
    NSMutableDictionary *eventsDictionary = [self lsEventsDictionary];
    for (NSMutableArray *events in eventsDictionary.allValues)
    {
        NSArray *eventsCopy = [events copy];
        for (NSArray *ev in eventsCopy)
        {
            if ([ev.firstObject isEqual:subscriptionId])
            {
                [events removeObject:ev];
                return;
            }
        }
    }
}

- (void)lsRemoveAllSubscriptionsForEvent:(NSString *)event
{
    if (!event)
        return;
    
    NSMutableDictionary *eventsDictionary = [self lsEventsDictionary];
    eventsDictionary[event] = nil;
}

- (void)lsRemoveAllSubscriptions
{
    NSMutableDictionary *eventsDictionary = [self lsEventsDictionary];
    [eventsDictionary removeAllObjects];
}

@end
