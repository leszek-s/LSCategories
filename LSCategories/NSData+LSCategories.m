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

#import "NSData+LSCategories.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (LSCategories)

- (uint32_t)lsCRC32
{
    uint32_t crc, table[256];
    for (int i = 0; i <= 255; i++)
    {
        crc = i;
        for (int j = 0; j < 8; j++)
        {
            crc = (crc >> 1) ^ (-(crc & 1) & 0xEDB88320);
        }
        table[i] = crc;
    }
    
    crc = 0xFFFFFFFF;
    u_char *byte = (u_char *)self.bytes;
    NSUInteger length = self.length;
    for (int i = 0; i < length; i++)
    {
        crc = (crc >> 8) ^ table[(crc & 0xFF) ^ *byte++];
    }
    return ~crc;
}

- (uint32_t)lsAdler32
{
    uint32_t a = 1, b = 0;
    u_char *byte = (u_char *)self.bytes;
    NSUInteger length = self.length;
    
    for (int i = 0; i < length; i++)
    {
        a = (a + *byte++) % 65521;
        b = (b + a) % 65521;
    }
    return (b << 16) | a;
}

- (NSString *)lsMD2
{
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_MD2_DIGEST_LENGTH];
}

- (NSString *)lsMD4
{
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_MD4_DIGEST_LENGTH];
}

- (NSString *)lsMD5
{
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)lsSHA1
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)lsSHA224
{
    unsigned char digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)lsSHA256
{
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)lsSHA384
{
    unsigned char digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)lsSHA512
{
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, digest);
    return [self lsStringFromDigest:digest length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)lsStringUTF8
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSString *)lsStringFromDigest:(unsigned char[])digest length:(NSInteger)length
{
    NSMutableString *output = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return [output copy];
}

- (NSString *)lsHexString
{
    if (self.length == 0)
        return nil;
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithLength:self.length * 2];
    
    char *table = "0123456789ABCDEF";
    unsigned char *hexBytes = (unsigned char *)hexData.mutableBytes;
    unsigned char *bytes = (unsigned char *)self.bytes;
    unsigned char byte = 0;
    
    NSUInteger length = self.length;
    
    for (int i = 0; i < length; i++)
    {
        byte = *bytes;
        *hexBytes = table[(byte & 0xF0) >> 4];
        hexBytes++;
        *hexBytes = table[(byte & 0x0F)];
        hexBytes++;
        bytes++;
    }
    return [[NSString alloc] initWithData:hexData encoding:NSUTF8StringEncoding];
}

+ (NSData *)lsDataWithHexString:(NSString *)hexString
{
    NSData *hexData = [hexString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (hexData.length == 0 || hexData.length % 2 == 1)
        return nil;
    
    NSMutableData *data = [[NSMutableData alloc] initWithLength:hexData.length / 2];
    unsigned char *hexBytes = (unsigned char *)hexData.bytes;
    unsigned char *bytes = (unsigned char *)data.mutableBytes;
    unsigned char byte1 = 0;
    unsigned char byte2 = 0;
    
    NSUInteger length = data.length;
    
    for (int i = 0; i < length; i++)
    {
        byte1 = *hexBytes;
        hexBytes++;
        byte2 = *hexBytes;
        hexBytes++;
        
        if (byte1 >= '0' && byte1 <= '9') byte1 = byte1 - '0';
        else if (byte1 >= 'A' && byte1 <= 'F') byte1 = byte1 - 'A' + 10;
        else if (byte1 >= 'a' && byte1 <= 'f') byte1 = byte1 - 'a' + 10;
        else return nil;
        
        if (byte2 >= '0' && byte2 <= '9') byte2 = byte2 - '0';
        else if (byte2 >= 'A' && byte2 <= 'F') byte2 = byte2 - 'A' + 10;
        else if (byte2 >= 'a' && byte2 <= 'f') byte2 = byte2 - 'a' + 10;
        else return nil;
        
        *bytes = (byte1 << 4) + byte2;
        bytes++;
    }
    
    return [data copy];
}

+ (NSArray *)lsContentOfDirectory:(NSSearchPathDirectory)directory subDirectory:(NSString *)subDirectory
{
    NSString *systemDirectory = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalDirectory = systemDirectory;
    if (subDirectory.length > 0) {
        finalDirectory = [NSString stringWithFormat:@"%@/%@", systemDirectory, subDirectory];
    }
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:finalDirectory error:NULL];
    return directoryContent;
}

+ (BOOL)lsCleanDirectory:(NSSearchPathDirectory)directory subDirectory:(NSString *)subDirectory
{
    NSString *systemDirectory = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalDirectory = systemDirectory;
    if (subDirectory.length > 0) {
        finalDirectory = [NSString stringWithFormat:@"%@/%@", systemDirectory, subDirectory];
    }
    return [[NSFileManager defaultManager] removeItemAtPath:finalDirectory error:NULL];
}

+ (NSData *)lsReadDataFromDirectory:(NSSearchPathDirectory)directory subDirectory:(NSString *)subDirectory fileName:(NSString *)fileName
{
    if (fileName.length == 0)
        return nil;
    NSString *systemDirectory = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalDirectory = systemDirectory;
    if (subDirectory.length > 0) {
        finalDirectory = [NSString stringWithFormat:@"%@/%@", systemDirectory, subDirectory];
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", finalDirectory, fileName];
    return [NSData dataWithContentsOfFile:filePath];
}

- (BOOL)lsSaveToDirectory:(NSSearchPathDirectory)directory subDirectory:(NSString *)subDirectory fileName:(NSString *)fileName useExcludeFromBackup:(BOOL)useExcludeFromBackup
{
    if (fileName.length == 0)
        return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *systemDirectory = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalDirectory = systemDirectory;
    if (subDirectory.length > 0) {
        finalDirectory = [NSString stringWithFormat:@"%@/%@", systemDirectory, subDirectory];
    }
    [fileManager createDirectoryAtPath:finalDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", finalDirectory, fileName];
    BOOL result = [self writeToFile:filePath atomically:YES];
    if (result && useExcludeFromBackup)
        [[NSURL fileURLWithPath:filePath] setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:nil];
    return result;
}

+ (void)lsDataFromUrl:(NSURL *)url handler:(void (^)(NSData *data, NSError *error))handler
{
    if (!handler || !url)
    {
        if (handler)
            handler(nil, nil);
        return;
    }
    
    static dispatch_semaphore_t semaphore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(4);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        dispatch_semaphore_signal(semaphore);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler(data, error);
        });
    });
}

- (NSData *)lsDataXORedWithKey:(NSData *)key
{
    if (key.length == 0)
        return self;
    
    NSMutableData *result = [self mutableCopy];
    
    unsigned char *bytes = (unsigned char *)result.mutableBytes;
    unsigned char *keyStart = (unsigned char *)key.bytes;
    unsigned char *keyEnd = keyStart + key.length;
    unsigned char *keyBytes = keyStart;
    NSUInteger length = result.length;
    
    for (int i = 0; i < length; i++)
    {
        *bytes = *bytes ^ *keyBytes;
        bytes++;
        keyBytes++;
        if (keyBytes == keyEnd)
        {
            keyBytes = keyStart;
        }
    }
    return [result copy];
}

@end
