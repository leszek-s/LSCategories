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

@interface UIDatePicker (LSCategories)

/**
 Shows date picker as popup similar to alert view.

 @param title Title on the popup view.
 @param cancelTitle Cancel button text.
 @param okTitle OK button text.
 @param backgroundColor Popup background color.
 @param titleColor Title color.
 @param cancelColor Cancel button color.
 @param okColor OK button color.
 @param handler Handler to be executed after pressing Cancel or OK button.
 */
- (void)lsShowAsPopupWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor cancelColor:(UIColor *)cancelColor okColor:(UIColor *)okColor handler:(void (^)(BOOL accepted, NSDate *date))handler;

@end

NS_ASSUME_NONNULL_END
