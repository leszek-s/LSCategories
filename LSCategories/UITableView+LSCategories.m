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

#import "UITableView+LSCategories.h"

@interface LSUITableHeaderFooterWrapperView : UIView
@property (weak, nonatomic) UIView *wrappedView;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSNumber *lastSetHeight;
@property (assign, nonatomic) BOOL isFooter;
@end

@implementation LSUITableHeaderFooterWrapperView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshHeaderFooterViewIfNeeded];
}

- (void)refreshHeaderFooterViewIfNeeded {
    dispatch_async(dispatch_get_main_queue(), ^(void){
        CGSize wrappedViewSize = self.wrappedView.bounds.size;
        if (![self.lastSetHeight isEqual:@(wrappedViewSize.height)]) {
            CGRect frame = self.frame;
            frame.size = wrappedViewSize;
            self.frame = frame;
            self.lastSetHeight = @(wrappedViewSize.height);
            if (self.isFooter) {
                self.tableView.tableFooterView = self;
            } else {
                self.tableView.tableHeaderView = self;
            }
        }
    });
}

@end

@implementation UITableView (LSCategories)

- (void)lsSetAutolayoutTableHeaderView:(UIView *)tableHeaderView {
    if (!tableHeaderView) {
        self.tableHeaderView = nil;
        return;
    }
    LSUITableHeaderFooterWrapperView *wrapperView = [LSUITableHeaderFooterWrapperView new];
    wrapperView.translatesAutoresizingMaskIntoConstraints = YES;
    wrapperView.wrappedView = tableHeaderView;
    wrapperView.tableView = self;
    wrapperView.isFooter = NO;
    [wrapperView addSubview:tableHeaderView];
    self.tableHeaderView = wrapperView;
    [tableHeaderView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
}

- (void)lsSetAutolayoutTableFooterView:(UIView *)tableFooterView {
    if (!tableFooterView) {
        self.tableFooterView = nil;
        return;
    }
    LSUITableHeaderFooterWrapperView *wrapperView = [LSUITableHeaderFooterWrapperView new];
    wrapperView.translatesAutoresizingMaskIntoConstraints = YES;
    wrapperView.wrappedView = tableFooterView;
    wrapperView.tableView = self;
    wrapperView.isFooter = YES;
    [wrapperView addSubview:tableFooterView];
    self.tableFooterView = wrapperView;
    [tableFooterView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
}

- (void)lsSetHiddenTableHeaderView {
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (void)lsSetHiddenTableFooterView {
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

@end
