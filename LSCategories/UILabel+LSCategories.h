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

@interface UILabel (LSCategories)

/**
 Starts animated counting from start integer value to end integer value.

 @param startValue Start value.
 @param endValue End value.
 @param duration Animation duration.
 @param completionBlock Completion block to execute after counting is finished.
 */
- (void)lsAnimateCounterWithStartValue:(NSInteger)startValue endValue:(NSInteger)endValue duration:(NSTimeInterval)duration completionBlock:(void (^)(void))completionBlock;

/**
 Parses string with basic html tags such as strong, em, b, i etc. and updates the label with styled attributed string. 
 */
- (void)lsParseBasicHTMLTags;

@end
