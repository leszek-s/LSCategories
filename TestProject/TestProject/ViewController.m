//
//  ViewController.m
//  TestProject
//
//  Created by Leszek on 03.02.2017.
//  Copyright © 2017 LS. All rights reserved.
//

#import "ViewController.h"
#import "LSCategories.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) NSString *testString;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Name: %@", [[UIApplication sharedApplication] lsName]);
    NSLog(@"Version: %@", [[UIApplication sharedApplication] lsVersion]);
    NSLog(@"Build: %@", [[UIApplication sharedApplication] lsBuild]);
    
    NSString *test = @"test123!test456!abcdefghijklmnopqrstuvwxyz!";
    NSLog(@"encoded base32: %@", [[test lsDataUTF8] lsBase32String]);
    NSLog(@"decoded base32: %@", [[NSData lsDataWithBase32String:@"ORSXG5BRGIZSC5DFON2DINJWEFQWEY3EMVTGO2DJNJVWY3LON5YHC4TTOR2XM53YPF5CC==="] lsStringUTF8]);
    NSLog(@"crc32: %08X", [test lsCRC32]);
    NSLog(@"adler32: %08X", [test lsAdler32]);
    NSLog(@"md2: %@", [test lsMD2]);
    NSLog(@"md4: %@", [test lsMD4]);
    NSLog(@"md5: %@", [test lsMD5]);
    NSLog(@"sha1: %@", [test lsSHA1]);
    NSLog(@"sha224: %@", [test lsSHA224]);
    NSLog(@"sha256: %@", [test lsSHA256]);
    NSLog(@"sha384: %@", [test lsSHA384]);
    NSLog(@"sha512: %@", [test lsSHA512]);
    NSLog(@"number: %@", [@"ffffffff" lsNumberFromHexString]);
    NSLog(@"rot5: %@", [test lsROT5String]);
    NSLog(@"rot13: %@", [test lsROT13String]);
    NSLog(@"rot18: %@", [test lsROT18String]);
    NSLog(@"reversed: %@", [test lsReversedString]);
    NSLog(@"lsIsValidEmail %@ %@", @([test lsIsValidEmail]), @([@"test@test.com" lsIsValidEmail]));
    NSLog(@"lsStringByRemovingNonLetters: %@", [test lsStringByRemovingNonLetters]);
    NSLog(@"lsStringByRemovingNonNumeric: %@", [test lsStringByRemovingNonNumeric]);
    NSLog(@"lsStringByRemovingNonAlphanumeric: %@", [test lsStringByRemovingNonAlphanumeric]);
    NSLog(@"lsSubstringBetweenStartString: %@", [test lsSubstringBetweenStartString:@"test" endString:@"!"]);
    NSLog(@"lsRangeOfSubstringBetweenStartString: %@", NSStringFromRange([test lsRangeOfSubstringBetweenStartString:@"test" endString:@"!"]));
    NSLog(@"lsAllRangesOfString: %@", [test lsAllRangesOfString:@"es"]);
    NSLog(@"lsRangesOfAllSubstringsBetweenStartString: %@", [test lsRangesOfAllSubstringsBetweenStartString:@"test" endString:@"!"]);
    NSLog(@"lsRandomStringWithLength: %@", [NSString lsRandomStringWithLength:10]);
    NSLog(@"lsMatchesWithRegex: %@", [test lsMatchesWithRegex:@"[0-9]+"]);
    NSLog(@"lsMatchesAndGroupsWithRegex: %@", [test lsMatchesAndGroupsWithRegex:@"test([0-9]+)!"]);
    NSLog(@"lsStringByReplacingRegex: %@", [test lsStringByReplacingRegexPattern:@"test([0-9]+)(.)test([0-9]+)(.)" templateString:@"first number: $1 first suffix: $2 second number: $3 second suffix: $4"]);
    NSLog(@"lsUUID: %@", [NSString lsUUID]);
    [NSString lsStringFromUrl:[NSURL URLWithString:@"https://github.com"] handler:^(NSString *string, NSError *error) {
        NSLog(@"lsStringFromUrl: %@...", [string substringToIndex:MIN(string.length, 400)]);
    }];
    
    NSDate *date = [NSDate new];
    NSDate *date2 = [[NSDate new] lsDateByAddingHours:1];
    NSDate *date3 = [[NSDate new] lsDateByAddingHours:2];
    NSLog(@"lsDateComponents: %@", [date lsDateComponents]);
    NSLog(@"lsYear: %@", @([date lsYear]));
    NSLog(@"lsMonth: %@", @([date lsMonth]));
    NSLog(@"lsDay: %@", @([date lsDay]));
    NSLog(@"lsHour: %@", @([date lsHour]));
    NSLog(@"lsMinute: %@", @([date lsMinute]));
    NSLog(@"lsSecond: %@", @([date lsSecond]));
    NSLog(@"lsBeginningOfDay: %@", [[date lsBeginningOfDay] lsStringWithISO8601]);
    NSLog(@"lsEndOfDay: %@", [[date lsEndOfDay] lsStringWithISO8601]);
    NSLog(@"lsBeginningOfNextDay: %@", [[date lsBeginningOfNextDay] lsStringWithISO8601]);
    NSLog(@"lsEndOfPreviousDay: %@", [[date lsEndOfPreviousDay] lsStringWithISO8601]);
    NSLog(@"lsBeginningOfMonth: %@", [[date lsBeginningOfMonth] lsStringWithISO8601]);
    NSLog(@"lsEndOfMonth: %@", [[date lsEndOfMonth] lsStringWithISO8601]);
    NSLog(@"lsBeginningOfNextMonth: %@", [[date lsBeginningOfNextMonth] lsStringWithISO8601]);
    NSLog(@"lsEndOfPreviousMonth: %@", [[date lsEndOfPreviousMonth] lsStringWithISO8601]);
    NSLog(@"lsBeginningOfYear: %@", [[date lsBeginningOfYear] lsStringWithISO8601]);
    NSLog(@"lsEndOfYear: %@", [[date lsEndOfYear] lsStringWithISO8601]);
    NSLog(@"lsBeginningOfNextYear: %@", [[date lsBeginningOfNextYear] lsStringWithISO8601]);
    NSLog(@"lsEndOfPreviousYear: %@", [[date lsEndOfPreviousYear] lsStringWithISO8601]);
    NSLog(@"lsIsToday: %@", @([date lsIsToday]));
    NSLog(@"lsIsTomorrow: %@", @([[date lsDateByAddingHours:5] lsIsTomorrow]));
    NSLog(@"lsIsYesterday: %@", @([[date lsDateByAddingHours:-22] lsIsYesterday]));
    NSLog(@"lsIsEarlierThanDate: %@", @([date lsIsEarlierThanDate:date2]));
    NSLog(@"lsIsLaterThanDate: %@", @([date2 lsIsLaterThanDate:date]));
    NSLog(@"lsIsInBetweenStartDate: %@", @([date2 lsIsInBetweenStartDate:date endDate:date3]));
    NSLog(@"lsDaysDifferenceFromDate: %@", @([date3 lsDaysDifferenceFromDate:date]));
    NSLog(@"lsMonthsDifferenceFromDate: %@", @([date3 lsMonthsDifferenceFromDate:date]));
    NSLog(@"lsMinutesDifferenceFromDate: %@", @([date3 lsMinutesDifferenceFromDate:date]));
    NSLog(@"lsStringWithShortDate: %@", [date lsStringWithShortDate]);
    NSLog(@"lsStringWithShortTime: %@", [date lsStringWithShortTime]);
    NSLog(@"lsStringWithShortDateTime: %@", [date lsStringWithShortDateTime]);
    NSLog(@"lsStringWithMediumDate: %@", [date lsStringWithMediumDate]);
    NSLog(@"lsStringWithMediumTime: %@", [date lsStringWithMediumTime]);
    NSLog(@"lsStringWithMediumDateTime: %@", [date lsStringWithMediumDateTime]);
    NSLog(@"lsStringWithLongDate: %@", [date lsStringWithLongDate]);
    NSLog(@"lsStringWithLongTime: %@", [date lsStringWithLongTime]);
    NSLog(@"lsStringWithLongDateTime: %@", [date lsStringWithLongDateTime]);
    NSLog(@"lsStringWithFormat: %@", [date lsStringWithFormat:@"yyyy     HH"]);
    NSLog(@"lsDateWithString: %@", [NSDate lsDateWithString:@"2017" format:@"yyyy"]);
    NSLog(@"lsDateWithStringWithISO8601: %@", [NSDate lsDateWithStringWithISO8601:@"2017-02-03T00:00:00+01:00"]);
    [NSDate lsDateFromOnlineServerWithHandler:^(NSDate * _Nullable date) {
        NSLog(@"lsDateFromOnlineServerWithHandler: %@", date);
    }];
    
    NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    NSLog(@"lsReveresedArray: %@", [array lsReveresedArray]);
    NSLog(@"lsShuffledArray: %@", [array lsShuffledArray]);
    NSLog(@"lsRandomObject: %@", [array lsRandomObject]);
    
    NSData *data = [test lsDataUTF8];
    [data lsSaveToDirectory:NSDocumentDirectory subDirectory:@"LSDATA" fileName:[test lsMD5] useExcludeFromBackup:NO];
    NSData *data2 = [NSData lsReadDataFromDirectory:NSDocumentDirectory subDirectory:@"LSDATA" fileName:[test lsMD5]];
    NSLog(@"data2: %@", data2);
    NSLog(@"lsStringUTF8: %@", [data2 lsStringUTF8]);
    NSString *hexString = [[data2 lsHexString] lowercaseString];
    NSLog(@"lsHexString: %@", hexString);
    NSLog(@"lsDataWithHexString: %@", [NSData lsDataWithHexString:hexString]);
    NSLog(@"lsContentOfDirectory: %@", [NSData lsContentOfDirectory:NSDocumentDirectory subDirectory:@"LSDATA"]);
    [NSData lsCleanDirectory:NSDocumentDirectory subDirectory:@"LSDATA"];
    NSLog(@"lsContentOfDirectory: %@", [NSData lsContentOfDirectory:NSDocumentDirectory subDirectory:@"LSDATA"]);
    NSData *xorKey = [@"tEsT" lsDataUTF8];
    NSData *xored = [data lsDataXORedWithKey:xorKey];
    NSLog(@"lsDataXORedWithKey: %@", xored);
    NSLog(@"lsDataXORedWithKey: %@", [xored lsDataXORedWithKey:xorKey]);
    
    [NSDictionary lsDictionaryFromJsonUrl:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts/1/comments"] handler:^(NSDictionary *jsonDictionary, NSError *error) {
        NSLog(@"lsDictionaryFromJsonUrl: %@", jsonDictionary);
        NSLog(@"lsJsonString: %@", [jsonDictionary lsJsonString]);
        NSLog(@"lsDictionaryFromJsonString: %@", [NSDictionary lsDictionaryFromJsonString:[jsonDictionary lsJsonString]]);
    }];
    
    UIColor *color = [UIColor lsRandomColor];
    NSLog(@"lsRandomColor: %@", color);
    NSLog(@"lsInvertedColor: %@", [color lsInvertedColor]);
    NSLog(@"lsRgbHexString: %@", [color lsRgbHexString]);
    NSLog(@"lsRgbaHexString: %@", [color lsRgbaHexString]);
    NSLog(@"lsRgb: %X", [color lsRgb]);
    NSLog(@"lsRgba: %X", [color lsRgba]);
    NSLog(@"lsRed: %f", [color lsRed]);
    NSLog(@"lsGreen: %f", [color lsGreen]);
    NSLog(@"lsBlue: %f", [color lsBlue]);
    NSLog(@"lsAlpha: %f", [color lsAlpha]);
    NSLog(@"lsHue: %f", [color lsHue]);
    NSLog(@"lsSaturation: %f", [color lsSaturation]);
    NSLog(@"lsBrightness: %f", [color lsBrightness]);
    NSLog(@"lsColorWithRgb: %@", [UIColor lsColorWithRgb:0xFF00FF]);
    NSLog(@"lsColorWithRgba: %@", [UIColor lsColorWithRgba:0xFF00FF33]);
    NSLog(@"lsColorWithHexString: %@", [UIColor lsColorWithHexString:@"0xFF00FF"]);
    NSLog(@"lsColorWithHexString: %@", [UIColor lsColorWithHexString:@"0XFF00FF33"]);
    NSLog(@"lsColorWithHexString: %@", [UIColor lsColorWithHexString:@"#F0F"]);
    NSLog(@"lsColorWithHexString: %@", [UIColor lsColorWithHexString:@"F0F3"]);
    
    [test lsAssociatedDictionary][@"test"] = @12345;
    NSLog(@"lsAssociatedDictionary: %@", [test lsAssociatedDictionary]);
    
    UIImage *green = [UIImage lsImageWithColor:[UIColor greenColor] size:CGSizeMake(20, 10)];
    UIImage *triangle = [UIImage lsTriangleImageWithColor:[UIColor blueColor] size:CGSizeMake(50, 50)];
    UIImage *gradient = [UIImage lsGradientImageWithSize:CGSizeMake(50, 50) startColor:[UIColor greenColor] endColor:[UIColor blueColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
    UIImage *avatar = [[[UIImage lsInitialsAvatarImageWithText:@"John Doe"] lsResizedProportionalImageWithHeight:50] lsRoundedImageWithCornerRadius:25];
    UIImage *text = [UIImage lsImageWithText:@"HELLO WORLD!" textColor:[UIColor whiteColor] backgroundColor:[UIColor blueColor] font:[UIFont boldSystemFontOfSize:20] size:CGSizeMake(200, 30)];
    UIImage *flippedHorizontally = [gradient lsImageFlippedHorizontally];
    UIImage *flippedVertically = [gradient lsImageFlippedVertically];
    UIImage *rotated = [gradient lsRotatedImageWithRadians:M_PI_2 / 2];
    UIImage *resized = [gradient lsResizedImageWithSize:CGSizeMake(200, 100)];
    UIImage *resizedProportional = [resized lsResizedProportionalImageWithMaxSize:CGSizeMake(500, 500)];
    UIImage *resizedWithWidth = [resized lsResizedProportionalImageWithWidth:500];
    UIImage *resizedWithHeight = [resized lsResizedProportionalImageWithHeight:500];
    UIImage *cropped = [gradient lsCroppedImageWithRect:CGRectMake(0, 20, 60, 20)];
    UIImage *croppedWithInsets = [gradient lsCroppedImageWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage *circleMask = [[UIImage lsEllipseImageWithColor:[UIColor whiteColor] size:gradient.size] lsInvertedImage];
    gradient = [gradient lsMaskedImageWithMaskImage:circleMask];
    NSLog(@"lsImageWithColor: %@", green);
    NSLog(@"lsTriangleImageWithColor: %@", triangle);
    NSLog(@"lsGradientImageWithSize: %@", gradient);
    NSLog(@"lsInitialsAvatarImageWithText: %@", avatar);
    NSLog(@"lsImageWithText: %@", text);
    NSLog(@"lsImageFlippedHorizontally: %@", flippedHorizontally);
    NSLog(@"lsImageFlippedVertically: %@", flippedVertically);
    NSLog(@"lsRotatedImageWithRadians: %@", rotated);
    NSLog(@"lsResizedImageWithSize: %@", resized);
    NSLog(@"lsResizedProportionalImageWithMaxSize: %@", resizedProportional);
    NSLog(@"lsResizedProportionalImageWithWidth: %@", resizedWithWidth);
    NSLog(@"lsResizedProportionalImageWithHeight: %@", resizedWithHeight);
    NSLog(@"lsCroppedImageWithRect: %@", cropped);
    NSLog(@"lsCroppedImageWithInsets: %@", croppedWithInsets);
    NSLog(@"lsPNG: %@", @([resized lsPNG].length));
    NSLog(@"lsJPEGWithCompressionLevel: %@", @([resized lsJPEGWithCompressionLevel:0.8].length));
    NSLog(@"lsJPEGWithDesiredMaxSize: %@", @([resized lsJPEGWithDesiredMaxSize:2000 allowAboveMax:YES].length));
    NSLog(@"lsRGBARawData: %@", [green lsRGBARawData]);
    NSLog(@"lsImageWithRGBARawData %@", [UIImage lsImageWithRGBARawData:[green lsRGBARawData] size:CGSizeMake(2, 100)]);
    NSLog(@"lsColorAtPixel: %@", [green lsColorAtPixel:CGPointMake(5, 5)]);
    NSLog(@"lsAverageColor: %@", [green lsAverageColor]);
    
    [self lsObserveValueForKeyPath:@"testString" handler:^(NSDictionary * _Nullable change) {
        NSLog(@"Observed changed on testString, new value: %@, old value: %@", change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
    }];
    self.testString = @"test1";
    self.testString = @"test2";
    
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:green]];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:avatar]];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:text]];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:triangle]];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:gradient]];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:rotated]];
    UIImageView *rotatedImageView = self.stackView.arrangedSubviews.lastObject;
    
    UILabel *label1 = [UILabel new];
    [self.stackView addArrangedSubview:label1];
    label1.text = @"test <h1>with</h1> <s>some</s> <strong>basic</strong> <em>tags</em> <u>and</u> <textAttachment>iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAMAAAC6V+0/AAAAS1BMVEX///8AVo3w9fjF2eU0eaQtc6G80+GgwNVGha3y9/rs8vfq8fbo8PXA1eOvytuQtc15psNkmbpakrVTjbJCgqs6fKcfa5sUY5YKXZEIH/n7AAAAe0lEQVQY033OVw4DIQxFUT/AML23/a80MgomEya5P6Ajy0D/6/sH3LbSLGALrIDqYVBGi8GPUWPDtPKF2MXrFKyhlvEVt0SNu5tr4gJ3M/Neu2fbxWL1keyoSTsTntk6aJ2iz+gVR3nVe/nFqDiDBzkHxqy4hHQLC/3qBVhXAytZYZD/AAAAAElFTkSuQmCC</textAttachment> <h6>attachment</h6>";
    [label1 lsParseBasicHTMLTags];
    
    UILabel *label2 = [UILabel new];
    [self.stackView addArrangedSubview:label2];
    label2.attributedText = [@"text with <image> inline image" lsAttributedStringByReplacingOccurrenceOfString:@"<image>" withImage:[rotated lsResizedProportionalImageWithHeight:label2.font.pointSize] verticalOffset:0];
    
    UILabel *label3 = [UILabel new];
    [self.stackView addArrangedSubview:label3];
    [label3 lsAddBorderOnEdge:UIRectEdgeTop color:[UIColor greenColor] width:2];
    [label3 lsAddBorderOnEdge:UIRectEdgeBottom color:[UIColor blueColor] width:2];
    [label3 lsAnimateCounterWithStartValue:0 endValue:10000 duration:3 completionBlock:^{
        [label3 lsStartInfiniteRotationWithDuration:2 clockwise:YES];
        [self.stackView.arrangedSubviews.firstObject lsStartInfiniteRotationWithDuration:2 clockwise:NO];
    }];
    
    [UIView lsRepeatWithDuration:2 delay:3 framesPerSecond:60 block:^(CGFloat progress) {
        CGFloat p = progress > 0.5 ? 1 - progress : progress;
        rotatedImageView.transform = CGAffineTransformMakeScale(1 - p, 1 - p);
    } completionBlock:nil];
    
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    [heartPath addArcWithCenter:CGPointMake(30, 35) radius:25 startAngle:3 * M_PI_4 endAngle:7 * M_PI_4 clockwise:YES];
    [heartPath addLineToPoint:CGPointMake(50, 20)];
    [heartPath addArcWithCenter:CGPointMake(70, 35) radius:25 startAngle:5 * M_PI_4 endAngle:M_PI_4 clockwise:YES];
    [heartPath addLineToPoint:CGPointMake(50, 95)];
    [heartPath closePath];
    heartPath.lineWidth = 1;
    [heartPath applyTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    UIImage *heartImageSmall = [heartPath lsImageWithStrokeColor:[UIColor blueColor] fillColor:[UIColor greenColor] backgroundColor:[UIColor redColor]];
    [heartPath applyTransform:CGAffineTransformMakeScale(5, 5)];
    UIImage *heartImage = [heartPath lsImageWithStrokeColor:[UIColor blueColor] fillColor:[UIColor colorWithPatternImage:heartImageSmall] backgroundColor:nil];
    [self.stackView addArrangedSubview:[[UIImageView alloc] initWithImage:heartImage]];
    
    [self.navigationController lsSetNavigationBarColor:[UIColor redColor] titleColor:[UIColor whiteColor] buttonsColor:[UIColor whiteColor] borderColor:[UIColor blackColor]];
    
    UIImage *item1 = [UIImage lsImageWithText:@"\U0001F999" textColor:[UIColor redColor] backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:50] size:CGSizeMake(50, 50)];
    UIImage *item2 = [UIImage lsImageWithText:@"\U0001F340" textColor:[UIColor redColor] backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:50] size:CGSizeMake(50, 50)];
    [self.tabBarController lsSetTabBarColor:[UIColor redColor] itemColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] selectedItemColor:[UIColor whiteColor] borderColor:[UIColor blackColor]];
    [self.tabBarController lsSetTabBarButtonWithIndex:0 title:@"Hello" image:[item1 lsResizedProportionalImageWithHeight:22] selectedImage:[item1 lsResizedProportionalImageWithHeight:28]];
    [self.tabBarController lsSetTabBarButtonWithIndex:1 title:@"World" image:[item2 lsResizedProportionalImageWithHeight:22] selectedImage:[item2 lsResizedProportionalImageWithHeight:28]];
    
    [[UIApplication sharedApplication] lsAskForAppRatingIfReachedMinimumDaysOfUse:0 minimumSignificantEvents:0];
}

- (IBAction)testAction:(id)sender
{
    [UIView lsShowSharedToastWithText:@"Toast test!"];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor lsRandomColor];
    [UIView lsShowSharedActivityIndicator];
    [self.navigationController lsPushViewController:vc animated:YES completionBlock:^{
        vc.view.backgroundColor = [UIColor lsRandomColor];
        NSLog(@"lsPushViewController completionBlock");
        [self.navigationController lsPopViewControllerAnimated:YES completionBlock:^{
            NSLog(@"lsPopViewControllerAnimated completionBlock");
            [UIView lsHideSharedActivityIndicator];
        }];
    }];
}

@end
