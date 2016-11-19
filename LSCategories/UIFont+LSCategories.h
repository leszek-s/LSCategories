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

@interface UIFont (LSCategories)

/**
 Returns normal font with same size.

 @return Normal font with same size.
 */
- (UIFont *)lsNormalFont;

/**
 Returns bold font with same size.

 @return Bold font with same size.
 */
- (UIFont *)lsBoldFont;

/**
 Returns italic font with same size.
 
 @return Italic font with same size.
 */
- (UIFont *)lsItalicFont;

/**
 Returns bold italic font with same size.
 
 @return Bold italic font with same size.
 */
- (UIFont *)lsBoldItalicFont;

/**
 Returns normal font with given size.

 @param size Font size.
 @return Normal font with given size.
 */
- (UIFont *)lsNormalFontWithSize:(CGFloat)size;

/**
 Returns bold font with given size.
 
 @param size Font size.
 @return Bold font with given size.
 */
- (UIFont *)lsBoldFontWithSize:(CGFloat)size;

/**
 Returns italic font with given size.
 
 @param size Font size.
 @return Italic font with given size.
 */
- (UIFont *)lsItalicFontWithSize:(CGFloat)size;

/**
 Returns bold italic font with given size.
 
 @param size Font size.
 @return Bold italic font with given size.
 */
- (UIFont *)lsBoldItalicFontWithSize:(CGFloat)size;

@end
