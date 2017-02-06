//
//  UINavigationController+LSCategories.h
//  TestProject
//
//  Created by Leszek on 05.02.2017.
//  Copyright © 2017 LS. All rights reserved.
//

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
 Pops to root view controller with a completion block.

 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after pop.
 @return An array of view controllers that were popped.
 */
- (NSArray *)lsPopToRootViewControllerAnimated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

/**
 Sets view controllers with a completion block.

 @param viewControllers Array of view controllers to set.
 @param animated YES to use animation, NO otherwise.
 @param completionBlock Block which should be executed after set.
 */
- (void)lsSetViewControllers:(NSArray *)viewControllers animated:(BOOL)animated completionBlock:(void (^)(void))completionBlock;

@end
