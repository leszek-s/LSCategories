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

@interface UINavigationController (LSCategories)

/**
 Pushes a view controller with a completion block.

 @param viewController View controller to push.
 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after push.
 */
- (void)lsPushViewController:(UIViewController *)viewController animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Pops a view controller with a completion block.

 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after pop.
 @return The view controller that was popped.
 */
- (UIViewController *)lsPopViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Pops to given view controller with a completion block.

 @param viewController View controller to which navigation should pop.
 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after pop.
 @return An array of view controllers that were popped.
 */
- (NSArray *)lsPopToViewController:(UIViewController *)viewController animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Pops to root view controller with a completion block.

 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after pop.
 @return An array of view controllers that were popped.
 */
- (NSArray *)lsPopToRootViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Pops to last view controller of given class with a completion block.

 @param class Class of view controller to which navigation should pop.
 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after pop.
 @return An array of view controllers that were popped.
 */
- (NSArray *)lsPopToLastViewControllerWithClass:(Class)class animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Sets view controllers with a completion block.

 @param viewControllers Array of view controllers to set.
 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after set.
 */
- (void)lsSetViewControllers:(NSArray *)viewControllers animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

@end
