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

@interface UIImage (LSCategories)

/**
 Creates and returns image from given url asynchronously optionally using cache.
 
 @param url The URL from which to read image.
 @param useCache If YES then image will be cached in memory and on next read from same url returned from cache.
 @param handler Handler to execute after reading.
 */
+ (void)lsImageFromUrl:(NSURL *)url useCache:(BOOL)useCache handler:(void (^)(UIImage *image, NSError *error))handler;

/**
 Returns image with given color (size 1px x 1px).
 
 @param color Color to fill the image.
 @return Image with given color.
 */
+ (UIImage *)lsImageWithColor:(UIColor *)color;

/**
 Returns image with given color and size.

 @param color Color to fill the image.
 @param size Size of the image.
 @return Image with given color and size.
 */
+ (UIImage *)lsImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Returns image with triangle with given color and size.

 @param color Color to fill the triangle.
 @param size Size of the triangle.
 @return Image with triangle with given color and size.
 */
+ (UIImage *)lsTriangleImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Returns image with ellipse with given color and size.

 @param color Color to fill the ellipse.
 @param size Size of the ellipse.
 @return Image with ellipse with given color and size.
 */
+ (UIImage *)lsEllipseImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Returns image with gradient with two given colors and directions specified by points.

 @param size Size of the image.
 @param startColor Start color.
 @param endColor End color.
 @param startPoint Start point (from [0,0] to [1,1])
 @param endPoint End point (from [0,0] to [1,1])
 @return Image with gradient.
 */
+ (UIImage *)lsGradientImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 Returns image with avatar placeholder with initials from given name and background color generated from this name.

 @param text Name for generating avatar placeholder.
 @return Image with avatar placeholder.
 */
+ (UIImage *)lsInitialsAvatarImageWithText:(NSString *)text;

/**
 Returns image with given text drawed in the center.

 @param text Text to draw.
 @param textColor Text color.
 @param backgroundColor Background color.
 @param font Text font.
 @param size Size of the image.
 @return Image with given text drawed in the center.
 */
+ (UIImage *)lsImageWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font size:(CGSize)size;

/**
 Returns image rotated with degrees.
 
 @param degrees Degrees.
 @return Image rotated with degrees.
 */
- (UIImage *)lsRotatedImageWithDegrees:(CGFloat)degrees;

/**
 Returns image rotated with radians.

 @param radians Radians.
 @return Image rotated with radians.
 */
- (UIImage *)lsRotatedImageWithRadians:(CGFloat)radians;

/**
 Returns image flipped horizontally.

 @return Image flipped horizontally.
 */
- (UIImage *)lsImageFlippedHorizontally;

/**
 Returns image flipped vertically.

 @return Image flipped vertically.
 */
- (UIImage *)lsImageFlippedVertically;

/**
 Returns image resized to given size.

 @param size Size.
 @return Image resized to given size.
 */
- (UIImage *)lsResizedImageWithSize:(CGSize)size;

/**
 Returns image resized proportionally to the maximum size. Width and height of resized image will be smaller or equal to given width and height.

 @param size Maximum size.
 @return Resized image.
 */
- (UIImage *)lsResizedProportionalImageWithMaxSize:(CGSize)size;

/**
 Returns image resized proportionally to the minimum size. Width and height of resized image will be larger or equal to given width and height.
 
 @param size Maximum size.
 @return Resized image.
 */
- (UIImage *)lsResizedProportionalImageWithMinSize:(CGSize)size;

/**
 Returns image resized proportionally to given height.

 @param height Height.
 @return Resized image.
 */
- (UIImage *)lsResizedProportionalImageWithHeight:(CGFloat)height;

/**
 Returns image resized proportionally to given width.
 
 @param width Width.
 @return Resized image.
 */
- (UIImage *)lsResizedProportionalImageWithWidth:(CGFloat)width;

/**
 Returns cropped image with given rectangle.

 @param rect Rectangle to use for cropping.
 @return Cropped image.
 */
- (UIImage *)lsCroppedImageWithRect:(CGRect)rect;

/**
 Returns cropped image with given edge insets.

 @param insets Edge insets.
 @return Cropped image.
 */
- (UIImage *)lsCroppedImageWithInsets:(UIEdgeInsets)insets;

/**
 Returns padded image with given edge insets.

 @param insets Edge insets.
 @return Padded image.
 */
- (UIImage *)lsPaddedImageWithInsets:(UIEdgeInsets)insets;

/**
 Returns image masked with given mask image.

 @param maskImage Mask image.
 @return Masked image.
 */
- (UIImage *)lsMaskedImageWithMaskImage:(UIImage *)maskImage;

/**
 Returns image with inverted colors.

 @return Image with inverted colors.
 */
- (UIImage *)lsInvertedImage;

/**
 Returns PNG data.

 @return PNG data.
 */
- (NSData *)lsPNG;

/**
 Returns JPEG data with given compression quality from 0.0 (maximum compression and lowest quality) to 1.0 (least compression and best quality).

 @param compressionQuality Compression quality.
 @return JPEG data.
 */
- (NSData *)lsJPEGWithCompressionLevel:(CGFloat)compressionQuality;

/**
 Returns JPEG data with best possible quality and size below given maximum size. If it is not possible to compress image to get size below maximum size even when using lowest quality then returned value depends on allowAboveMax parameter. When allowAboveMax is set to YES then it will return image with lowest quality which can still be above maxSize. When allowAboveMax is set to NO it will return nil in this case.

 @param maxSize Maximum JPEG size.
 @param allowAboveMax If YES then returned image can be above maxSize, if NO then nil can be returned.
 @return JPEG data.
 */
- (NSData *)lsJPEGWithDesiredMaxSize:(NSUInteger)maxSize allowAboveMax:(BOOL)allowAboveMax;

/**
 Returns image created from raw pixel data in RGBA format.

 @param rgbaRawData RGBA raw pixel data.
 @param size Size of the image.
 @return Image created from raw pixel data or nil if given data does not match given size.
 */
+ (UIImage *)lsImageWithRGBARawData:(NSData *)rgbaRawData size:(CGSize)size;

/**
 Returns raw pixel data in RGBA format.

 @return Raw pixel data in RGBA format.
 */
- (NSData *)lsRGBARawData;

/**
 Returns color of pixel at given position.

 @param pixel Pixel position.
 @return Color of pixel at given position.
 */
- (UIColor *)lsColorAtPixel:(CGPoint)pixel;

/**
 Returns average color from image.

 @return Average color from image.
 */
- (UIColor *)lsAverageColor;

@end
