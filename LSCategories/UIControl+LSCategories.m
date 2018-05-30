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

#import "UIControl+LSCategories.h"
#import "NSObject+LSCategories.h"

#define lsControlEventKey(x) ([NSString stringWithFormat:@"controlEvent-%@", @(x)])

@implementation UIControl (LSCategories)

- (void)lsAddControlEvent:(UIControlEvents)controlEvent handler:(void (^)(id sender))handler
{
    SEL selector = nil;
    switch (controlEvent)
    {
        case UIControlEventTouchDown:
            selector = @selector(lsControlEventTouchDownHandler:);
            break;
        case UIControlEventTouchDownRepeat:
            selector = @selector(lsControlEventTouchDownRepeatHandler:);
            break;
        case UIControlEventTouchDragInside:
            selector = @selector(lsControlEventTouchDragInsideHandler:);
            break;
        case UIControlEventTouchDragOutside:
            selector = @selector(lsControlEventTouchDragOutsideHandler:);
            break;
        case UIControlEventTouchDragEnter:
            selector = @selector(lsControlEventTouchDragEnterHandler:);
            break;
        case UIControlEventTouchDragExit:
            selector = @selector(lsControlEventTouchDragExitHandler:);
            break;
        case UIControlEventTouchUpInside:
            selector = @selector(lsControlEventTouchUpInsideHandler:);
            break;
        case UIControlEventTouchUpOutside:
            selector = @selector(lsControlEventTouchUpOutsideHandler:);
            break;
        case UIControlEventTouchCancel:
            selector = @selector(lsControlEventTouchCancelHandler:);
            break;
        case UIControlEventValueChanged:
            selector = @selector(lsControlEventValueChangedHandler:);
            break;
        case UIControlEventEditingDidBegin:
            selector = @selector(lsControlEventEditingDidBeginHandler:);
            break;
        case UIControlEventEditingChanged:
            selector = @selector(lsControlEventEditingChangedHandler:);
            break;
        case UIControlEventEditingDidEnd:
            selector = @selector(lsControlEventEditingDidEndHandler:);
            break;
        case UIControlEventEditingDidEndOnExit:
            selector = @selector(lsControlEventEditingDidEndOnExitHandler:);
            break;
        case UIControlEventAllTouchEvents:
            selector = @selector(lsControlEventAllTouchEventsHandler:);
            break;
        case UIControlEventAllEditingEvents:
            selector = @selector(lsControlEventAllEditingEventsHandler:);
            break;
        case UIControlEventApplicationReserved:
            selector = @selector(lsControlEventApplicationReservedHandler:);
            break;
        case UIControlEventSystemReserved:
            selector = @selector(lsControlEventSystemReservedHandler:);
            break;
        case UIControlEventAllEvents:
            selector = @selector(lsControlEventAllEventsHandler:);
            break;
        default:
            break;
    }
    if (selector)
    {
        [self addTarget:self action:selector forControlEvents:controlEvent];
        [self lsSubscribeForEvent:lsControlEventKey(controlEvent) handler:handler];
    }
}

- (void)lsRemoveAllControlEventHandlers
{
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDown)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDownRepeat)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDragInside)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDragOutside)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDragEnter)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchDragExit)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchUpInside)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchUpOutside)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventTouchCancel)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventValueChanged)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventEditingDidBegin)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventEditingChanged)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventEditingDidEnd)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventEditingDidEndOnExit)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventAllTouchEvents)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventAllEditingEvents)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventApplicationReserved)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventSystemReserved)];
    [self lsRemoveAllSubscriptionsForEvent:lsControlEventKey(UIControlEventAllEvents)];
}

- (void)lsControlEventTouchDownHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDown) data:sender];
}

- (void)lsControlEventTouchDownRepeatHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDownRepeat) data:sender];
}

- (void)lsControlEventTouchDragInsideHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDragInside) data:sender];
}

- (void)lsControlEventTouchDragOutsideHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDragOutside) data:sender];
}

- (void)lsControlEventTouchDragEnterHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDragEnter) data:sender];
}

- (void)lsControlEventTouchDragExitHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchDragExit) data:sender];
}

- (void)lsControlEventTouchUpInsideHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchUpInside) data:sender];
}

- (void)lsControlEventTouchUpOutsideHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchUpOutside) data:sender];
}

- (void)lsControlEventTouchCancelHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventTouchCancel) data:sender];
}

- (void)lsControlEventValueChangedHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventValueChanged) data:sender];
}

- (void)lsControlEventEditingDidBeginHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventEditingDidBegin) data:sender];
}

- (void)lsControlEventEditingChangedHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventEditingChanged) data:sender];
}

- (void)lsControlEventEditingDidEndHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventEditingDidEnd) data:sender];
}

- (void)lsControlEventEditingDidEndOnExitHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventEditingDidEndOnExit) data:sender];
}

- (void)lsControlEventAllTouchEventsHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventAllTouchEvents) data:sender];
}

- (void)lsControlEventAllEditingEventsHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventAllEditingEvents) data:sender];
}

- (void)lsControlEventApplicationReservedHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventApplicationReserved) data:sender];
}

- (void)lsControlEventSystemReservedHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventSystemReserved) data:sender];
}

- (void)lsControlEventAllEventsHandler:(id)sender
{
    [self lsSendEvent:lsControlEventKey(UIControlEventAllEvents) data:sender];
}

@end
