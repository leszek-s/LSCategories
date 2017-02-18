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

#import "UIView+LSCategories.h"

@implementation UIView (LSCategories)

#define lsUItag 0x6c735549
#define lsAItag 0x6c734149

- (void)lsShowActivityIndicator
{
    [self lsShowActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge color:[UIColor whiteColor] backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] coverColor:[UIColor clearColor]];
}

- (void)lsShowActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [activityIndicator startAnimating];
    activityIndicator.color = color;
    activityIndicator.center = [self convertPoint:self.center fromView:self.superview];
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    activityIndicator.tag = lsAItag;
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, activityIndicator.bounds.size.width * 2, activityIndicator.bounds.size.height * 2)];
    background.layer.cornerRadius = 6;
    background.backgroundColor = backgroundColor;
    background.center = [self convertPoint:self.center fromView:self.superview];
    background.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    background.tag = lsAItag;
    
    UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
    cover.backgroundColor = coverColor;
    cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cover.tag = lsAItag;
    
    [self addSubview:cover];
    [self addSubview:background];
    [self addSubview:activityIndicator];
}

- (void)lsHideActivityIndicator
{
    NSMutableArray *views = [NSMutableArray new];
    for (UIView *view in self.subviews)
    {
        if (view.tag == lsAItag)
            [views addObject:view];
    }
    for (UIView *view in views)
    {
        [view removeFromSuperview];
    }
}

- (void)lsAddBorderOnEdge:(UIRectEdge)edge color:(UIColor *)color width:(CGFloat)width
{
    UIView *border = [UIView new];
    border.tag = lsUItag;
    border.backgroundColor = color;
    switch (edge)
    {
        case UIRectEdgeTop:
            border.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            border.frame = CGRectMake(0, 0, self.frame.size.width, width);
            break;
        case UIRectEdgeBottom:
            border.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
            break;
        case UIRectEdgeLeft:
            border.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
            border.frame = CGRectMake(0, 0, width, self.frame.size.height);
            break;
        case UIRectEdgeRight:
            border.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
            border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
            break;
        default:
            break;
    }
    [self addSubview:border];
}

- (void)lsRemoveBordersOnEdges
{
    NSMutableArray *borders = [NSMutableArray new];
    for (UIView *view in self.subviews)
    {
        if (view.tag == lsUItag)
            [borders addObject:view];
    }
    for (UIView *view in borders)
    {
        [view removeFromSuperview];
    }
}

- (void)lsStartInfiniteRotationWithDuration:(CFTimeInterval)duration clockwise:(BOOL)clockwise
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = clockwise ? @0 : @(2 * M_PI);
    rotationAnimation.toValue = clockwise ? @(2 * M_PI) : @0;
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"lsRotationAnimation"];
}

- (void)lsStopInfiniteRotation
{
    [self.layer removeAnimationForKey:@"lsRotationAnimation"];
}

- (UIImage *)lsSnapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)lsRemoveAllSubviews
{
    NSArray *viewsToRemove = self.subviews;
    for (UIView *view in viewsToRemove)
        [view removeFromSuperview];
}

- (void)lsAddStretchInSuperviewConstraints
{
    UIView *superview = self.superview;
    if (!superview)
        return;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}

+ (void)lsRepeatWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^)(void))completionBlock
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self lsRepeatWithDuration:duration framesPerSecond:framesPerSecond block:block completionBlock:completionBlock];
    });
}

+ (void)lsRepeatWithDuration:(NSTimeInterval)duration framesPerSecond:(CGFloat)framesPerSecond block:(void (^)(CGFloat progress))block completionBlock:(void (^)(void))completionBlock
{
    if (!block)
        return;
    
    CGFloat frameTime = ABS(1.0 / framesPerSecond);
    NSDate *startDate = [NSDate new];
    __block CGFloat progress = 0.0;
    
    block(progress);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, frameTime * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        NSDate *date = [NSDate new];
        NSTimeInterval interval = [date timeIntervalSinceDate:startDate];
        progress = MIN(1.0, ABS(interval / duration));
        block(progress);
        if (progress >= 1.0)
        {
            dispatch_source_cancel(timer);
            if (completionBlock)
                completionBlock();
        }
    });
    dispatch_resume(timer);
}

- (void)lsSetFrameX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)lsSetFrameY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)lsSetFrameWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)lsSetFrameHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

@end
