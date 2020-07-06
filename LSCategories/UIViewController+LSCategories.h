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

@interface UIViewController (LSCategories)

/**
 Adds a child view controller to given view.

 @param viewController View controller to add as a child.
 @param view Subview to which the view of the child view contoller shoud be added.
 */
- (void)lsAddChildViewController:(UIViewController *)viewController toView:(UIView *)view;

/**
 Removes child view controller from parent view controller.
 */
- (void)lsRemoveFromParentViewController;

/**
 Enables automatic keyboard handling with automatic scroll of scrollviews with text fields, automatic next and done keyboard actions,
 automatic keyboard hidding when tapped outside of a text field.
 */
- (void)lsEnableAutomaticKeyboardHandling;

/**
 Enables automatic keyboard handling with automatic scroll of scrollviews with text fields, automatic primary actions on keyboard,
 automatic keyboard hidding when tapped outside of a text field.
 
 @param automaticNextAndDone If set to YES primary button on keyboard will be changed to next or done and handle switching to next text field or closing the keyboard when there is no other field, if set to NO primary button will always handle hidding the keyboard.
 @param hideOnTapOutside If set to YES then tapping outside of the text field will hide the keyboard.
 */
- (void)lsEnableAutomaticKeyboardHandlingWithAutomaticNextAndDone:(BOOL)automaticNextAndDone hideOnTapOutside:(BOOL)hideOnTapOutside;

@end

NS_ASSUME_NONNULL_END
