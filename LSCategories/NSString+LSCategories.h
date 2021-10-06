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

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LSCategories)

/**
 Returns matches found with given regular expression.

 @param regex Regular expression.
 @return Array with matches.
 */
- (nullable NSArray<NSString *> *)lsMatchesWithRegex:(NSString *)regex;

/**
 Returns matches together with matched regex capture groups found with given regular expression.

 @param regex Regular expression.
 @return Array with array of matches and matched regex capture groups.
 */
- (nullable NSArray<NSArray<NSString *> *> *)lsMatchesAndGroupsWithRegex:(NSString *)regex;

/**
 Returns a string with regex pattern replaced by given template.

 @param regexPattern Regular expression.
 @param templateString Template for replacing.
 @return String with regex pattern replaced by given template.
 */
- (nullable NSString *)lsStringByReplacingRegexPattern:(NSString *)regexPattern templateString:(NSString *)templateString;

/**
 Returns range of substring between given start string and end string or {NSNotFound, 0} if not found.

 @param startString Start string.
 @param endString End string.
 @return Range of substring or {NSNotFound, 0} if not found.
 */
- (NSRange)lsRangeOfSubstringBetweenStartString:(NSString *)startString endString:(NSString *)endString;

/**
 Returns substring between given start string and end string or nil if not found.

 @param startString Start string.
 @param endString End string.
 @return Substring or nil if not found.
 */
- (nullable NSString *)lsSubstringBetweenStartString:(NSString *)startString endString:(NSString *)endString;

/**
 Returns array with all ranges of given substring or empty array if substring not found.

 @param string Substring to find.
 @return Array with all ranges of given substring or empty array if substring not found.
 */
- (NSArray<NSValue *> *)lsAllRangesOfString:(NSString *)string;

/**
 Returns array with all ranges of substrings between given start string and end string or empty array if not found.

 @param startString Start string.
 @param endString End string.
 @return Array with all ranges of substrings between given start string and end string or empty array if not found.
 */
- (NSArray<NSValue *> *)lsRangesOfAllSubstringsBetweenStartString:(NSString *)startString endString:(NSString *)endString;

/**
 Returns array with all substrings between given start string and end string or empty array if not found.

 @param startString Start string.
 @param endString End string.
 @return Array with all substrings between given start string and end string or empty array if not found.
 */
- (NSArray<NSString *> *)lsAllSubstringsBetweenStartString:(NSString *)startString endString:(NSString *)endString;

/**
 Returns attributed string.

 @return Attributed string.
 */
- (NSAttributedString *)lsAttributedString;

/**
 Returns attributed string with inline image inserted at the beginning of string.
 
 @param image Image to insert.
 @return Attributed string with inline image inserted at the beginning of string.
 */
- (NSAttributedString *)lsAttributedStringWithPrefixImage:(UIImage *)image;

/**
 Returns attributed string with inline image inserted at the end of string.
 
 @param image Image to insert.
 @return Attributed string with inline image inserted at the end of string.
 */
- (NSAttributedString *)lsAttributedStringWithSuffixImage:(UIImage *)image;

/**
 Returns attributed string in which given substring is replaced with an image.
 
 @param string Substring that should be replaced with an image.
 @param image Image which should be used for replacing.
 @param verticalOffset Vertical offset for the image.
 @return Attributed string in which given substring is replaced with an image.
 */
- (NSAttributedString *)lsAttributedStringByReplacingOccurrenceOfString:(NSString *)string withImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset;

/**
 Returns attributed string with inline image inserted in specified range.
 
 @param range Range which should be replaced.
 @param image Image which should be used for replacing.
 @return Attributed string with inline image inserted in specified range.
 */
- (NSAttributedString *)lsAttributedStringByReplacingCharactersInRange:(NSRange)range withImage:(UIImage *)image;

/**
 Returns attributed string with inline image inserted in specified range.
 
 @param range Range which should be replaced.
 @param image Image which should be used for replacing.
 @param verticalOffset Vertical offset for the image.
 @return Attributed string with inline image inserted in specified range.
 */
- (NSAttributedString *)lsAttributedStringByReplacingCharactersInRange:(NSRange)range withImage:(UIImage *)image verticalOffset:(CGFloat)verticalOffset;

/**
 Returns attributed string created with default tag stylesheet.

 @return Attributed string created with default tag stylesheet.
 */
- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheet;

/**
 Returns attributed string created with default tag stylesheet and given base font.

 @param baseFont Base font.
 @return Attributed string created with default tag stylesheet and given base font.
 */
- (NSAttributedString *)lsAttributedStringWithDefaultTagStylesheetAndBaseFont:(UIFont *)baseFont;

