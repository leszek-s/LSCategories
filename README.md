# LSCategories
**LSCategories** is a collection of useful Foundation and UIKit categories.
## Features
Some things you can do with LSCategories using a single line of code are listed below.

Calculate MD5, SHA1 and other hashes from NSData or NSString:

    NSString *hash = [@"Test string" lsSHA1];

Reverse a string:

    NSString *reversed = [@"Test string" lsReversedString];

Save NSData to documents or cache folder:

    [someData lsSaveToDirectory:NSDocumentDirectory fileName:@"data" useExcludeFromBackup:NO];

Read saved NSData:

    NSData *data = [NSData lsReadDataFromDirectory:NSDocumentDirectory fileName:@"data"];

Get beginning or end of day, month or year:

    NSDate *date = [[NSDate new] lsBeginningOfDay];

Get NSString from NSDate in various formats for example:

    NSString *shortDateWithoutTime = [[NSDate new] lsStringWithShortDate])

Get UIColor from NSString in various formats for example:

    UIColor *color = [UIColor lsColorWithHexString:@"#FF0000"]

Generate UIImage with color:

    UIImage *redImage = [UIImage lsImageWithColor:[UIColor redColor] size:CGSizeMake(10, 10)];

Generate UIImage with gradient:

    UIImage *gradient = [UIImage lsGradientImageWithSize:CGSizeMake(100, 100) startColor:[UIColor redColor] endColor:[UIColor greenColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];

Resize UIImage:

    UIImage *resized = [image lsResizedImageWithSize:CGSizeMake(100, 100)];

Rotate UIImage:

    UIImage *rotated = [image lsRotatedImageWithRadians:M_PI_2];

Use NSString with basic HTML tags to create NSAttributedString:

    self.label.attributedText = [@"Text with <strong>basic</strong>, <em>HTML</em>" lsAttributedStringWithDefaultTagStylesheet];

Use NSString with custom tags to create NSAttributedString:

    self.label.attributedText = [@"Text with <custom>custom</custom> tag" lsAttributedStringWithTagStylesheet:@{ @"custom" : @{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSFontAttributeName : [UIFont systemFontOfSize:20] }}];

Animate incrementing or decrementing a number in UILabel:

    [self.label lsAnimateCounterWithStartValue:1 endValue:100 duration:2 completionBlock:nil];

Add a border to UIView only on one edge:

    [self.someView lsAddBorderOnEdge:UIRectEdgeBottom color:[UIColor blueColor] width:2];

These are only few things you can do with LSCategories. See [DOCUMENTATION](http://cocoadocs.org/docsets/LSCategories/) for more.

## License
LSCategories is available under the MIT license. See [LICENSE](https://github.com/fins/LSCategories/blob/master/LICENSE).
