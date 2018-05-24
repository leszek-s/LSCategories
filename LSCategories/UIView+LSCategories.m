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
#import "UIControl+LSCategories.h"

@implementation UIView (LSCategories)

#define lsUItag 0x6c735549
#define lsAItag 0x6c734149
#define lsTOtag 0x6c73544f

static NSInteger lsSharedHudCounter = 0;
static UIView *lsSharedHudView = nil;
static UIView *lsSharedToastView = nil;

+ (void)lsShowSharedActivityIndicator
{
    [self lsShowSharedActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge color:[UIColor whiteColor] backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] coverColor:[UIColor clearColor] text:nil];
}

+ (void)lsShowSharedActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor text:(NSString *)text
{
    lsSharedHudCounter++;
    if (lsSharedHudView)
        return;
    
    UIView *hv = [[UIApplication sharedApplication] keyWindow];
    if (hv)
    {
        lsSharedHudView = hv;
        [hv lsShowActivityIndicatorWithStyle:style color:color backgroundColor:backgroundColor coverColor:coverColor text:text];
    }
}

+ (void)lsHideSharedActivityIndicator
{
    lsSharedHudCounter--;
    if (lsSharedHudCounter < 0)
        lsSharedHudCounter = 0;
    
    if (lsSharedHudCounter != 0)
        return;
    
    if (lsSharedHudView)
    {
        [lsSharedHudView lsHideActivityIndicator];
        lsSharedHudView = nil;
    }
}

+ (UIView *)lsSharedActivityIndicatorView
{
    return [lsSharedHudView lsActivityIndicatorView];
}

- (void)lsShowActivityIndicator
{
    [self lsShowActivityIndicatorWithText:nil];
}

- (void)lsShowActivityIndicatorWithText:(NSString *)text
{
    [self lsShowActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge color:[UIColor whiteColor] backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] coverColor:[UIColor clearColor] text:text];
}

- (void)lsShowActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor coverColor:(UIColor *)coverColor text:(NSString *)text
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [activityIndicator startAnimating];
    activityIndicator.color = color;
    activityIndicator.center = [self convertPoint:self.center fromView:self.superview];
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    activityIndicator.tag = lsAItag;
    
    UILabel *label = [UILabel new];
    CGFloat margin = 16;
    label.text = text;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = color;
    [label sizeToFit];
    label.center = CGPointMake(activityIndicator.center.x, activityIndicator.center.y + activityIndicator.bounds.size.height / 2 + label.bounds.size.height / 2 + margin);
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    label.tag = lsAItag;
    
    CGRect bgRect = CGRectMake(MIN(label.frame.origin.x, activityIndicator.frame.origin.x) - margin, activityIndicator.frame.origin.y - margin, MAX(label.frame.size.width + margin + margin, activityIndicator.frame.size.width + margin + margin), margin + activityIndicator.frame.size.height + (label.text.length > 0 ? margin : 0) + label.frame.size.height + margin);
    UIView *background = [[UIView alloc] initWithFrame:bgRect];
    background.layer.cornerRadius = 6;
    background.backgroundColor = backgroundColor;
    background.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    background.tag = lsAItag;
    
    UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
    cover.backgroundColor = coverColor;
    cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cover.tag = lsAItag;
    
    [self addSubview:cover];
    [cover addSubview:background];
    [background addSubview:activityIndicator];
    [background addSubview:label];
    activityIndicator.center = [self convertPoint:activityIndicator.center toView:background];
    label.center = [self convertPoint:label.center toView:background];
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

- (UIView *)lsActivityIndicatorView
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == lsAItag)
            return view;
    }
    return nil;
}

+ (void)lsShowSharedToastWithText:(NSString *)text
{
    [self lsShowSharedToastWithText:text color:[UIColor whiteColor] backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] margin:40 duration:2.5];
}

+ (void)lsShowSharedToastWithText:(NSString *)text color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor margin:(NSInteger)margin duration:(NSTimeInterval)duration
{
    UIView *tv = [[UIApplication sharedApplication] keyWindow];
    if (tv)
    {
        lsSharedToastView = tv;
        [tv lsShowToastWithText:text color:color backgroundColor:backgroundColor margin:margin duration:duration];
    }
}

