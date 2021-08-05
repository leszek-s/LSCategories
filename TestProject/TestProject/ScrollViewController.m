//
//  ScrollViewController.m
//  TestProject
//
//  Created by Leszek on 03.02.2017.
//  Copyright © 2017 LS. All rights reserved.
//

#import "ScrollViewController.h"
#import "LSCategories.h"

@interface ScrollViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSArray<NSString *> *months;
@end

@implementation ScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self lsEnableAutomaticKeyboardHandling];
    
    self.months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
}

- (IBAction)button1Action:(id)sender
{
    UIDatePicker *picker = [UIDatePicker new];
    picker.datePickerMode = UIDatePickerModeDate;
    [picker lsShowAsPopupWithTitle:@"Select date" cancelTitle:@"Cancel" okTitle:@"OK" backgroundColor:UIColor.whiteColor titleColor:UIColor.redColor cancelColor:UIColor.blackColor okColor:UIColor.blackColor handler:^(BOOL accepted, NSDate * _Nonnull date) {
        NSLog(@"Selected %@ and pressed OK: %@", date, @(accepted));
    }];
}

- (IBAction)button2Action:(id)sender
{
    UIPickerView *picker = [UIPickerView new];
    picker.dataSource = self;
    picker.delegate = self;
    [picker lsShowAsPopupWithTitle:@"Select a month" cancelTitle:@"Cancel" okTitle:@"OK" backgroundColor:UIColor.whiteColor titleColor:UIColor.redColor cancelColor:UIColor.blackColor okColor:UIColor.blackColor handler:^(BOOL accepted, UIPickerView * _Nonnull picker) {
        NSInteger row = [picker selectedRowInComponent:0];
        NSLog(@"Selected %@ and pressed OK: %@", self.months[row], @(accepted));
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.months.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.months[row];
}

@end
