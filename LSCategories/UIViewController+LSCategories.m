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

#import "UIViewController+LSCategories.h"
#import "UIView+LSCategories.h"
#import "UITextField+LSCategories.h"
#import "UIScrollView+LSCategories.h"

@implementation UIViewController (LSCategories)

- (void)lsAddChildViewController:(UIViewController *)viewController toView:(UIView *)view
{
    if (!viewController || !view || [view isDescendantOfView:viewController.view])
        return;
    
    [self addChildViewController:viewController];
    [view addSubview:viewController.view];
    viewController.view.frame = view.bounds;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [viewController didMoveToParentViewController:self];
}

- (void)lsRemoveFromParentViewController
{
    if (!self.parentViewController)
        return;
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)lsEnableAutomaticKeyboardHandling
{
    [self lsEnableAutomaticKeyboardHandlingWithAutomaticNextAndDone:YES hideOnTapOutside:YES];
}

- (void)lsEnableAutomaticKeyboardHandlingWithAutomaticNextAndDone:(BOOL)automaticNextAndDone hideOnTapOutside:(BOOL)hideOnTapOutside
{
    if (hideOnTapOutside)
    {
        [self.view lsEnableHideKeyboardOnTap];
    }
    NSArray *textFields = [self.view lsSubviewsWithClass:[UITextField class] recursive:YES];
    for (UITextField *textField in textFields)
    {
        if (automaticNextAndDone)
        {
            [textField lsEnableAutomaticNextAndDoneButtonsOnKeyboard];
        }
        else
        {
            [textField lsEnableAutomaticReturnButtonOnKeyboard];
        }
    }
    NSArray *scrollViews = [self.view lsSubviewsWithClass:[UIScrollView class] recursive:YES];
    for (UIScrollView *scrollView in scrollViews)
    {
        BOOL isTopScrollView = [scrollView lsSubviewsWithClass:[UIScrollView class] recursive:YES].count == 0;
        if (isTopScrollView)
        {
            [scrollView lsEnableAutomaticScrollAdjustmentsWhenKeyboardAppear];
        }
    }
}

@end
