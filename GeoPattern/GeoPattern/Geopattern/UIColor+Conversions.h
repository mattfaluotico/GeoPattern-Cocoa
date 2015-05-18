//
//  UIColor+Conversions.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/8/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - HSLColor

@interface HSLColor : NSObject
@property double hue;
@property double saturation;
@property double lightness;

// HSL to RGB
- (UIColor *) toUIColor;
// HSL to HEX
- (NSString *) toHex;

@end

@interface UIColor (Conversions)

// RGB to HEX
- (NSString *) toHex;
// RGB to HSL
- (HSLColor *) toHSL;
// HEX to RGB
+ (UIColor *) fromHex: (NSString *) hex;
// HSL to RGB
+ (UIColor *) fromHSL: (HSLColor *) hsl;

@end

