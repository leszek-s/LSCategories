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

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LSCategories)

/**
 Shows global activity indicator in the center of the screen.
 */
+ (void)lsShowSharedActivityIndicator;

/**
 Shows global activity indicator with text in the center of the view. If this method is called multiple times
 then instead of presenting a new activity indicator existing one will be updated.

 @param text Text to show below the activity indicator.
 */
+ (void)lsShowSharedActivityIndicatorWithText:(nullable NSString *)text;

/**
 Shows global activity indicator with custom style in the center of the screen. If this method is called multiple times
 then instead of presenting a new activity indicator existing one will be updated.

 @param style Activity indicator style.
 @param color Activity indicator and text color.
 @param backgroundColor Color of rounded rectangle view behind activity indicator.
 @param coverColor Color of cover view behind activity indicator that will cover the whole screen.
 @param text Text to show below the activity indicator.
 */
+ (void)lsShowSharedActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor text:(nullable NSString *)text;

/**
 Hides global activity indicator showed in the center of the screen.
 */
+ (void)lsHideSharedActivityIndicator;

/**
 Returns shared activity indicator view.

 @return Shared activity indicator view.
 */
+ (nullable UIView *)lsSharedActivityIndicatorView;

/**
 Shows activity indicator in the center of the view.
 */
- (void)lsShowActivityIndicator;

/**
 Shows activity indicator with text in the center of the view. If this method is called multiple times
 then instead of presenting a new activity indicator existing one will be updated.

 @param text Text to show below the activity indicator.
 */
- (void)lsShowActivityIndicatorWithText:(nullable NSString *)text;

/**
 Shows activity indicator with custom style in the center of the view. If this method is called multiple times
 then instead of presenting a new activity indicator existing one will be updated.

 @param style Activity indicator style.
 @param color Activity indicator and text color.
 @param backgroundColor Color of rounded rectangle view behind activity indicator.
 @param coverColor Color of cover view behind activity indicator that will cover the whole view.
 @param text Text to show below the activity indicator.
 */
- (void)lsShowActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor text:(nullable NSString *)text;

/**
 Hides activity indicator showed on the view.
 */
- (void)lsHideActivityIndicator;

/**
 Returns activity indicator view.

 @return Activity indicator view.
 */
- (nullable UIView *)lsActivityIndicatorView;

/**
 Shows global toast with given text on the bottom of the view. If this method
 is called multiple times then instead of presenting a new toast view existing one will be updated.

 @param text Text message.
 */
+ (void)lsShowSharedToastWithText:(NSString *)text;

/**
 Shows shared toast with given text, color, background color, bottom margin and duration. If this method
 is called multiple times then instead of presenting a new toast view existing one will be updated.
 
 @param text Text message.
 @param color Text color.
 @param backgroundColor Background color.
 @param font Font.
 @param margin Margin.
 @param duration Duration.
 */
+ (void)lsShowSharedToastWithText:(NSString *)text color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font margin:(NSInteger)margin duration:(NSTimeInterval)duration;

/**
 Hides shared toast showed on the view.
 */
+ (void)lsHideSharedToast;

/**
 Returns shared toast view.
 
 @return Shared toast view.
 */
+ (nullable UIView *)lsSharedToastView;

/**
 Shows toast with given text on the bottom of the view.

 @param text Text message.
 */
- (void)lsShowToastWithText:(NSString *)text;

/**
 Shows toast with given text, color, background color, bottom margin and duration.

 @param text Text message.
 @param color Text color.
 @param backgroundColor Background color.
 @param font Font.
 @param margin Margin.
 @param duration Duration.
 */
- (void)lsShowToastWithText:(NSString *)text color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font margin:(NSInteger)margin duration:(NSTimeInterval)duration;

/**
 Hides toast showed on the view.
 */
- (void)lsHideToast;

/**
 Returns toast view.

 @return Toast view.
 */
- (nullable UIView *)lsToastView;

/**
 Adds border on top, bottom, left or right with given color and width.

 @param edge Edge on which border should be added.
 @param color Border color.
 @param width Border width.
 */
- (void)lsAddBorderOnEdge:(UIRectEdge)edge color:(UIColor *)color width:(CGFloat)width;

