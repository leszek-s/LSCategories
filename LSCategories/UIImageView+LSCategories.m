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

#import "UIImageView+LSCategories.h"
#import "UIImage+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedImageUrlKey;

@implementation UIImageView (LSCategories)

- (void)lsFadeToImage:(UIImage *)image duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completionBlock
{
    [UIView transitionWithView:self duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.image = image;
    } completion:completionBlock];
}

- (void)lsSetImageFromUrl:(NSURL *)url useCache:(BOOL)useCache useDiskCache:(BOOL)useDiskCache
{
    objc_setAssociatedObject(self, &lsAssociatedImageUrlKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!url)
        return;
    __weak UIImageView *weakSelf = self;
    [UIImage lsImageFromUrl:url useCache:useCache useDiskCache:useDiskCache handler:^(UIImage * _Nullable image, NSError * _Nullable error) {
        UIImageView *strongSelf = weakSelf;
        NSURL *associatedUrl = objc_getAssociatedObject(self, &lsAssociatedImageUrlKey);
        if (image && [associatedUrl.absoluteString isEqual:url.absoluteString]) {
            strongSelf.image = image;
        }
    }];
}

@end