/**
 Returns attributed string created with given tag stylesheet.

 @param stylesheet Stylesheet dictionary.
 @return Attributed string created with given tag stylesheet.
 */
- (NSAttributedString *)lsAttributedStringWithTagStylesheet:(NSDictionary *)stylesheet;

/**
 Creates and returns string from given url asynchronously.
 
 @param url The URL from which to read string.
 @param handler Handler to execute after reading.
 */
+ (void)lsStringFromUrl:(NSURL *)url handler:(void (^)(NSString * _Nullable string, NSError * _Nullableerror))handler;

/**
 Returns random string with given length.

 @param length Length.
 @return Random string with given length.
 */
+ (NSString *)lsRandomStringWithLength:(NSUInteger)length;

/**
 Returns random string with given length and alphabet.

 @param length Length.
 @param alphabet Alphabet.
 @return Random string with given length and alphabet.
 */
+ (NSString *)lsRandomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

/**
 Returns data with string encoded in UTF8 encoding.
 
 @return Data with string encoded in UTF8 encoding.
 */
- (nullable NSData *)lsDataUTF8;

/**
 Returns reversed string.

 @return Reversed string.
 */
- (NSString *)lsReversedString;

/**
 Returns string encrypted with ROT5 substitution cipher.

 @return String encrypted with ROT5 substitution cipher.
 */
- (NSString *)lsROT5String;

/**
 Returns string encrypted with ROT13 substitution cipher.

 @return String encrypted with ROT13 substitution cipher.
 */
- (nullable NSString *)lsROT13String;

/**
 Returns string encrypted with ROT18 substitution cipher.

 @return String encrypted with ROT18 substitution cipher.
 */
- (nullable NSString *)lsROT18String;

/**
 Returns UUID string.

 @return UUID string.
 */
+ (NSString *)lsUUID;

/**
 Return string with alphanumeric characters only.

 @return String with alphanumeric characters only.
 */
- (NSString *)lsStringByRemovingNonAlphanumeric;

/**
 Return string with alphanumeric and whitespace characters only.

 @return String with alphanumeric and whitespace characters only.
 */
- (NSString *)lsStringByRemovingNonAlphanumericAndNonWhitespace;

/**
 Return string with numeric characters only.
 
 @return String with numeric characters only.
 */
- (NSString *)lsStringByRemovingNonNumeric;

/**
 Return string with letters only.
 
 @return String with letters only.
 */
- (NSString *)lsStringByRemovingNonLetters;

/**
 Returns string without characters which are not in given string.

 @param string String with characters to leave in result.
 @return String without characters which are not in given string.
 */
- (NSString *)lsStringByRemovingCharactersNotInString:(NSString *)string;

/**
 Returns a number from a string with a hexadecimal integer.
 
 @return Number from a string with a hexadecimal integer.
 */
- (nullable NSNumber *)lsNumberFromHexString;

/**
 Returns YES if string is a valid email address.
 
 @return YES if string is a valid email address.
 */
- (BOOL)lsIsValidEmail;

/**
 Appends string to file at given path.

 @param path File path.
 */
- (void)lsAppendToFileAtPath:(NSString *)path;

/**
 Returns CRC32 checksum from string.
 
 @return CRC32 checksum from string.
 */
- (uint32_t)lsCRC32;

/**
 Returns Adler32 checksum from string.
 
 @return Adler32 checksum from string.
 */
- (uint32_t)lsAdler32;

/**
 Returns MD2 hash from string.
 
 @return MD2 hash from string.
 */
- (nullable NSString *)lsMD2;

/**
 Returns MD4 hash from string.
 
 @return MD4 hash from string.
 */
- (nullable NSString *)lsMD4;

/**
 Returns MD5 hash from string.
 
 @return MD5 hash from string.
 */
- (nullable NSString *)lsMD5;

/**
 Returns SHA1 hash from string.
 
 @return SHA1 hash from string.
 */
- (nullable NSString *)lsSHA1;

/**
 Returns SHA224 hash from string.
 
 @return SHA224 hash from string.
 */
- (nullable NSString *)lsSHA224;

/**
 Returns SHA256 hash from string.
 
 @return SHA256 hash from string.
 */
- (nullable NSString *)lsSHA256;

/**
 Returns SHA384 hash from string.
 
 @return SHA384 hash from string.
 */
- (nullable NSString *)lsSHA384;

/**
 Returns SHA512 hash from string.
 
 @return SHA512 hash from string.
 */
- (nullable NSString *)lsSHA512;

@end

NS_ASSUME_NONNULL_END