/**
 Adds external border outside of view bounds on top, bottom, left or right with given color and width.

 @param edge Edge on which border should be added.
 @param color Border color.
 @param width Border width.
 */
- (void)lsAddExternalBorderOnEdge:(UIRectEdge)edge color:(UIColor *)color width:(CGFloat)width;

/**
 Removes all borders added on edges.
 */
- (void)lsRemoveBordersOnEdges;

/**
 Rotates the view 360 degrees with given duration.
 
 @param duration Duration of the rotation.
 @param clockwise YES for clockwise rotation, NO otherwise.
 */
- (void)lsRotate360DegreesWithDuration:(CFTimeInterval)duration clockwise:(BOOL)clockwise;

/**
 Starts infinite rotation with given duration of a single rotation.

 @param duration Duration of a single rotation.
 @param clockwise YES for clockwise rotation, NO otherwise.
 */
- (void)lsStartInfiniteRotationWithDuration:(CFTimeInterval)duration clockwise:(BOOL)clockwise;

/**
 Stops infinite rotation.
 */
- (void)lsStopInfiniteRotation;

/**
 Returns snapshot image from view.

 @return Snapshot image from view.
 */
- (nullable UIImage *)lsSnapshotImage;

/**
 Removes all subviews.
 */
- (void)lsRemoveAllSubviews;

/**
 Adds constraints to fit the view to its current superview.
 */
- (void)lsAddStretchInSuperviewConstraints;

/**
 Shows the view as popup similar to alert view.
 
 @param title Title on the popup view.
 @param cancelTitle Cancel button text.
 @param okTitle OK button text.
 @param backgroundColor Popup background color.
 @param titleColor Title color.
 @param cancelColor Cancel button color.
 @param okColor OK button color.
 @param handler Handler to be executed after pressing Cancel or OK button.
 */
- (void)lsShowAsAlertPopupWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor cancelColor:(UIColor *)cancelColor okColor:(UIColor *)okColor handler:(void (^)(BOOL accepted, UIView *view))handler;

/**
 Repeats executing given block with given duration, delay and frames per second.
 Progress parameter in block will have 0.0 value at start and 1.0 value at the end.

 @param duration Duration for how long block should be executed.
 @param delay Delay after which execution should be started.
 @param framesPerSecond Frames per seconds at which block should be repeated.
 @param block Block which should be executed with progress parameter from 0.0 to 1.0.
 @param completionBlock Block which should be executed when finished.
 */
+ (void)lsRepeatWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^ _Nullable)(void))completionBlock;

/**
 Repeats executing given block with given duration and frames per second.
 Progress parameter in block will have 0.0 value at start and 1.0 value at the end.

 @param duration Duration for how long block should be executed.
 @param framesPerSecond Frames per seconds at which block should be repeated.
 @param block Block which should be executed with progress parameter from 0.0 to 1.0.
 @param completionBlock Block which should be executed when finished.
 */
+ (void)lsRepeatWithDuration:(NSTimeInterval)duration framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^ _Nullable)(void))completionBlock;

/**
 Enables hidding keyboard when view is tapped.
 */
- (void)lsEnableHideKeyboardOnTap;

/**
 Returns root superview that is most top parent which does not have any other superview in current view hierarchy.

 @return Root superview.
 */
- (nullable UIView *)lsRootSuperview;

/**
 Returns array of subviews of given class.

 @param class Subview class.
 @param recursive If set to YES then it will return subviews from whole view hierarchy, if set to NO it will return only direct first level subviews.
 @return Array of subviews of given class.
 */
- (NSArray *)lsSubviewsWithClass:(Class)class recursive:(BOOL)recursive;

/**
 Sets x value of frame property.

 @param x Value to set.
 */
- (void)lsSetFrameX:(CGFloat)x;

/**
 Sets y value of frame property.

 @param y Value to set.
 */
- (void)lsSetFrameY:(CGFloat)y;

/**
 Sets width value of frame property.
 
 @param width Value to set.
 */
- (void)lsSetFrameWidth:(CGFloat)width;

/**
 Sets height value of frame property.
 
 @param height Value to set.
 */
- (void)lsSetFrameHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
