# LSCategories
**LSCategories** is a collection of useful Foundation and UIKit categories created to simplify some common operations and speed up the development process. It is implemented in Objective-C but it also can be easily integrated and used in Swift projects.

## Installation

To integrate LSCategories into your Xcode project you can use [CocoaPods](https://cocoapods.org/) dependency manager. In your `Podfile` add the following line:

```
pod 'LSCategories'
```

## Features
Some things which can be easily done with LSCategories are listed below.

Create various type of hashes and checksums with a single line of code from NSString or NSData:
```objc
NSString *sha1 = [@"Test string" lsSHA1];
NSString *sha224 = [@"Test string" lsSHA224];
NSString *sha256 = [@"Test string" lsSHA256];
NSString *sha384 = [@"Test string" lsSHA384];
NSString *sha512 = [@"Test string" lsSHA512];
NSString *md2 = [@"Test string" lsMD2];
NSString *md4 = [@"Test string" lsMD4];
NSString *md5 = [@"Test string" lsMD5];
uint32_t crc32 = [@"Test string" lsCRC32];
uint32_t adler32 = [@"Test string" lsAdler32];
```

Put an image inside a string easily:
```objc
NSAttributedString *withPrefix = [@"text" lsAttributedStringWithPrefixImage:[UIImage imageNamed:@"image.png"]];
NSAttributedString *withSuffix = [@"text" lsAttributedStringWithSuffixImage:[UIImage imageNamed:@"image.png"]];
NSAttributedString *withImageInside = [@"text with <image> inline image" lsAttributedStringByReplacingOccurrenceOfString:@"<image>" withImage:[UIImage imageNamed:@"image.png"] verticalOffset:0];
```

Obfuscate NSData or NSString with XOR or ROT13 and filter strings from unwanted characters:
```objc
NSData *data = [@"Some data to xor" lsDataUTF8];
NSData *key = [@"key" lsDataUTF8];
NSData *xoredData = [data lsDataXORedWithKey:key];
NSString *rot13 = [@"Some string" lsROT13String];
NSString *lettersOnly = [test lsStringByRemovingNonLetters];
NSString *numbersOnly = [test lsStringByRemovingNonNumeric];
NSString *numbersAndLettersOnly = [test lsStringByRemovingNonAlphanumeric];
NSString *customFilter = [test lsStringByRemovingCharactersNotInString:@"0123456789+- "];
```

Save and read NSData to documents or cache folders with a single line of code:
```objc
[someData lsSaveToDirectory:NSDocumentDirectory fileName:@"data.bin" useExcludeFromBackup:NO];
NSData *data = [NSData lsReadDataFromDirectory:NSDocumentDirectory fileName:@"data.bin"];
NSArray *directoryContent = [NSData lsContentOfDirectory:NSDocumentDirectory];
[NSData lsCleanDirectory:NSDocumentDirectory];
```

Perform various common operations on NSDate easily:
```objc
NSDate *date = [NSDate lsDateWithStringWithISO8601:@"2017-02-03T00:00:00+01:00"];
NSDate *startOfDay = [date lsBeginningOfDay];
NSDate *startOfMonth = [date lsBeginningOfMonth];
NSDate *startOfYear = [date lsBeginningOfYear];
NSDate *endOfDay = [date lsEndOfDay];
NSDate *endOfMonth = [date lsEndOfMonth];
NSDate *endOfYear = [date lsEndOfYear];
NSDate *threeDaysLater = [date lsDateByAddingDays:3];
NSDate *twoMonthsLater = [date lsDateByAddingMonths:2];
NSDate *oneYearEarlier = [date lsDateByAddingYears:-1];
NSInteger year = [date lsYear];
NSInteger month = [date lsMonth];
NSInteger day = [date lsDay];
NSInteger daysDifference = [date lsDaysDifferenceFromDate:startOfYear];
NSInteger monthsDifference = [date lsMonthsDifferenceFromDate:startOfYear];
NSString *isoDateString = [date lsStringWithISO8601];
NSString *shortDateString = [date lsStringWithShortDate];
NSString *mediumDateTimeString = [date lsStringWithMediumDateTime];
NSString *longTimeString = [date lsStringWithLongTime];
BOOL isToday = [date lsIsToday];
BOOL isTomorrow = [date lsIsTomorow];
BOOL isYesterday = [date lsIsYesterday];
BOOL isEarlier = [date lsIsEarlierThanDate:endOfMonth];
BOOL isLater = [date lsIsLaterThanDate:endOfMonth];
BOOL isInBetween = [date lsIsInBetweenStartDate:startOfMonth endDate:endOfMonth];
```

Perform various common operations related to UIColor:
```objc
UIColor *color = [UIColor lsColorWithHexString:@"#FF0000"];
UIColor *otherColor = [UIColor lsColorWithRgba:0xFF00FF33];
UIColor *randomColor = [UIColor lsRandomColor];
UIColor *inverted = [randomColor lsInvertedColor];
NSString *hexString = [inverted lsRgbaHexString];
uint32_t rgba = [randomColor lsRgba];
CGFloat hue = [color lsHue];
CGFloat saturation = [color lsSaturation];
CGFloat brightness = [color lsBrightness];
```

Generate UIImages with color, gradient, triangle, ellipse, text and avatar placeholder images with initials from given name:
```objc
UIImage *red = [UIImage lsImageWithColor:[UIColor redColor] size:CGSizeMake(10, 10)];
UIImage *gradient = [UIImage lsGradientImageWithSize:CGSizeMake(100, 100) startColor:[UIColor redColor] endColor:[UIColor greenColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
UIImage *triangle = [UIImage lsTriangleImageWithColor:[UIColor blueColor] size:CGSizeMake(40, 30)];
UIImage *ellipse = [UIImage lsEllipseImageWithColor:[UIColor blueColor] size:CGSizeMake(70, 30)];
UIImage *imageWithText = [UIImage lsImageWithText:@"HELLO WORLD!" textColor:[UIColor whiteColor] backgroundColor:[UIColor blueColor] font:[UIFont boldSystemFontOfSize:20] size:CGSizeMake(200, 50)];
UIImage *avatar = [UIImage lsInitialsAvatarImageWithText:@"John Doe"];
```

Generate UIImages with any shape from UIBezierPaths:
```objc
UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 100) cornerRadius:20];
UIImage *image = [path lsImageWithStrokeColor:[UIColor blueColor] fillColor:[UIColor greenColor] backgroundColor:[UIColor redColor]];
```

Load animated GIF or animated PNG files:
```objc
UIImage *animatedGif = [UIImage lsAnimatedImageWithAnimatedImageName:@"animated.gif" framesPerSecond:25 bundle:nil];
UIImage *animatedPng = [UIImage lsAnimatedImageWithAnimatedImageName:@"animated.png" framesPerSecond:25 bundle:nil];
```

Perform common operations on existing UIImages:
```objc
UIImage *image = [UIImage imageNamed:@"image.png"];
UIImage *flippedHorizontally = [image lsImageFlippedHorizontally];
UIImage *flippedVertically = [image lsImageFlippedVertically];
UIImage *rotated = [image lsRotatedImageWithDegrees:45.0];
UIImage *resized = [image lsResizedImageWithSize:CGSizeMake(200, 100)];
UIImage *resizedProportional = [image lsResizedProportionalImageWithMaxSize:CGSizeMake(500, 500)];
UIImage *resizedWithWidth = [image lsResizedProportionalImageWithWidth:500];
UIImage *resizedWithHeight = [image lsResizedProportionalImageWithHeight:500];
UIImage *cropped = [image lsCroppedImageWithRect:CGRectMake(0, 20, 60, 20)];
UIImage *padded = [image lsPaddedImageWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
UIImage *inverted = [image lsInvertedImage];
UIImage *masked = [image lsMaskedImageWithMaskImage:mask];
UIImage *merged = [image lsMergedImageWithImage:rotated position:CGPointZero];
UIImage *rounded = [image lsRoundedImageWithCornerRadius:10];
NSData *pngData = [image lsPNG];
NSData *jpegData = [image lsJPEGWithCompressionLevel:0.8];
NSData *jpegDataWithSize = [image lsJPEGWithDesiredMaxSize:2000 allowAboveMax:NO];
NSData *rgbaRawData = [image lsRGBARawData];
UIImage *imageFromRawData = [UIImage lsImageWithRGBARawData:rgbaRawData size:CGSizeMake(20, 30)];
UIColor *averageImageColor = [image lsAverageColor];
```

Get NSData, NSString with HTML, NSDictionary from JSON or UIImage from given URL asynchronously:
```objc
[NSData lsDataFromUrl:[NSURL URLWithString:@"https://google.com"] handler:^(NSData *data, NSError *error) {
    // do something
}];
[NSString lsStringFromUrl:[NSURL URLWithString:@"https://github.com"] handler:^(NSString *string, NSError *error) {
    // do something
}];
[NSDictionary lsDictionaryFromJsonUrl:[NSURL URLWithString:@"https://dummyurl.com/json"] handler:^(NSDictionary *jsonDictionary, NSError *error) {
    // do something
}];
[UIImage lsImageFromUrl:[NSURL URLWithString:@"https://dummyurl.com/image.jpg"] useCache:YES useDiskCache:YES handler:^(UIImage *image, NSError *error) {
    // do something
}];
```

Easily set attributed text on UILabel from HTML tags or create attributed strings with HTML tags or your custom tags:
```objc
self.label.text = @"test <h1>with</h1> <s>some</s> <strong>basic</strong> <em>html</em> <u>tags</u>";
[self.label lsParseBasicHTMLTags];

NSAttributedString *attributedString = [@"Text with <strong>basic</strong> <em>HTML</em>" lsAttributedStringWithDefaultTagStylesheet];

NSAttributedString *withCustomTags = [@"Text with <custom>custom</custom> tag" lsAttributedStringWithTagStylesheet:@{ @"custom" : @{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSFontAttributeName : [UIFont systemFontOfSize:20] }}];
```

Add a border to UIView only on one edge:
```objc
[self.someView lsAddBorderOnEdge:UIRectEdgeBottom color:[UIColor blueColor] width:2];
// ...
[self.someView lsRemoveBordersOnEdges];
```

Make infinite rotations on your views easily:
```objc
[self.rotatingView lsStartInfiniteRotationWithDuration:2 clockwise:YES];
// ...
[self.rotatingView lsStopInfiniteRotation];
```

If you need a loader view simply use a standard rotating loader to cover a view when you load your data or show toasts with messages:
```objc
[self.view lsShowActivityIndicator];
// ...
[self.view lsHideActivityIndicator];
// or if you want some customization...
[self.view lsShowActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge color:[UIColor redColor] backgroundColor:[UIColor whiteColor] coverColor:[UIColor yellowColor] text:@"Downloading data"];
// you can also cover the whole screen instead of a single view with a global activity indicator like this
[UIView lsShowSharedActivityIndicator];
// and hide it with
[UIView lsHideSharedActivityIndicator];
// show a toast
[UIView lsShowSharedToastWithText:@"Hello there!"];
// and hide it
[UIView lsHideSharedToast];
```

Change custom properties of any object over time (for example for animating something which cannot be animated in a standard way):
```objc
[UIView lsRepeatWithDuration:2 delay:3 framesPerSecond:60 block:^(CGFloat progress) {
    self.label.text = @(progress * 1000).stringValue;
} completionBlock:nil];
// actually for animating incrementing or decrementing a number
// on a UILabel like above you can also use a shortcut
[self.label lsAnimateCounterWithStartValue:10 endValue:1000 duration:2 completionBlock:nil];
```

Limit editing UITextField with a single line of code and easily change text padding, placeholder color, and clear button look:
```objc
// limit string length in the field
[self.textField lsSetMaxLength:4];
// or limit edition to entering decimal numbers only with specified number of digits before and after decimal point
[self.textField lsSetAllowedDecimalsWithIntegerPart:4 fractionalPart:2];
// or limit characters that can be entered in the field with NSCharacterSet
[self.textField lsSetAllowedCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"abc"]];
// or limit text entry with a regular expression
[self.textField lsSetAllowedRegex:@"^[0-9]{0,4}$"];
// change the color of the clear button...
[self.textField lsSetClearButtonWithColor:[UIColor redColor] mode:UITextFieldViewModeAlways];
// or the image used for clear button
[self.textField lsSetClearButtonWithImage:image mode:UITextFieldViewModeWhileEditing];
// adjust text padding without subclassing
[self.textField lsSetLeftPadding:10];
// set a placeholder text with given color
[self.textField lsSetPlaceholder:@"Placeholder" color:[UIColor redColor]];
```

Use UINavigationController with completion blocks:
```objc
[self.navigationController lsPushViewController:vc animated:YES completionBlock:^{
    // do something
}];
[self.navigationController lsPopViewControllerAnimated:YES completionBlock:^{
    // do something
}];
```

Customize colors on navigation bar or tab bar easily:
```objc
[self.navigationController lsSetNavigationBarColor:[UIColor redColor] titleColor:[UIColor whiteColor] buttonsColor:[UIColor yellowColor] borderColor:[UIColor blackColor]];
[self.tabBarController lsSetTabBarColor:[UIColor redColor] itemColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] selectedItemColor:[UIColor whiteColor] borderColor:[UIColor blackColor]];
```

Catch Objective-c exceptions in given block. This is useful if you are programming in Swift language and you need to catch an Objective-C exception from Swift code.
```objc
NSException *exception = [NSException lsTryCatchWithBlock:^{
    // some code that throws Objective-C exception which cannot be catched from pure Swift code
    // for example something like this below
    [viewController setValue:@"test" forKey:@"nonExistingKey"];
}];
```

Send events from any object and subscribe to them with a handler, or use key value observing in a simple way with handlers:
```objc
[self lsSendEvent:@"DataRefreshedEvent" data:nil];
// ...
[someObject lsSubscribeForEvent:@"DataRefreshedEvent" handler:^(id data) {
    // do something
}];
// ...
[someObject lsObserveValueForKeyPath:@"test" handler:^(NSDictionary * _Nullable change) {
    // do something when test property changed
}];
```

Get current date and time from a public online time server if you need to be sure that you are working on a valid current date:
```objc
[NSDate lsDateFromOnlineServerWithHandler:^(NSDate * _Nullable date) {
    // do something with NSDate returned by a time server
}];
```

Enable automatic keyboard handling which includes automatic scroll of scrollviews with text fields, automatic next and done keyboard actions (for switching to next text field or closing the keyboard), and automatic keyboard hidding when tapped outside of a text field with a single line of code called in your view controller:
```objc
[self lsEnableAutomaticKeyboardHandling];
// or enable only some of these features for specific views depending on your needs
[self.view lsEnableHideKeyboardOnTap];
[self.textField lsEnableAutomaticNextAndDoneButtonsOnKeyboard];
[self.otherTextField lsEnableAutomaticReturnButtonOnKeyboard];
[self.scrollView lsEnableAutomaticScrollAdjustmentsWhenKeyboardAppear];
```

Easily add asking for rating in the app store to your application when specific conditions are met to get the best ratings from your app users in the app store:
```objc
// in app delegate log app launch...
[[UIApplication sharedApplication] lsLogLaunchForAppRating];
// log some important events in your app...
[[UIApplication sharedApplication] lsLogSignificantEventForAppRating];
// and then ask for rating when user performed desired number of important events and uses the app for specific amount of time
[[UIApplication sharedApplication] lsAskForAppRatingIfReachedMinimumDaysOfUse:5 minimumSignificantEvents:7];
```

These are only few things you can do with LSCategories. You can check TestProject for few other examples.

## License
LSCategories is available under the MIT license. See [LICENSE](https://github.com/fins/LSCategories/blob/master/LICENSE).
