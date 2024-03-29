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

#import "UITabBarController+LSCategories.h"
#import "UIImage+LSCategories.h"
#import "UIView+LSCategories.h"

@implementation UITabBarController (LSCategories)

- (void)lsSetTabBarColor:(UIColor *)barColor itemColor:(UIColor *)itemColor selectedItemColor:(UIColor *)selectedItemColor borderColor:(UIColor *)borderColor
{
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = barColor;
    self.tabBar.tintColor = selectedItemColor;
    if (@available(iOS 10.0, tvOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = itemColor;
    }
    for (UIViewController *vc in self.viewControllers)
    {
        [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : itemColor } forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : selectedItemColor } forState:UIControlStateSelected];
    }
    
    if (borderColor)
    {
        self.tabBar.clipsToBounds = YES;
        [self.tabBar lsAddBorderOnEdge:UIRectEdgeTop color:borderColor width:1];
    }
    
    #if !TARGET_OS_TV
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        appearance.backgroundColor = barColor;
        appearance.stackedLayoutAppearance.normal.iconColor = itemColor;
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{ NSForegroundColorAttributeName : itemColor };
        appearance.stackedLayoutAppearance.selected.iconColor = selectedItemColor;
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{ NSForegroundColorAttributeName : selectedItemColor };
        self.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearance;
        }
    }
    #endif
}

- (void)lsSetTabBarButtonWithIndex:(NSUInteger)index title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UIViewController *vc = index >= self.viewControllers.count ? nil : self.viewControllers[index];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
}

@end
