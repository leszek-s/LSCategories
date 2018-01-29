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

@interface UIView (LSCategories)

/**
 Shows global activity indicator in the center of the screen.
 */
+ (void)lsShowSharedActivityIndicator;

/**
 Hides global activity indicator showed in the center of the screen.
 */
+ (void)lsHideSharedActivityIndicator;

/**
 Shows activity indicator in the center of the view.
 */
- (void)lsShowActivityIndicator;

/**
 Shows activity indicator with text in the center of the view.

 @param text Text to show below the activity indicator.
 */
- (void)lsShowActivityIndicatorWithText:(NSString *)text;

/**
 Shows activity indicator with custom style in the center of the view.

 @param style Activity indicator style.
 @param color Activity indicator and text color.
 @param backgroundColor Color of rounded rectangle view behind activity indicator.
 @param coverColor Color of cover view behind activity indicator that will cover the whole view.
 @param text Text to show below the activity indicator.
 */
- (void)lsShowActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor text:(NSString *)text;
/**
 Hides activity indicator showed on the view.
 */
- (void)lsHideActivityIndicator;

/**
 Adds border on top, bottom, left or right with given color and width.

 @param edge Edge on which border should be added.
 @param color Border color.
 @param width Border width.
 */
- (void)lsAddBorderOnEdge:(UIRectEdge)edge color:(UIColor *)color width:(CGFloat)width;

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
- (UIImage *)lsSnapshotImage;

/**
 Removes all subviews.
 */
- (void)lsRemoveAllSubviews;

/**
 Adds constraints to fit the view to its current superview.
 */
- (void)lsAddStretchInSuperviewConstraints;

/**
 Repeats executing given block with given duration, delay and frames per second.
 Progress parameter in block will have 0.0 value at start and 1.0 value at the end.

 @param duration Duration for how long block should be executed.
 @param delay Delay after which execution should be started.
 @param framesPerSecond Frames per seconds at which block should be repeated.
 @param block Block which should be executed with progress parameter from 0.0 to 1.0.
 @param completionBlock Block which should be executed when finished.
 */
+ (void)lsRepeatWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^)(void))completionBlock;

/**
 Repeats executing given block with given duration and frames per second.
 Progress parameter in block will have 0.0 value at start and 1.0 value at the end.

 @param duration Duration for how long block should be executed.
 @param framesPerSecond Frames per seconds at which block should be repeated.
 @param block Block which should be executed with progress parameter from 0.0 to 1.0.
 @param completionBlock Block which should be executed when finished.
 */
+ (void)lsRepeatWithDuration:(NSTimeInterval)duration framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^)(void))completionBlock;

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