+ (void)lsHideSharedToast
{
    if (lsSharedToastView)
    {
        [lsSharedToastView lsHideToast];
        lsSharedToastView = nil;
    }
}

+ (UIView *)lsSharedToastView
{
    return [lsSharedToastView lsToastView];
}

- (void)lsShowToastWithText:(NSString *)text
{
    [self lsShowToastWithText:text color:[UIColor whiteColor] backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] margin:40 duration:2.5];
}

- (void)lsShowToastWithText:(NSString *)text color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor margin:(NSInteger)margin duration:(NSTimeInterval)duration
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = color;
    label.backgroundColor = backgroundColor;
    label.layer.cornerRadius = 6;
    label.clipsToBounds = YES;
    [label sizeToFit];
    label.bounds = CGRectInset(label.bounds, -12, -12);
    label.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - label.bounds.size.height / 2 - margin);
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    label.tag = lsTOtag;
    [self addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

- (void)lsHideToast
{
    NSMutableArray *views = [NSMutableArray new];
    for (UIView *view in self.subviews)
    {
        if (view.tag == lsTOtag)
            [views addObject:view];
    }
    for (UIView *view in views)
    {
        [view removeFromSuperview];
    }
}

- (UIView *)lsToastView
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == lsTOtag)
            return view;
    }
    return nil;
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

- (void)lsRotate360DegreesWithDuration:(CFTimeInterval)duration clockwise:(BOOL)clockwise
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = clockwise ? @0 : @(2 * M_PI);
    rotationAnimation.toValue = clockwise ? @(2 * M_PI) : @0;
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"ls360RotationAnimation"];
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

- (void)lsShowAsAlertPopupWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor cancelColor:(UIColor *)cancelColor okColor:(UIColor *)okColor handler:(void (^)(BOOL accepted, UIView *view))handler
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    
    UIView *cover = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds];
    cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *control = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 290)];
    control.backgroundColor = backgroundColor;
    control.layer.cornerRadius = 16;
    control.clipsToBounds = YES;
    control.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2);
    control.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 40)];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    self.frame = CGRectMake(0, 30, 270, 216);
    
    UIView *separatorH = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 216, 270, 0.5)];
    separatorH.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    UIView *separatorV = [[UIView alloc] initWithFrame:CGRectMake(270 / 2, 30 + 216, 0.5, 44)];
    separatorV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(0, 30 + 216, 270 / 2, 44);
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancel setTitle:cancelTitle forState:UIControlStateNormal];
    [cancel setTitleColor:cancelColor forState:UIControlStateNormal];
    
    UIButton *ok = [UIButton buttonWithType:UIButtonTypeSystem];
    ok.frame = CGRectMake(270 / 2, 30 + 216, 270 / 2, 44);
    ok.titleLabel.font = [UIFont systemFontOfSize:18];
    [ok setTitle:okTitle forState:UIControlStateNormal];
    [ok setTitleColor:okColor forState:UIControlStateNormal];
    
    [cancel lsAddControlEvent:UIControlEventTouchUpInside handler:^(id sender) {
        cover.alpha = 1;
        [UIView animateWithDuration:0.1 animations:^{
            cover.alpha = 0;
        } completion:^(BOOL finished) {
            [cover removeFromSuperview];
            if (handler)
                handler(NO, self);
            [cancel lsRemoveAllControlEventHandlers];
            [ok lsRemoveAllControlEventHandlers];
        }];
    }];
    [ok lsAddControlEvent:UIControlEventTouchUpInside handler:^(id sender) {
        cover.alpha = 1;
        [UIView animateWithDuration:0.1 animations:^{
            cover.alpha = 0;
        } completion:^(BOOL finished) {
            [cover removeFromSuperview];
            if (handler)
                handler(YES, self);
            [cancel lsRemoveAllControlEventHandlers];
            [ok lsRemoveAllControlEventHandlers];
        }];
    }];
    
    [cover addSubview:control];
    [control addSubview:label];
    [control addSubview:self];
    [control addSubview:separatorH];
    [control addSubview:separatorV];
    [control addSubview:cancel];
    [control addSubview:ok];
    [view addSubview:cover];
    
    cover.alpha = 0;
    control.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.1 animations:^{
        control.transform = CGAffineTransformMakeScale(1, 1);
        cover.alpha = 1;
    }];
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

