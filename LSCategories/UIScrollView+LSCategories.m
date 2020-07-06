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

#import "UIScrollView+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedInitialContentInset;
static char lsAssociatedInitialScrollIndicatorInset;

@implementation UIScrollView (LSCategories)

- (void)lsEnableAutomaticScrollAdjustmentsWhenKeyboardAppear
{
    #if !TARGET_OS_TV
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(lsReceivedKeyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(lsReceivedKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    #endif
}

- (void)lsReceivedKeyboardNotification:(NSNotification *)notification
{
    #if !TARGET_OS_TV
    if ([notification.name isEqual:UIKeyboardWillHideNotification])
    {
        NSValue *initialContentInset = objc_getAssociatedObject(self, &lsAssociatedInitialContentInset);
        NSValue *scrollIndicatorInsets = objc_getAssociatedObject(self, &lsAssociatedInitialScrollIndicatorInset);
        objc_setAssociatedObject(self, &lsAssociatedInitialContentInset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &lsAssociatedInitialScrollIndicatorInset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.contentInset = initialContentInset.UIEdgeInsetsValue;
        self.scrollIndicatorInsets = scrollIndicatorInsets.UIEdgeInsetsValue;
        return;
    }
    
    if (!objc_getAssociatedObject(self, &lsAssociatedInitialContentInset))
    {
        objc_setAssociatedObject(self, &lsAssociatedInitialContentInset, [NSValue valueWithUIEdgeInsets:self.contentInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &lsAssociatedInitialScrollIndicatorInset, [NSValue valueWithUIEdgeInsets:self.scrollIndicatorInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardRectConverted = [self.superview convertRect:keyboardRect fromView:nil];
    NSInteger keyboardOverlap = CGRectGetMaxY(self.frame) - CGRectGetMinY(keyboardRectConverted);
    if (keyboardOverlap >= 0)
    {
        self.contentInset = UIEdgeInsetsMake(0, 0, keyboardOverlap + 20, 0);
        self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardOverlap, 0);
    }
    #endif
}

@end
