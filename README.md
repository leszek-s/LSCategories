# LSCategories
**LSCategories** is a collection of useful Foundation and UIKit categories created to simplify some common operations and speed up the development process.
## Features
Some things which can be easily done with LSCategories are listed below.

Create various type of hashes with single line of code from NSString or NSData:
```objc
NSString *sha1 = [@"Test string" lsSHA1];
NSString *sha224 = [@"Test string" lsSHA224];
NSString *sha256 = [@"Test string" lsSHA256];
NSString *sha384 = [@"Test string" lsSHA384];
NSString *sha512 = [@"Test string" lsSHA512];
NSString *md2 = [@"Test string" lsMD2];
NSString *md4 = [@"Test string" lsMD4];
NSString *md5 = [@"Test string" lsMD5];
```

Put an image inside a string easily:
```objc
NSAttributedString *withPrefix = [@"text" lsAttributedStringWithPrefixImage:[UIImage imageNamed:@"image.png"]];
NSAttributedString *withSuffix = [@"text" lsAttributedStringWithSuffixImage:[UIImage imageNamed:@"image.png"]];
NSAttributedString *withImageInside = [@"text with image" lsAttributedStringByReplacingCharactersInRange:NSMakeRange(10, 0) withImage:[UIImage imageNamed:@"image.png"]];
```

Obfuscate NSData or NSString with XOR or ROT13:
```objc
NSData *data = [@"Some data to xor" lsDataUTF8];
NSData *key = [@"key" lsDataUTF8];
NSData *xoredData = [data lsDataXORedWithKey:key];
NSString *rot13 = [@"Some string" lsROT13String];
```

Save and read NSData to documents or cache folders:
```objc
[someData lsSaveToDirectory:NSDocumentDirectory fileName:@"data" useExcludeFromBackup:NO];
NSData *data = [NSData lsReadDataFromDirectory:NSDocumentDirectory fileName:@"data"];
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

Generate UIImages with color, gradient, triangle or ellipse:
```objc
UIImage *red = [UIImage lsImageWithColor:[UIColor redColor] size:CGSizeMake(10, 10)];
UIImage *gradient = [UIImage lsGradientImageWithSize:CGSizeMake(100, 100) startColor:[UIColor redColor] endColor:[UIColor greenColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
UIImage *triangle = [UIImage lsTriangleImageWithColor:[UIColor blueColor] size:CGSizeMake(40, 30)];
UIImage *ellipse = [UIImage lsEllipseImageWithColor:[UIColor blueColor] size:CGSizeMake(70, 30)];
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
NSData *pngData = [image lsPNG];
NSData *jpegData = [image lsJPEGWithCompressionLevel:0.8];
NSData *jpegDataWithSize = [image lsJPEGWithDesiredMaxSize:2000 allowAboveMax:NO];
NSData *rgbaRawData = [green lsRGBARawData];
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

[UIImage lsImageFromUrl:[NSURL URLWithString:@"https://dummyurl.com/image.jpg"] useCache:YES handler:^(UIImage *image, NSError *error) {
    // do something
}];
```

Easily set attributed text on UILabel from HTML tags or create attributed strings with HTML tags or your custom tags:
```objc
self.label.text = @"test <h1>with</h1> <s>some</s> <strong>basic</strong> <em>html</em> <u>tags</u>";
[self.label lsParseBasicHTMLTags];

NSAttributedString *attributedString = [@"Text with <strong>basic</strong> <em>HTML</em>" lsAttributedStringWithDefaultTagStylesheet];

NSAttributedString *withCustomTags = [@"Text with <custom>custom</custom> tag" lsAttributedStringWithTagStylesheet:@{ @"custom" : @{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSFontAttributeName : [UIFont systemFontOfSize:20] }}];
}];
```

Add a border to UIView only on one edge:
```objc
[self.someView lsAddBorderOnEdge:UIRectEdgeBottom color:[UIColor blueColor] width:2];
// ...
[self.someView lsRemoveBordersOnEdges];
```

Make infinite rotations on your views easily or if you need a loader view just use some standard rotating loader to cover a view when you load your data:
```objc
[self.rotatingView lsStartInfiniteRotationWithDuration:2 clockwise:YES];
// ...
[self.rotatingView lsStopInfiniteRotation];
[self.view lsShowActivityIndicator];
// ...
[self.view lsHideActivityIndicator];
// or if you want some customization...
[self.view lsShowActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhiteLarge color:[UIColor redColor] backgroundColor:[UIColor whiteColor] coverColor:[UIColor yellowColor]];
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

Send events from any object (not only UIControls) and subscribe to events sent by given object with a handler:
```objc
[self lsSendEvent:@"DataRefreshedEvent" data:nil];
// ...
[someObject lsSubscribeForEvent:@"DataRefreshedEvent" handler:^(id data) {
	// do something
}];
```

These are only few things you can do with LSCategories. See [DOCUMENTATION](http://cocoadocs.org/docsets/LSCategories/) for more. You can also check TestProject for few other examples.

## License
LSCategories is available under the MIT license. See [LICENSE](https://github.com/fins/LSCategories/blob/master/LICENSE).
