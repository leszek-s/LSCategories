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

#import "UIBezierPath+LSCategories.h"

@implementation UIBezierPath (LSCategories)

- (UIImage *)lsImageWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor backgroundColor:(UIColor *)backgroundColor
{
    CGFloat width = ceil(self.bounds.size.width + self.lineWidth * 2);
    CGFloat height = ceil(self.bounds.size.height + self.lineWidth * 2);
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (backgroundColor)
    {
        CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
        CGContextFillRect(context, CGRectMake(0, 0, width, height));
    }
    CGContextTranslateCTM(context, self.lineWidth - self.bounds.origin.x, self.lineWidth - self.bounds.origin.y);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, self.lineCapStyle);
    CGContextSetLineJoin(context, self.lineJoinStyle);
    if (fillColor)
    {
        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
        [self fill];
    }
    if (strokeColor)
    {
        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
        [self stroke];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
