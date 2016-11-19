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

#import "NSDictionary+LSCategories.h"
#import "NSData+LSCategories.h"

@implementation NSDictionary (LSCategories)

+ (void)lsDictionaryFromJsonUrl:(NSURL *)url handler:(void (^)(NSDictionary *jsonDictionary, NSError *error))handler
{
    if (!handler || !url)
    {
        if (handler)
            handler(nil, nil);
        return;
    }
    [NSData lsDataFromUrl:url handler:^(NSData *data, NSError *error) {
        NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:&error] : nil;
        if ([json isKindOfClass:[NSArray class]])
            json = @{ @"root" : json };
        handler(json, error);
    }];
}

+ (NSDictionary *)lsDictionaryFromJsonString:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
    return json;
}

- (NSString *)lsJsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *string = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
    return string;
}

@end
