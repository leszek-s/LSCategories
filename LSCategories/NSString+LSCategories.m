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

#import <UIKit/UIKit.h>
#import "NSString+LSCategories.h"
#import "NSData+LSCategories.h"
#import "UIFont+LSCategories.h"

@implementation NSString (LSCategories)

- (NSArray<NSString *> *)lsMatchesWithRegex:(NSString *)regex
{
    if (self.length == 0 || regex.length == 0)
        return nil;
    
    NSError *error;
    NSRegularExpression *regexpression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
    NSArray *matches = [regexpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *data = [NSMutableArray new];
    for (NSTextCheckingResult *match in matches)
    {
        NSString *groupString = [self substringWithRange:[match range]];
        [data addObject:groupString ? groupString : @""];
    }
    return [data copy];
}

- (NSArray<NSArray<NSString *> *> *)lsMatchesAndGroupsWithRegex:(NSString *)regex
{
    if (self.length == 0 || regex.length == 0)
        return nil;
    
    NSError *error;
    NSRegularExpression *regexpression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
    NSArray *matches = [regexpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *data = [NSMutableArray new];
    for (NSTextCheckingResult *match in matches)
    {
        NSMutableArray *matchData = [NSMutableArray new];
        for (NSInteger i = 0; i < match.numberOfRanges; i++)
        {
            NSRange groupRange = [match rangeAtIndex:i];
            NSString *groupString = [self substringWithRange:groupRange];
            [matchData addObject:groupString ? groupString : @""];
        }
        [data addObject:[matchData copy]];
    }
    return [data copy];
}

- (NSString *)lsStringByReplacingRegexPattern:(NSString *)regexPattern templateString:(NSString *)templateString
{
    if (regexPattern.length == 0 || templateString.length == 0)
        return nil;
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:nil];
    return [regularExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:templateString];
}

- (NSRange)lsRangeOfSubstringBetweenStartString:(NSString *)startString endString:(NSString *)endString
{
    NSArray *ranges = [self lsRangesOfAllSubstringsBetweenStartString:startString endString:endString];
    return ranges.firstObject ? ((NSValue *)ranges.firstObject).rangeValue : NSMakeRange(NSNotFound, 0);
}

- (NSString *)lsSubstringBetweenStartString:(NSString *)startString endString:(NSString *)endString
{
    NSRange range = [self lsRangeOfSubstringBetweenStartString:startString endString:endString];
    return (range.location != NSNotFound) ? [self substringWithRange:range] : nil;
}

- (NSArray *)lsAllRangesOfString:(NSString *)string
{
    NSMutableArray *ranges = [NSMutableArray new];
    
    BOOL finished = NO;
    NSUInteger postion = 0;
    while (!finished)
    {
        finished = YES;
        NSRange range = [self rangeOfString:string options:0 range:NSMakeRange(postion, self.length - postion)];
        if (range.location != NSNotFound)
        {
            [ranges addObject:[NSValue valueWithRange:range]];
            postion = range.location + range.length;
            finished = NO;
        }
    }
    return [ranges copy];
}

- (NSArray *)lsRangesOfAllSubstringsBetweenStartString:(NSString *)startString endString:(NSString *)endString
{
    NSMutableArray *ranges = [NSMutableArray new];
    
    BOOL finished = NO;
    NSUInteger postion = 0;
    while (!finished)
    {
        finished = YES;
        NSRange startRange = [self rangeOfString:startString options:0 range:NSMakeRange(postion, self.length - postion)];
        if (startRange.location != NSNotFound)
        {
            NSRange targetRange;
            targetRange.location = startRange.location + startRange.length;
            targetRange.length = self.length - targetRange.location;
            NSRange endRange = [self rangeOfString:endString options:0 range:targetRange];
            if (endRange.location != NSNotFound)
            {
                targetRange.length = endRange.location - targetRange.location;
                [ranges addObject:[NSValue valueWithRange:targetRange]];
                postion = targetRange.location + targetRange.length;
                finished = NO;
            }
        }
    }
    return [ranges copy];
}

- (NSArray *)lsAllSubstringsBetweenStartString:(NSString *)startString endString:(NSString *)endString
{
    NSArray *ranges = [self lsRangesOfAllSubstringsBetweenStartString:startString endString:endString];
    NSMutableArray *subStrings = [NSMutableArray new];
    for (NSValue *range in ranges)
    {
        NSRange rangeValue = range.rangeValue;
        NSString *subString = [self substringWithRange:rangeValue];
        [subStrings addObject:subString];
    }
    return [subStrings copy];
}

- (NSAttributedString *)lsAttributedString
{
    return [[NSAttributedString alloc] initWithString:self];
}

- (NSAttributedString *)lsAttributedStringWithPrefixImage:(UIImage *)image
{
    return [self lsAttributedStringByReplacingCharactersInRange:NSMakeRange(0, 0) withImage:image];
}

- (NSAttributedString *)lsAttributedStringWithSuffixImage:(UIImage *)image
{
    return [self lsAttributedStringByReplacingCharactersInRange:NSMakeRange(self.length, 0) withImage:image];
}

- (NSAttributedString *)lsAttributedStringByReplacingOccurrenceOfString:(NSString *)string withImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset
{
    NSRange range = [self rangeOfString:string options:0 range:NSMakeRange(0, self.length)];
    if (range.location != NSNotFound)
    {
        return [self lsAttributedStringByReplacingCharactersInRange:range withImage:image verticalOffset:verticalOffset];
    }
    return [[NSMutableAttributedString alloc] initWithString:self];
}

- (NSAttributedString *)lsAttributedStringByReplacingCharactersInRange:(NSRange)range withImage:(UIImage *)image
{
    return [self lsAttributedStringByReplacingCharactersInRange:range withImage:image verticalOffset:0];
}

- (NSAttributedString *)lsAttributedStringByReplacingCharactersInRange:(NSRange)range withImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset
{
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, verticalOffset, image.size.width, image.size.height);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString replaceCharactersInRange:range withAttributedString:attachmentString];
    return [attributedString copy];
}

- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheet
{
    return [self lsAttributedStringWithDefaultTagStylesheetAndBaseFont:[UIFont systemFontOfSize:14]];
}

- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheetAndBaseFont:(UIFont *)baseFont
{
    NSDictionary *stylesheet = @{ @"default" : @{ NSFontAttributeName : [baseFont lsNormalFont] },
                                  @"textAttachment" : @{ NSAttachmentAttributeName : [NSTextAttachment new] },
                                  @"strong" : @{ NSFontAttributeName : [baseFont lsBoldFont] },
                                  @"em" : @{ NSFontAttributeName : [baseFont lsItalicFont ] },
                                  @"b" : @{ NSFontAttributeName : [baseFont lsBoldFont ] },
                                  @"i" : @{ NSFontAttributeName : [baseFont lsItalicFont] },
                                  @"u" : @{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) },
                                  @"s" : @{ NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle) },
                                  @"h1" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 2] },
                                  @"h2" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 1.5] },
                                  @"h3" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 1.33] },
                                  @"h4" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 1.17] },
                                  @"h5" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 0.83] },
                                  @"h6" : @{ NSFontAttributeName : [baseFont lsNormalFontWithSize:baseFont.pointSize * 0.67] } };
    return [self lsAttributedStringWithTagStylesheet:stylesheet];
}

- (NSAttributedString *)lsAttributedStringWithTagStylesheet:(NSDictionary *)stylesheet
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableArray *tagsRanges = [NSMutableArray new];
    NSMutableArray *textAttachmentRanges = [NSMutableArray new];
    
    if (stylesheet[@"default"])
    {
        [attributedString addAttributes:stylesheet[@"default"] range:NSMakeRange(0, self.length)];
    }
    
    for (NSString *tag in stylesheet.allKeys)
    {
        if ([tag isEqualToString:@"default"])
            continue;
        
        NSDictionary *style = stylesheet[tag];
        
        NSString *startTag = [NSString stringWithFormat:@"<%@>", tag];
        NSString *endTag = [NSString stringWithFormat:@"</%@>", tag];
        
        NSArray *rangesBetweenTag = [self lsRangesOfAllSubstringsBetweenStartString:startTag endString:endTag];
        for (NSValue *range in rangesBetweenTag)
        {
            if ([tag isEqualToString:@"textAttachment"])
            {
                [tagsRanges addObject:range];
                [textAttachmentRanges addObject:range];
            }
            [attributedString addAttributes:style range:range.rangeValue];
            NSRange startTagRange = NSMakeRange(range.rangeValue.location - startTag.length, startTag.length);
            NSRange endTagRange = NSMakeRange(range.rangeValue.location + range.rangeValue.length, endTag.length);
            [tagsRanges addObject:[NSValue valueWithRange:startTagRange]];
            [tagsRanges addObject:[NSValue valueWithRange:endTagRange]];
        }
    }
    
    [tagsRanges sortUsingComparator:^NSComparisonResult(NSValue *range1, NSValue *range2) {
        return [@(range2.rangeValue.location) compare:@(range1.rangeValue.location)];
    }];
    
    for (NSValue *range in tagsRanges)
    {
        if ([textAttachmentRanges containsObject:range])
        {
            NSString *content = [self substringWithRange:range.rangeValue];
            NSData *data = [[NSData alloc] initWithBase64EncodedString:content options:0];
            UIImage *image = [UIImage imageWithData:data ? data : [NSData new]];
            if (image)
            {
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = image;
                attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                [attributedString replaceCharactersInRange:range.rangeValue withAttributedString:attachmentString];
            }
            else
            {
                [attributedString deleteCharactersInRange:range.rangeValue];
            }
        }
        else
        {
            [attributedString deleteCharactersInRange:range.rangeValue];
        }
    }
    
    return [attributedString copy];
}

