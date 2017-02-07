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

#import "UINavigationController+LSCategories.h"

@implementation UINavigationController (LSCategories)

- (void)lsPushViewController:(UIViewController *)viewController animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    [self pushViewController:viewController animated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
}

- (UIViewController *)lsPopViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    UIViewController *viewController = [self popViewControllerAnimated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
    return viewController;
}

- (NSArray *)lsPopToViewController:(UIViewController *)viewController animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    NSArray *viewControllers = [self popToViewController:viewController animated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
    return viewControllers;
}

- (NSArray *)lsPopToRootViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    NSArray *viewControllers = [self popToRootViewControllerAnimated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
    return viewControllers;
}

- (NSArray *)lsPopToLastViewControllerWithClass:(Class)class animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    for (UIViewController *viewController in [self.viewControllers reverseObjectEnumerator])
    {
        if ([viewController isKindOfClass:class])
        {
            return [self lsPopToViewController:viewController animated:animated completionBlock:completionBlock];
        }
    }
    return nil;
}

- (void)lsSetViewControllers:(NSArray *)viewControllers animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    [self setViewControllers:viewControllers animated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
}

- (void)lsPerformAfterTransitionAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    if (animated && self.transitionCoordinator)
    {
        [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            if (completionBlock)
                completionBlock();
        }];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock)
                completionBlock();
        });
    }
}

@end
