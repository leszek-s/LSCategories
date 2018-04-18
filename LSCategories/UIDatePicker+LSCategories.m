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

#import "UIDatePicker+LSCategories.h"
#import "UIControl+LSCategories.h"

@implementation UIDatePicker (LSCategories)

- (void)lsShowAsPopupWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor cancelColor:(UIColor *)cancelColor okColor:(UIColor *)okColor handler:(void (^)(BOOL accepted, NSDate *date))handler;
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
    
    UIDatePicker *picker = self;
    picker.frame = CGRectMake(0, 30, 270, 216);
    
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
                handler(NO, picker.date);
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
                handler(YES, picker.date);
            [cancel lsRemoveAllControlEventHandlers];
            [ok lsRemoveAllControlEventHandlers];
        }];
    }];
    
    [cover addSubview:control];
    [control addSubview:label];
    [control addSubview:picker];
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

@end
