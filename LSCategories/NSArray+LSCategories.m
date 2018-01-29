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

#import "NSArray+LSCategories.h"

@implementation NSArray (LSCategories)

- (NSArray *)lsReveresedArray
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)lsShuffledArray
{
    NSMutableArray *temp = [self mutableCopy];
    for (NSUInteger i = temp.count; i > 1; i--)
    {
        [temp exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((uint32_t)i)];
    }
    return [temp copy];
}

- (id)lsRandomObject
{
    return self.count == 0 ? nil : self[arc4random_uniform((uint32_t)self.count)];
}

- (NSArray *)lsRandomObjectsWithSize:(NSUInteger)size
{
    if (self.count < size)
        return nil;
    
    NSArray *shuffled = [self lsShuffledArray];
    return [shuffled subarrayWithRange:NSMakeRange(0, size)];
}

@end
