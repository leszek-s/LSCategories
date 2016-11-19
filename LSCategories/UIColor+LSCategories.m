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

#import "UIColor+LSCategories.h"

@implementation UIColor (LSCategories)

- (CGFloat)lsRed
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)lsGreen
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)lsBlue
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)lsAlpha
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return a;
}

- (CGFloat)lsHue
{
    CGFloat h = 0, s = 0, b = 0, a = 0;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (CGFloat)lsSaturation
{
    CGFloat h = 0, s = 0, b = 0, a = 0;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (CGFloat)lsBrightness
{
    CGFloat h = 0, s = 0, b = 0, a = 0;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (uint32_t)lsRgba
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int cr = MIN(MAX(r * 255, 0), 255);
    int cg = MIN(MAX(g * 255, 0), 255);
    int cb = MIN(MAX(b * 255, 0), 255);
    int ca = MIN(MAX(a * 255, 0), 255);
    return (cr << 24) | (cg << 16) | (cb << 8) | ca;
}

- (uint32_t)lsRgb
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int cr = MIN(MAX(r * 255, 0), 255);
    int cg = MIN(MAX(g * 255, 0), 255);
    int cb = MIN(MAX(b * 255, 0), 255);
    return (cr << 16) | (cg << 8) | cb;
}

+ (UIColor *)lsColorWithRgba:(uint32_t)rgba
{
    int r = (rgba >> 24) & 0xFF;
    int g = (rgba >> 16) & 0xFF;
    int b = (rgba >> 8) & 0xFF;
    int a = rgba & 0xFF;
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0];
}

+ (UIColor *)lsColorWithRgb:(uint32_t)rgb
{
    int r = (rgb >> 16) & 0xFF;
    int g = (rgb >> 8) & 0xFF;
    int b = rgb & 0xFF;
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

- (NSString *)lsRgbHexString
{
    uint32_t rgb = [self lsRgb];
    return [[NSString stringWithFormat:@"%06x", rgb] uppercaseString];
}

- (NSString *)lsRgbaHexString
{
    uint32_t rgba = [self lsRgba];
    return [[NSString stringWithFormat:@"%08x", rgba] uppercaseString];
}

+ (UIColor *)lsColorWithHexString:(NSString *)string
{
    NSString *input = [string uppercaseString];
    input = [input stringByReplacingOccurrencesOfString:@"#" withString:@""];
    input = [input stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    
    NSUInteger length = input.length;
    if (length != 3 && length != 4 && length != 6 && length != 8) // RGB, RGBA, RRGGBB, RRGGBBAA
        return nil;
    
    if (length == 3)
        input = [input stringByAppendingString:@"F"];
    
    if (length == 6)
        input = [input stringByAppendingString:@"FF"];
    
    unsigned int number;
    NSScanner *scanner = [NSScanner scannerWithString:input];
    if (![scanner scanHexInt:&number])
        return nil;
    
    int r, g, b, a;
    if (length < 5)
    {
        r = (number >> 12) & 0xF;
        r = r | (r << 4);
        g = (number >> 8) & 0xF;
        g = g | (g << 4);
        b = (number >> 4) & 0xF;
        b = b | (b << 4);
        a = number & 0xF;
        a = a | (a << 4);
    }
    else
    {
        r = (number >> 24) & 0xFF;
        g = (number >> 16) & 0xFF;
        b = (number >> 8) & 0xFF;
        a = number & 0xFF;
    }
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0];
}

- (UIColor *)invertedColor
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    r = MIN(MAX(1 - r, 0), 1);
    g = MIN(MAX(1 - g, 0), 1);
    b = MIN(MAX(1 - b, 0), 1);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)lsRandomColor
{
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
}

@end
