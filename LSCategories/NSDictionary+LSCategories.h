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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LSCategories)

/**
 Creates and returns json dictionary from given url asynchronously.
 If json root object under url is an array then it will be put in dictionary under key root.

 @param url The URL from which to read json.
 @param handler Handler to execute after reading.
 */
+ (void)lsDictionaryFromJsonUrl:(NSURL *)url handler:(void (^)(NSDictionary * _Nullable jsonDictionary, NSError * _Nullable error))handler;

/**
 Returns json dictionary from json string;

 @param jsonString Json string.
 @return Json dictionary.
 */
+ (nullable NSDictionary *)lsDictionaryFromJsonString:(NSString *)jsonString;

/**
 Returns json string.

 @return Json string.
 */
- (nullable NSString *)lsJsonString;

/**
 Returns dictionary with keys and values swapped.
 
 @return Dictionary with keys and values swapped.
 */
- (NSDictionary *)lsDictionaryWithSwappedKeysAndValues;

/**
 Returns data.

 @return Data.
 */
- (NSData *)lsData;

/**
 Return dictionary from data.

 @param data Data.
 @return Dictionary from data.
 */
+ (nullable NSDictionary *)lsDictionaryFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