+ (void)lsStringFromUrl:(NSURL *)url handler:(void (^)(NSString *string, NSError *error))handler
{
    if (!handler || !url)
    {
        if (handler)
            handler(nil, nil);
        return;
    }
    [NSData lsDataFromUrl:url handler:^(NSData *data, NSError *error) {
        NSString *string = nil;
        if (data)
        {
            string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!string)
                string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        }
        handler(string, error);
    }];
}

+ (NSString *)lsRandomStringWithLength:(NSUInteger)length
{
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}[]<>?";
    return [self lsRandomStringWithLength:length alphabet:alphabet];
}

+ (NSString *)lsRandomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet
{
    NSUInteger max = alphabet.length;
    NSMutableString *random = [NSMutableString stringWithCapacity:length];
    for (NSInteger i = 0; i < length; i++)
        [random appendString:[alphabet substringWithRange:NSMakeRange(arc4random_uniform((uint32_t)max), 1)]];
    return [random copy];
}

- (NSData *)lsDataUTF8
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)lsReversedString
{
    NSMutableString *reversed = [NSMutableString stringWithCapacity:self.length];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reversed appendString:substring];
    }];
    return [reversed copy];
}

- (NSString *)lsROT5String
{
    const char *input = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = self.length;
    char string[length + 1];
    
    for (int i = 0; i <= length; i++)
    {
        char x = input[i];
        if (x >= '0' && x <= '9')
            string[i] = x + 5 > '9' ? x - 5 : x + 5;
        else
            string[i] = x;
    }
    return [NSString stringWithCString:string encoding:NSASCIIStringEncoding];
}

- (NSString *)lsROT13String
{
    const char *input = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = self.length;
    char string[length + 1];
    
    for (int i = 0; i <= length; i++)
    {
        char x = input[i];
        if (x >= 'A' && x <= 'Z')
            string[i] = x + 13 > 'Z' ? x - 13 : x + 13;
        else if (x >= 'a' && x <= 'z')
            string[i] = x + 13 > 'z' ? x - 13 : x + 13;
        else
            string[i] = x;
    }
    return [NSString stringWithCString:string encoding:NSASCIIStringEncoding];
}

- (NSString *)lsROT18String
{
    const char *input = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = self.length;
    char string[length + 1];
    
    for (int i = 0; i <= length; i++)
    {
        char x = input[i];
        if (x >= 'A' && x <= 'Z')
            string[i] = x + 13 > 'Z' ? x - 13 : x + 13;
        else if (x >= 'a' && x <= 'z')
            string[i] = x + 13 > 'z' ? x - 13 : x + 13;
        else if (x >= '0' && x <= '9')
            string[i] = x + 5 > '9' ? x - 5 : x + 5;
        else
            string[i] = x;
    }
    return [NSString stringWithCString:string encoding:NSASCIIStringEncoding];
}

+ (NSString *)lsUUID
{
    return [NSUUID UUID].UUIDString;
}

- (NSString *)lsStringByRemovingNonAlphanumeric
{
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet alphanumericCharacterSet].invertedSet] componentsJoinedByString:@""];
    return filtered;
}

- (NSString *)lsStringByRemovingNonAlphanumericAndNonWhitespace
{
    NSMutableCharacterSet *set = [[NSCharacterSet alphanumericCharacterSet] mutableCopy];
    [set formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:set.invertedSet] componentsJoinedByString:@""];
    return filtered;
}

- (NSString *)lsStringByRemovingNonNumeric
{
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet] componentsJoinedByString:@""];
    return filtered;
}

- (NSString *)lsStringByRemovingNonLetters
{
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet letterCharacterSet].invertedSet] componentsJoinedByString:@""];
    return filtered;
}

- (NSString *)lsStringByRemovingCharactersNotInString:(NSString *)string
{
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:string].invertedSet] componentsJoinedByString:@""];
    return filtered;
}

- (NSNumber *)lsNumberFromHexString
{
    NSString *input = [self uppercaseString];
    input = [input stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    unsigned long long number;
    NSScanner *scanner = [NSScanner scannerWithString:input];
    if (![scanner scanHexLongLong:&number])
        return nil;
    return @(number);
}

- (BOOL)lsIsValidEmail
{
    return [self rangeOfString:@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$" options:NSRegularExpressionSearch].location != NSNotFound;
}

- (void)lsAppendToFileAtPath:(NSString *)path
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSData new] writeToFile:path atomically:YES];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
}

- (uint32_t)lsCRC32
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsCRC32];
}

- (uint32_t)lsAdler32
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsAdler32];
}

- (NSString *)lsMD2
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsMD2];
}

- (NSString *)lsMD4
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsMD4];
}

- (NSString *)lsMD5
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsMD5];
}

- (NSString *)lsSHA1
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsSHA1];
}

- (NSString *)lsSHA224
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsSHA224];
}

- (NSString *)lsSHA256
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsSHA256];
}

- (NSString *)lsSHA384
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsSHA384];
}

- (NSString *)lsSHA512
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lsSHA512];
}

@end
