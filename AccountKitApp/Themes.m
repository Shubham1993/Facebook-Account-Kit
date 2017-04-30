//
//  Themes.m
//  AccountKitApp
//
//  Created by Shubham on 29/04/17.
//  Copyright © 2017 perpule. All rights reserved.
//

@import AccountKit;
#import "Themes.h"

@implementation Themes

+ (AKFTheme *)bicycleTheme
{
    AKFTheme *theme = [AKFTheme outlineThemeWithPrimaryColor:[self _colorWithHex:0xffff5a5f]
                                            primaryTextColor:[UIColor whiteColor]
                                          secondaryTextColor:[UIColor whiteColor]
                                              statusBarStyle:UIStatusBarStyleLightContent];
    theme.backgroundImage = [UIImage imageNamed:@"bicycle"];
    theme.backgroundColor = [self _colorWithHex:0x66000000];
    theme.inputBackgroundColor = [self _colorWithHex:0x00000000];
    theme.inputBorderColor = [UIColor whiteColor];
    return theme;
}

+ (UIColor *)_colorWithHex:(NSUInteger)hex
{
    CGFloat alpha = ((CGFloat)((hex & 0xff000000) >> 24)) / 255.0;
    CGFloat red = ((CGFloat)((hex & 0x00ff0000) >> 16)) / 255.0;
    CGFloat green = ((CGFloat)((hex & 0x0000ff00) >> 8)) / 255.0;
    CGFloat blue = ((CGFloat)((hex & 0x000000ff) >> 0)) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
