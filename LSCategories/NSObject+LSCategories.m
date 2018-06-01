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
static char lsObserversDictionaryKey;

#define lsDefaultDataEvent @"lsDefaultDataEvent"

@interface LSNSObjectObserver : NSObject
@property (strong, nonatomic) NSString *keyPath;
@end

@implementation LSNSObjectObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (keyPath == self.keyPath)
    {
        [self lsSendEvent:keyPath data:change];
    }
}

@end

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

- (NSMutableDictionary *)lsObserversDictionary
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &lsObserversDictionaryKey);
    if (!dict)
    {
        dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &lsObserversDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSString *)lsSubscribeForDataWithHandler:(void (^)(id data))handler
{
    return [self lsSubscribeForEvent:lsDefaultDataEvent handler:handler];
}

- (void)lsSendData:(id)data
{
    [self lsSendEvent:lsDefaultDataEvent data:data];
}

- (void)lsRemoveAllSubscriptionsForData
{
    [self lsRemoveAllSubscriptionsForEvent:lsDefaultDataEvent];
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

- (NSString *)lsObserveValueForKeyPath:(NSString *)keyPath handler:(void (^)(NSDictionary *change))handler
{
    if (keyPath.length <= 0 || !handler)
        return nil;
    
    LSNSObjectObserver *observer = [LSNSObjectObserver new];
    observer.keyPath = keyPath;
    NSString *observationId = [observer lsSubscribeForEvent:keyPath handler:handler];
    
    NSMutableDictionary *observersDictionary = [self lsObserversDictionary];
    observersDictionary[observationId] = observer;
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    return observationId;
}

- (void)lsRemoveObservationWithId:(NSString *)observationId
{
    if (!observationId)
        return;
    
    NSMutableDictionary *observersDictionary = [self lsObserversDictionary];
    LSNSObjectObserver *observer = observersDictionary[observationId];
    [observer lsRemoveAllSubscriptions];
    @try {
        [self removeObserver:observer forKeyPath:observer.keyPath];
    } @catch (id exception) { }
    observersDictionary[observationId] = nil;
}

- (void)lsRemoveAllObservationsForKeyPath:(NSString *)keyPath
{
    if (!keyPath)
        return;
    
    NSMutableDictionary *observersDictionary = [self lsObserversDictionary];
    for (NSString *observationId in observersDictionary.allKeys)
    {
        LSNSObjectObserver *observer = observersDictionary[observationId];
        if ([observer.keyPath isEqual:keyPath])
        {
            [self lsRemoveObservationWithId:observationId];
        }
    }
}

- (void)lsRemoveAllObservations
{
    NSMutableDictionary *observersDictionary = [self lsObserversDictionary];
    for (NSString *observationId in observersDictionary.allKeys)
    {
        [self lsRemoveObservationWithId:observationId];
    }
}

@end
