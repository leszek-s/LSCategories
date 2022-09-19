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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define lsClamp(x, min, max) (MIN(MAX((x), (min)), (max)))
#define lsDegreesToRadians(degrees) ((degrees) / 180.0 * M_PI)
#define lsRadiansToDegrees(radians) ((radians) * 180.0 / M_PI)
#define lsNilToNull(x) ((x) ? (x) : [NSNull null])
#define lsNullToNil(x) ((x) == [NSNull null] ? nil : (x))
#define lsWeakify(object) __weak __typeof(object) lsWeak_##object = object;
#define lsStrongify(object) __strong __typeof(object) object = lsWeak_##object;

#import "NSArray+LSCategories.h"
#import "NSAttributedString+LSCategories.h"
#import "NSData+LSCategories.h"
#import "NSDate+LSCategories.h"
#import "NSDictionary+LSCategories.h"
#import "NSException+LSCategories.h"
#import "NSObject+LSCategories.h"
#import "NSString+LSCategories.h"
#import "NSTimer+LSCategories.h"
#import "UIApplication+LSCategories.h"
#import "UIButton+LSCategories.h"
#import "UIBezierPath+LSCategories.h"
#import "UIColor+LSCategories.h"
#import "UIControl+LSCategories.h"
#import "UIDatePicker+LSCategories.h"
#import "UIDevice+LSCategories.h"
#import "UIFont+LSCategories.h"
#import "UIImage+LSCategories.h"
#import "UIImageView+LSCategories.h"
#import "UILabel+LSCategories.h"
#import "UINavigationController+LSCategories.h"
#import "UIPickerView+LSCategories.h"
#import "UIScrollView+LSCategories.h"
#import "UITabBarController+LSCategories.h"
#import "UITableView+LSCategories.h"
#import "UITextField+LSCategories.h"
#import "UITextView+LSCategories.h"
#import "UIView+LSCategories.h"
#import "UIViewController+LSCategories.h"
#import "UIWindow+LSCategories.h"
