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

@interface UIColor (LSCategories)

/**
 Returns red value.

 @return Red value.
 */
- (CGFloat)lsRed;

/**
 Returns green value.
 
 @return Green value.
 */
- (CGFloat)lsGreen;

/**
 Returns blue value.
 
 @return Blue value.
 */
- (CGFloat)lsBlue;

/**
 Returns alpha value.
 
 @return Alpha value.
 */
- (CGFloat)lsAlpha;

/**
 Returns hue value.
 
 @return Hue value.
 */
- (CGFloat)lsHue;

/**
 Returns saturation value.
 
 @return Saturation value.
 */
- (CGFloat)lsSaturation;

/**
 Returns brightness value.
 
 @return Brightness value.
 */
- (CGFloat)lsBrightness;

/**
 Returns RGBA value.

 @return RGBA value.
 */
- (uint32_t)lsRgba;

/**
 Returns RGB value.

 @return RGB value.
 */
- (uint32_t)lsRgb;

/**
 Returns UIColor from RGBA value.

 @param rgba RGBA value.
 @return UIColor from RGBA value.
 */
+ (UIColor *)lsColorWithRgba:(uint32_t)rgba;

/**
 Returns UIColor from RGB value.
 
 @param rgb RGB value.
 @return UIColor from RGB value.
 */
+ (UIColor *)lsColorWithRgb:(uint32_t)rgb;

/**
 Returns RGB hex string (without prefixes for example 00FF00 for green).

 @return RGB hex string.
 */
- (NSString *)lsRgbHexString;

/**
 Returns RGBA hex string (without prefixes for example 00FF00FF for green).
 
 @return RGB hex string.
 */
- (NSString *)lsRgbaHexString;

/**
 Returns UIColor from hex string. Supports strings with optional prefixes: #, 0x, 0X and formats: RGB, RGBA, RRGGBB, RRGGBBAA.

 @param string String with hex color.
 @return UIColor from hex string.
 */
+ (nullable UIColor *)lsColorWithHexString:(NSString *)string;

/**
 Returns inverted color.

 @return Inverted color.
 */
- (UIColor *)lsInvertedColor;

/**
 Returns random color.

 @return Random color.
 */
+ (UIColor *)lsRandomColor;

@end

NS_ASSUME_NONNULL_END
