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

@interface UITabBarController (LSCategories)

/**
 Sets opaque tab bar with given colors.

 @param barColor Bar color.
 @param itemColor Item color.
 @param selectedItemColor Selected item color.
 @param borderColor Border color or nil if should leave default shadow.
*/
- (void)lsSetTabBarColor:(UIColor *)barColor itemColor:(UIColor *)itemColor selectedItemColor:(UIColor *)selectedItemColor borderColor:(nullable UIColor *)borderColor;

/**
 Sets the title, image, and selected image of a tab bar button with given index.

 @param index Button index.
 @param title Title to set.
 @param image Image to set.
 @param selectedImage Selected image to set.
*/
- (void)lsSetTabBarButtonWithIndex:(NSUInteger)index title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
