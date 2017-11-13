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

#import "UITextView+LSCategories.h"
#import "NSString+LSCategories.h"
#import "UIFont+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedPlaceholderLabelKey;

@implementation UITextView (LSCategories)

- (void)lsParseBasicHTMLTags
{
    self.attributedText = [self.text lsAttributedStringWithDefaultTagStylesheetAndBaseFont:self.font];
}

- (UILabel *)lsPlaceholderLabel
{
    UILabel *label = objc_getAssociatedObject(self, &lsAssociatedPlaceholderLabelKey);
    if (!label)
    {
        label = [UILabel new];
        label.font = self.font;
        label.numberOfLines = 0;
        label.textAlignment = self.textAlignment;
        label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        label.backgroundColor = UIColor.clearColor;
        [self addSubview:label];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lsTextDidChangeNotificationAction) name:UITextViewTextDidChangeNotification object:self];
        objc_setAssociatedObject(self, &lsAssociatedPlaceholderLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

- (void)lsSetPlaceholder:(NSString *)placeholder
{
    UILabel *label = [self lsPlaceholderLabel];
    label.text = placeholder;
    
    CGFloat offsetLeft = self.textContainerInset.left + self.textContainer.lineFragmentPadding;
    CGFloat offsetRight = self.textContainerInset.right + self.textContainer.lineFragmentPadding;
    CGFloat offsetTop = self.textContainerInset.top;
    CGFloat offsetBottom = self.textContainerInset.bottom;
    
    CGSize size = [label sizeThatFits:CGSizeMake(self.frame.size.width - offsetLeft - offsetRight, self.frame.size.height - offsetTop - offsetBottom)];
    label.frame = CGRectMake(offsetLeft, offsetTop, size.width, size.height);
    
    label.hidden = self.text.length > 0;
}

- (void)lsTextDidChangeNotificationAction
{
    UILabel *label = [self lsPlaceholderLabel];
    label.hidden = self.text.length > 0;
}

@end
