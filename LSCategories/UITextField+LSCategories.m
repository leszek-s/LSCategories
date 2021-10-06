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
#import "UIImage+LSCategories.h"
#import "UIView+LSCategories.h"
#import <objc/runtime.h>

static char lsAssociatedMaxLengthKey;
static char lsAssociatedAllowedCharacterSetKey;
static char lsAssociatedAllowedRegexKey;
static char lsAssociatedCustomOrderIndexPathKey;

@implementation UITextField (LSCategories)

- (void)lsSetPlaceholder:(NSString *)placeholder color:(UIColor *)color
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName : color}];
}

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

- (void)lsSetAllowedRegex:(NSString *)regex
{
    objc_setAssociatedObject(self, &lsAssociatedAllowedRegexKey, regex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(lsTextFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)lsSetAllowedDecimalsWithIntegerPart:(NSInteger)integerPart fractionalPart:(NSInteger)fractionalPart
{
    if (integerPart > 0 && fractionalPart > 0)
    {
        NSString *regex = [NSString stringWithFormat:@"^(0|([1-9][0-9]{0,%@}))((\\.|,)[0-9]{0,%@})?$", @(integerPart - 1), @(fractionalPart)];
        [self lsSetAllowedRegex:regex];
    }
    else if (integerPart > 0 && fractionalPart <= 0)
    {
        NSString *regex = [NSString stringWithFormat:@"^(0|([1-9][0-9]{0,%@}))$", @(integerPart - 1)];
        [self lsSetAllowedRegex:regex];
    }
}

- (void)lsTextFieldEditingChanged
{
    NSCharacterSet *allowedCharacterSet = objc_getAssociatedObject(self, &lsAssociatedAllowedCharacterSetKey);
    if (allowedCharacterSet)
    {
        self.text = [[self.text componentsSeparatedByCharactersInSet:allowedCharacterSet.invertedSet] componentsJoinedByString:@""];
    }
    
    NSString *allowedRegex = objc_getAssociatedObject(self, &lsAssociatedAllowedRegexKey);
    if (allowedRegex)
    {
        while (self.text.length > 0)
        {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:allowedRegex options:0 error:nil];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
            if (numberOfMatches != 0)
            {
                break;
            }
            self.text = [self.text substringToIndex:self.text.length - 1];
        }
    }
    
    NSNumber *maxLength = objc_getAssociatedObject(self, &lsAssociatedMaxLengthKey);
    if (maxLength.integerValue > 0)
    {
        self.text = self.text.length > maxLength.integerValue ? [self.text substringToIndex:maxLength.integerValue] : self.text;
    }
}

- (void)lsSetLeftPadding:(CGFloat)leftPadding
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 10)];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)lsSetRightPadding:(CGFloat)rightPadding
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightPadding, 10)];
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)lsSetClearButtonWithColor:(UIColor *)color mode:(UITextFieldViewMode)mode
{
    UIImage *image = [UIImage lsEllipseImageWithColor:color size:CGSizeMake(80, 80)];
    UIImage *mask = [[[UIImage lsImageWithColor:UIColor.whiteColor size:CGSizeMake(40, 6)] lsPaddedImageWithInsets:UIEdgeInsetsMake(0, 20, 0, 20)] lsRotatedImageWithDegrees:45];
    mask = [mask lsMergedImageWithImage:[mask lsImageFlippedHorizontally] position:CGPointZero];
    image = [[[image lsMaskedImageWithMaskImage:mask] lsPaddedImageWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)] lsResizedProportionalImageWithHeight:80];
    
    [self lsSetClearButtonWithImage:image mode:mode];
}

- (void)lsSetClearButtonWithImage:(UIImage *)image mode:(UITextFieldViewMode)mode
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(lsClearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(lsClearButtonEditingEvent) forControlEvents:UIControlEventAllEditingEvents];
    self.rightView = button;
    self.rightViewMode = mode;
    [self lsClearButtonEditingEvent];
}

- (void)lsClearButtonAction
{
    self.text = @"";
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)lsClearButtonEditingEvent
{
    self.rightView.hidden = self.text.length == 0;
}

- (void)lsEnableAutomaticReturnButtonOnKeyboard
{
    [self addTarget:self action:@selector(lsTextFieldEditingDidEndOnExitAutomaticReturn) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)lsTextFieldEditingDidEndOnExitAutomaticReturn
{
    [self resignFirstResponder];
}

- (void)lsEnableAutomaticNextAndDoneButtonsOnKeyboard
{
    if ([self lsNextFieldInCurrentViewHierarchy])
    {
        self.returnKeyType = UIReturnKeyNext;
    }
    else
    {
        self.returnKeyType = UIReturnKeyDone;
    }
    [self addTarget:self action:@selector(lsTextFieldEditingDidEndOnExitAutomaticNextAndDone) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)lsSetCustomOrderIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &lsAssociatedCustomOrderIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)lsCustomOrderIndexPath
{
    return objc_getAssociatedObject(self, &lsAssociatedCustomOrderIndexPathKey);
}

- (UITextField *)lsNextFieldInCurrentViewHierarchy
{
    UIView *rootView = [self lsRootSuperview];
    NSArray *textFields = [rootView lsSubviewsWithClass:[UITextField class] recursive:YES];

    NSIndexPath *customOrderIndexPath = [self lsCustomOrderIndexPath];
    if (customOrderIndexPath)
    {
        textFields = [textFields filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITextField *textField, NSDictionary *bindings) {
            NSIndexPath *indexPath = [textField lsCustomOrderIndexPath];
            return indexPath != nil && indexPath.section == customOrderIndexPath.section;
        }]];
        textFields = [textFields sortedArrayUsingComparator:^NSComparisonResult(UITextField *textField1, UITextField *textField2) {
            NSIndexPath *indexPath1 = [textField1 lsCustomOrderIndexPath];
            NSIndexPath *indexPath2 = [textField2 lsCustomOrderIndexPath];
            return indexPath1.row > indexPath2.row;
        }];
    }
    else
    {
        textFields = [textFields sortedArrayUsingComparator:^NSComparisonResult(UITextField *textField1, UITextField *textField2) {
            CGPoint point1 = [rootView convertPoint:CGPointZero fromView:textField1];
            CGPoint point2 = [rootView convertPoint:CGPointZero fromView:textField2];
            return point1.y > point2.y;
        }];
    }
    NSUInteger index = [textFields indexOfObject:self];
    if (index == NSNotFound || index + 1 >= textFields.count)
    {
        return nil;
    }
    return [textFields objectAtIndex:index + 1];
}

- (void)lsTextFieldEditingDidEndOnExitAutomaticNextAndDone
{
    UITextField *nextField = [self lsNextFieldInCurrentViewHierarchy];
    if (nextField)
    {
        [nextField becomeFirstResponder];
    }
    else
    {
        [self resignFirstResponder];
    }
}

@end
