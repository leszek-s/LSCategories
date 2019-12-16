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
#import "NSString+LSCategories.h"
#import "UIColor+LSCategories.h"

@implementation UIImage (LSCategories)

+ (void)lsImageFromUrl:(NSURL *)url useCache:(BOOL)useCache useDiskCache:(BOOL)useDiskCache handler:(void (^)(UIImage *image, NSError *error))handler
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
        return;
    }
    if (useDiskCache)
    {
        NSString *cacheFileName = [NSString stringWithFormat:@"img-%@", url.absoluteString.lsMD5];
        NSData *data = [NSData lsReadDataFromDirectory:NSCachesDirectory subDirectory:@"LSIMGCACHE" fileName:cacheFileName];
        if (data != nil)
        {
            UIImage *image = [UIImage imageWithData:data];
            if (image)
            {
                if (useCache)
                    [cache setObject:image forKey:url cost:data.length];
                handler(image, nil);
                return;
            }
        }
    }
    
    [NSData lsDataFromUrl:url handler:^(NSData *data, NSError *error) {
        UIImage *image = data ? [UIImage imageWithData:data] : nil;
        if (image && useCache)
            [cache setObject:image forKey:url cost:data.length];
        if (image && useDiskCache)
        {
            NSString *cacheFileName = [NSString stringWithFormat:@"img-%@", url.absoluteString.lsMD5];
            [data lsSaveToDirectory:NSCachesDirectory subDirectory:@"LSIMGCACHE" fileName:cacheFileName useExcludeFromBackup:YES];
        }
        handler(image, error);
    }];
}

+ (BOOL)lsCleanDiskCache
{
    return [NSData lsCleanDirectory:NSCachesDirectory subDirectory:@"LSIMGCACHE"];
}

+ (UIImage *)lsImageWithColor:(UIColor *)color
{
    return [self lsImageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)lsImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.height < 1 || size.width < 1)
        return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
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
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
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

+ (UIImage *)lsEllipseImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.height < 1 || size.width < 1)
        return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
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
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)lsInitialsAvatarImageWithText:(NSString *)text
{
    NSString *filtered = [text lsStringByRemovingNonAlphanumericAndNonWhitespace];
    NSArray *words = [filtered componentsSeparatedByString:@" "];
    NSString *first = words.count > 0 && [words[0] length] > 0 ? [words[0] substringToIndex:1] : @"";
    NSString *second = words.count > 1 && [words[1] length] > 0 ? [words[1] substringToIndex:1] : @"";
    NSString *initials = [NSString stringWithFormat:@"%@%@", [first uppercaseString], [second uppercaseString]];
    UIColor *color = [UIColor lsColorWithHexString:[[text lsMD5] substringToIndex:6]];
    UIColor *backgroundColor = [UIColor colorWithHue:color.lsHue saturation:0.3 brightness:0.9 alpha:1.0];
    return [self lsImageWithText:initials textColor:[UIColor whiteColor] backgroundColor:backgroundColor font:[UIFont boldSystemFontOfSize:150] size:CGSizeMake(300, 300)];
}

+ (UIImage *)lsImageWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font size:(CGSize)size
{
    if (!text || !textColor || !backgroundColor || !font || size.height < 1 || size.width < 1)
        return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, rect);
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    style.minimumLineHeight = size.height / 2.0 + font.lineHeight / 2.0;
    [text drawInRect:rect withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:style}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)lsAnimatedImageWithAnimatedImageData:(NSData *)animatedImageData framesPerSecond:(CGFloat)framesPerSecond
{
    if (!animatedImageData)
        return nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)animatedImageData, nil);
    if (!imageSource)
        return nil;
    size_t count = CGImageSourceGetCount(imageSource);
    NSMutableArray *images = [NSMutableArray new];
    
    for (size_t i = 0; i < count; i++)
    {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
        if (!cgImage)
            continue;
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [images addObject:image];
        CGImageRelease(cgImage);
    }
    
    CFRelease(imageSource);
    return [UIImage animatedImageWithImages:images duration:images.count / framesPerSecond];
}

