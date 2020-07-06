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

@interface UITextField (LSCategories)

/**
 Sets a placeholder text with given color.

 @param placeholder Placeholder text.
 @param color Placeholder color.
 */
- (void)lsSetPlaceholder:(NSString *)placeholder color:(UIColor *)color;

/**
 Sets the maximum text length.
 
 @param maxLength Maximum text length.
 */
- (void)lsSetMaxLength:(NSInteger)maxLength;

/**
 Sets the allowed characters set.
 
 @param allowedCharacterSet Allowed characters set.
 */
- (void)lsSetAllowedCharacterSet:(NSCharacterSet *)allowedCharacterSet;

/**
 Sets regular expression which specifies what can be entered in the field.

 @param regex Regular expression which specifies what can be entered in the field.
 */
- (void)lsSetAllowedRegex:(NSString *)regex;

/**
 Sets the field in decimal mode for entering numbers only.

 @param integerPart Size of the integer part (numbers before decimal point).
 @param fractionalPart Size of the fractional part (numbers after decimal point).
 */
- (void)lsSetAllowedDecimalsWithIntegerPart:(NSInteger)integerPart fractionalPart:(NSInteger)fractionalPart;

/**
 Sets left padding for text.
 
 @param leftPadding Left padding for text.
 */
- (void)lsSetLeftPadding:(CGFloat)leftPadding;

/**
 Sets right padding for text.
 
 @param rightPadding Right padding for text.
 */
- (void)lsSetRightPadding:(CGFloat)rightPadding;

/**
 Sets clear button color and mode.
 
 @param color Clear button color.
 @param mode Clear button mode.
 */
- (void)lsSetClearButtonWithColor:(UIColor *)color mode:(UITextFieldViewMode)mode;

/**
 Sets clear button image and mode.
 
 @param image Clear button image.
 @param mode Clear button mode.
 */
- (void)lsSetClearButtonWithImage:(UIImage *)image mode:(UITextFieldViewMode)mode;

/**
 Enables automatic action for return button on keyboard to close the keyboard.
 */
- (void)lsEnableAutomaticReturnButtonOnKeyboard;

/**
 Enables automatic action for primary keyboard button which will depend on the position of the text field on current window.
 If there is another text field below the current one then this automatic action will move the focus to the next field.
 If there is no other text field below the current one then this automatic action will close the keyboard.
 */
- (void)lsEnableAutomaticNextAndDoneButtonsOnKeyboard;

@end

NS_ASSUME_NONNULL_END
