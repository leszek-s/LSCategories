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

@interface NSData (LSCategories)

/**
 Returns CRC32 checksum from data.
 
 @return CRC32 checksum from data.
 */
- (uint32_t)lsCRC32;

/**
 Returns Adler32 checksum from data.
 
 @return Adler32 checksum from data.
 */
- (uint32_t)lsAdler32;

/**
 Returns MD2 hash from data.

 @return MD2 hash from data.
 */
- (NSString *)lsMD2;

/**
 Returns MD4 hash from data.
 
 @return MD4 hash from data.
 */
- (NSString *)lsMD4;

/**
 Returns MD5 hash from data.
 
 @return MD5 hash from data.
 */
- (NSString *)lsMD5;

/**
 Returns SHA1 hash from data.
 
 @return SHA1 hash from data.
 */
- (NSString *)lsSHA1;

/**
 Returns SHA224 hash from data.
 
 @return SHA224 hash from data.
 */
- (NSString *)lsSHA224;

/**
 Returns SHA256 hash from data.
 
 @return SHA256 hash from data.
 */
- (NSString *)lsSHA256;

/**
 Returns SHA384 hash from data.
 
 @return SHA384 hash from data.
 */
- (NSString *)lsSHA384;

/**
 Returns SHA512 hash from data.
 
 @return SHA512 hash from data.
 */
- (NSString *)lsSHA512;

/**
 Returns string with UTF8 encoding from data.
 
 @return String with UTF8 encoding from data.
 */
- (nullable NSString *)lsStringUTF8;

/**
 Returns hex string from data.

 @return Hex string from data.
 */
- (nullable NSString *)lsHexString;

/**
 Returns data from given hex string.

 @param hexString Hex string.
 @return Data from given hex string.
*/
+ (nullable NSData *)lsDataWithHexString:(NSString *)hexString;

/**
 Returns content of given subdirectory in given directory.

 @param directory Directory (NSCachesDirectory, NSDocumentDirectory, NSLibraryDirectory)
 @param subDirectory Subdirectory name.
 @return Array of NSStrings or nil.
 */
+ (nullable NSArray<NSString *> *)lsContentOfDirectory:(NSSearchPathDirectory)directory subDirectory:(nullable NSString *)subDirectory;

/**
 Deletes given subdirectory in given directory.

 @param directory Directory (NSCachesDirectory, NSDocumentDirectory, NSLibraryDirectory)
 @param subDirectory Subdirectory name.
 @return YES if deleted, NO otherwise.
 */
+ (BOOL)lsCleanDirectory:(NSSearchPathDirectory)directory subDirectory:(nullable NSString *)subDirectory;

/**
 Reads file with given name from given subdirectory in given directory.

 @param directory Directory (NSCachesDirectory, NSDocumentDirectory, NSLibraryDirectory)
 @param subDirectory Subdirectory name.
 @param fileName File name.
 @return File data or nil.
 */
+ (nullable NSData *)lsReadDataFromDirectory:(NSSearchPathDirectory)directory subDirectory:(nullable NSString *)subDirectory fileName:(NSString *)fileName;

/**
 Saves file with given name to given subdirectory in given directory.

 @param directory Directory (NSCachesDirectory, NSDocumentDirectory, NSLibraryDirectory)
 @param subDirectory Subdirectory name.
 @param fileName File name.
 @param useExcludeFromBackup YES additionally sets NSURLIsExcludedFromBackupKey after saving.
 @return YES if saved, NO otherwise.
 */
- (BOOL)lsSaveToDirectory:(NSSearchPathDirectory)directory subDirectory:(nullable NSString *)subDirectory fileName:(NSString *)fileName useExcludeFromBackup:(BOOL)useExcludeFromBackup;

/**
 Creates and returns data from given url asynchronously.

 @param url The URL from which to read data.
 @param handler Handler to execute after reading.
 */
+ (void)lsDataFromUrl:(NSURL *)url handler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))handler;

/**
 Returns data XORed with given key.

 @param key Key for XORing.
 @return Data XORed with given key.
 */
- (NSData *)lsDataXORedWithKey:(NSData *)key;

@end

NS_ASSUME_NONNULL_END
