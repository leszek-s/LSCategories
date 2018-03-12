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

@interface UIWindow (LSCategories)

/**
 Sets root view controller with push animation.

 @param viewController View controller to set.
 */
- (void)lsSetWithPushRootViewController:(UIViewController *)viewController;

/**
 Sets root view controller with pop animation.
 
 @param viewController View controller to set.
 */
- (void)lsSetWithPopRootViewController:(UIViewController *)viewController;

/**
 Sets root view controller with given animation.

 @param viewController View controller to set.
 @param animationType Animation type (possible values: kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal)
 @param animationSubtype Animation subtype (possible values: kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom)
 @param backgroundColor Optional background color used in transition.
 */
- (void)lsSetRootViewController:(UIViewController *)viewController animationType:(NSString *)animationType animationSubtype:(NSString *)animationSubtype backgroundColor:(UIColor *)backgroundColor;

@end
