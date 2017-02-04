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

#import "UIImage+LSCategories.h"
#import "NSData+LSCategories.h"

@implementation UIImage (LSCategories)

+ (void)lsImageFromUrl:(NSURL *)url useCache:(BOOL)useCache handler:(void (^)(UIImage *image, NSError *error))handler
{
    if (!handler || !url)
    {
        if (handler)
            handler(nil, nil);
        return;
    }
    
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSCache new];
        cache.totalCostLimit = 1024 * 1024 * 30;
    });
    UIImage *cached = [cache objectForKey:url];
    if (useCache && cached)
    {
        handler(cached, nil);
    }
    else
    {
        [NSData lsDataFromUrl:url handler:^(NSData *data, NSError *error) {
            UIImage *image = data ? [UIImage imageWithData:data] : nil;
            if (image && useCache)
                [cache setObject:image forKey:url cost:data.length];
            handler(image, error);
        }];
    }
}

+ (UIImage *)lsImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.height < 1 || size.width < 1)
        return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)lsTriangleImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.height < 1 || size.width < 1)
        return nil;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, size.width * 0.5, 0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)lsGradientImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    if (!startColor || !endColor)
        return nil;
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsRotatedImageWithRadians:(CGFloat)radians
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    CGRect rect = CGRectApplyAffineTransform(CGRectMake(0, 0, self.size.width, self.size.height), transform);
    CGSize size = CGSizeMake(round(rect.size.width), round(rect.size.height));
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, size.width / 2.0, size.height / 2.0);
    CGContextRotateCTM(context, radians);
    [self drawInRect:CGRectMake(-self.size.width / 2.0, -self.size.height / 2.0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsResizedImageWithSize:(CGSize)size
{
    if (size.height < 1 || size.width < 1)
        return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsResizedProportionalImageWithMaxSize:(CGSize)size
{
    CGFloat aspectWidth = size.width / self.size.width;
    CGFloat aspectHeight = size.height / self.size.height;
    CGFloat aspectRatio = MIN(aspectWidth, aspectHeight);
    return [self lsResizedImageWithSize:CGSizeMake(self.size.width * aspectRatio, self.size.height * aspectRatio)];
}

- (UIImage *)lsResizedProportionalImageWithHeight:(CGFloat)height
{
    CGFloat width = self.size.width * height / self.size.height;
    return [self lsResizedImageWithSize:CGSizeMake(width, height)];
}

- (UIImage *)lsResizedProportionalImageWithWidth:(CGFloat)width
{
    CGFloat height = self.size.height * width / self.size.width;
    return [self lsResizedImageWithSize:CGSizeMake(width, height)];
}

- (NSData *)lsPNG
{
    return UIImagePNGRepresentation(self);
}

- (NSData *)lsJPEGWithCompressionLevel:(CGFloat)compressionQuality
{
    return UIImageJPEGRepresentation(self, compressionQuality);
}

- (NSData *)lsJPEGWithDesiredMaxSize:(NSUInteger)maxSize allowAboveMax:(BOOL)allowAboveMax
{
    CGFloat compressionQuality = 0.9;
    NSData *data = UIImageJPEGRepresentation(self, compressionQuality);
    while (data.length > maxSize && compressionQuality > 0.05)
    {
        compressionQuality -= 0.05;
        data = UIImageJPEGRepresentation(self, compressionQuality);
    }
    if (data.length > maxSize && !allowAboveMax)
        return nil;
    return data;
}

- (NSData *)lsRGBARawPixelsData
{
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *)calloc(height * width * bytesPerPixel, 1);
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    return [NSData dataWithBytesNoCopy:rawData length:height * width * bytesPerPixel];
}

- (UIColor *)lsColorAtPixel:(CGPoint)pixel
{
    NSData *pixelData = [self lsRGBARawPixelsData];
    unsigned char *bytes = (unsigned char *)pixelData.bytes;
    NSUInteger width = CGImageGetWidth(self.CGImage);
    NSUInteger pixelIndex = ((NSUInteger)pixel.y * width + (NSUInteger)pixel.x) * 4;
    if (pixelIndex + 3 >= pixelData.length)
        return nil;
    return [UIColor colorWithRed:bytes[pixelIndex] / 255.0 green:bytes[pixelIndex + 1] / 255.0 blue:bytes[pixelIndex + 2] / 255.0 alpha:bytes[pixelIndex + 3] / 255.0];
}

- (UIColor *)lsAverageColor
{
    UIImage *image = [self lsResizedImageWithSize:CGSizeMake(1, 1)];
    return [image lsColorAtPixel:CGPointMake(0, 0)];
}

@end
