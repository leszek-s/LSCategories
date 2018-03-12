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

#import "UIWindow+LSCategories.h"

@implementation UIWindow (LSCategories)

- (void)lsSetWithPushRootViewController:(UIViewController *)viewController
{
    [self lsSetRootViewController:viewController animationType:kCATransitionPush animationSubtype:kCATransitionFromRight backgroundColor:[self.rootViewController.view.backgroundColor colorWithAlphaComponent:0.6]];
}

- (void)lsSetWithPopRootViewController:(UIViewController *)viewController
{
    [self lsSetRootViewController:viewController animationType:kCATransitionPush animationSubtype:kCATransitionFromLeft backgroundColor:[self.rootViewController.view.backgroundColor colorWithAlphaComponent:0.6]];
}

- (void)lsSetRootViewController:(UIViewController *)viewController animationType:(NSString *)animationType animationSubtype:(NSString *)animationSubtype backgroundColor:(UIColor *)backgroundColor
{
    if (!self.rootViewController || !viewController || !animationType || !animationSubtype)
        return;
    
    viewController.view.frame = self.rootViewController.view.frame;
    [viewController.view layoutIfNeeded];
    
    if (backgroundColor) {
        UIWindow *backgroundWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        backgroundWindow.backgroundColor = backgroundColor;
        [backgroundWindow makeKeyAndVisible];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [backgroundWindow removeFromSuperview];
        });
    }
    
    CATransition *transition = [CATransition new];
    transition.type = animationType;
    transition.subtype = animationSubtype;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.duration = 0.25;
    self.rootViewController = viewController;
    [self makeKeyAndVisible];
    [self.layer addAnimation:transition forKey:kCATransition];
}

@end
