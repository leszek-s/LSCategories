//
//  UINavigationController+LSCategories.m
//  TestProject
//
//  Created by Leszek on 05.02.2017.
//  Copyright © 2017 LS. All rights reserved.
//

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

- (NSArray *)lsPopToRootViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock
{
    NSArray *viewControllers = [self popToRootViewControllerAnimated:animated];
    [self lsPerformAfterTransitionAnimated:animated completionBlock:completionBlock];
    return viewControllers;
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
