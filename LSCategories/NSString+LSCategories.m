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

- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheet
{
    return [self lsAttributedStringWithDefaultTagStylesheetAndBaseFont:[UIFont systemFontOfSize:14]];
}

- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheetAndBaseFont:(UIFont *)baseFont
{
    NSDictionary *stylesheet = @{ @"default" : @{ NSFontAttributeName : [baseFont lsNormalFont] },
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
        [attributedString deleteCharactersInRange:range.rangeValue];
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

+ (NSString *)lsEncodedUrlParameter:(id)parameter
{
    NSString *string = [NSString stringWithFormat:@"%@", parameter];
    NSString *encoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[]\" "), kCFStringEncodingUTF8));
    return encoded;
}

+ (NSString *)lsRandomStringWithLength:(NSUInteger)length
{
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUV0123456789~`!@#$%^&*()_+=-[]{}:;/.,<>?";
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

- (NSString *)lsROT13String
{
    const char *input = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = self.length;
    char string[length + 1];
    
    for (int i = 0; i <= length; i++)
    {
        char x = input[i];
        if (x > 0x40 && x < 0x5B)
        {
            string[i] = x + 0x0D >= 0x5B ? x + 0x0D - 0x1A : x + 0x0D;
        }
        else if (x > 0x60 && x < 0x7B)
        {
            string[i] = x + 0x0D >= 0x7B ? x + 0x0D - 0x1A : x + 0x0D;
        }
        else
        {
            string[i] = x;
        }
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
