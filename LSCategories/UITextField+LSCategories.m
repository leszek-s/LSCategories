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

#import "UITextField+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedMaxLengthKey;
static char lsAssociatedAllowedCharacterSetKey;

@implementation UITextField (LSCategories)

- (void)lsSetMaxLength:(NSInteger)maxLength
{
    objc_setAssociatedObject(self, &lsAssociatedMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(lsTextFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)lsSetAllowedCharacterSet:(NSCharacterSet *)allowedCharacterSet
{
    objc_setAssociatedObject(self, &lsAssociatedAllowedCharacterSetKey, allowedCharacterSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(lsTextFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)lsTextFieldEditingChanged
{
    NSCharacterSet *allowedCharacterSet = objc_getAssociatedObject(self, &lsAssociatedAllowedCharacterSetKey);
    if (allowedCharacterSet)
    {
        self.text = [[self.text componentsSeparatedByCharactersInSet:allowedCharacterSet.invertedSet] componentsJoinedByString:@""];
    }
    
    NSNumber *maxLength = objc_getAssociatedObject(self, &lsAssociatedMaxLengthKey);
    if (maxLength.integerValue > 0)
    {
        self.text = self.text.length > maxLength.integerValue ? [self.text substringToIndex:maxLength.integerValue] : self.text;
    }
}

@end