+ (UIImage *)lsAnimatedImageWithAnimatedImageName:(NSString *)animatedImageName framesPerSecond:(CGFloat)framesPerSecond bundle:(NSBundle *)bundle
{
    NSDataAsset *asset = [[NSDataAsset alloc] initWithName:animatedImageName];
    NSData *data = asset.data;
    NSBundle *imageBundle = bundle ? bundle : [NSBundle mainBundle];
    
    if (!data)
    {
        data = [NSData dataWithContentsOfURL:[imageBundle URLForResource:animatedImageName withExtension:@"gif"]];
    }
    if (!data)
    {
        data = [NSData dataWithContentsOfURL:[imageBundle URLForResource:animatedImageName withExtension:@"png"]];
    }
    if (!data)
    {
        data = [NSData dataWithContentsOfURL:[imageBundle URLForResource:animatedImageName withExtension:@""]];
    }
    
    return [self lsAnimatedImageWithAnimatedImageData:data framesPerSecond:framesPerSecond];
}

- (UIImage *)lsRotatedImageWithDegrees:(CGFloat)degrees
{
    return [self lsRotatedImageWithRadians:degrees / 180.0 * M_PI];
}

- (UIImage *)lsRotatedImageWithRadians:(CGFloat)radians
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    CGRect rect = CGRectApplyAffineTransform(CGRectMake(0, 0, self.size.width, self.size.height), transform);
    CGSize size = CGSizeMake(round(rect.size.width), round(rect.size.height));
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, size.width / 2.0, size.height / 2.0);
    CGContextRotateCTM(context, radians);
    [self drawInRect:CGRectMake(-self.size.width / 2.0, -self.size.height / 2.0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsImageFlippedHorizontally
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.size.width, 0.0);
    CGContextScaleCTM(context, -1.0, 1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsImageFlippedVertically
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
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

- (UIImage *)lsResizedProportionalImageWithMinSize:(CGSize)size
{
    CGFloat aspectWidth = size.width / self.size.width;
    CGFloat aspectHeight = size.height / self.size.height;
    CGFloat aspectRatio = MAX(aspectWidth, aspectHeight);
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

- (UIImage *)lsCroppedImageWithRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    [self drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsCroppedImageWithInsets:(UIEdgeInsets)insets
{
    CGRect rect = CGRectMake(insets.left, insets.top, self.size.width - insets.left - insets.right, self.size.height - insets.top - insets.bottom);
    return [self lsCroppedImageWithRect:rect];
}

- (UIImage *)lsPaddedImageWithInsets:(UIEdgeInsets)insets
{
    return [self lsCroppedImageWithInsets:UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right)];
}

- (UIImage *)lsMaskedImageWithMaskImage:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef masked = CGImageCreateWithMask(self.CGImage, mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(mask);
    CGImageRelease(masked);
    return maskedImage;
}

- (UIImage *)lsMergedImageWithImage:(UIImage *)image position:(CGPoint)position
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawAtPoint:CGPointMake(0, 0)];
    [image drawAtPoint:position];
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mergedImage;
}

- (UIImage *)lsRoundedImageWithCornerRadius:(CGFloat)cornerRadius
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:cornerRadius] addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsInvertedImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsInvertedAlphaMaskImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeXOR);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lsTintedImageWithColor:(UIColor *)color
{
    if (!self.CGImage)
        return nil;
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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

+ (UIImage *)lsImageWithRGBARawData:(NSData *)rgbaRawData size:(CGSize)size
{
    if (rgbaRawData.length % 4 || rgbaRawData.length == 0 || rgbaRawData.length != size.width * size.height * 4)
        return nil;
    
    NSUInteger bitsPerComponent = 8;
    NSUInteger bitsPerPixel = 32;
    NSUInteger bytesPerRow = 4 * size.width;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, rgbaRawData.bytes, size.width * size.height * 4, NULL);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = CGImageCreate(size.width, size.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, provider, NULL, NO, kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return image;
}

- (NSData *)lsRGBARawData
{
    if (!self.CGImage)
        return nil;
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
    NSData *pixelData = [self lsRGBARawData];
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
