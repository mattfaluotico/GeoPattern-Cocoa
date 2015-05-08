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
@property CGFloat H;
@property CGFloat S;
@property CGFloat L;

- (UIColor *) toUIColor;
- (NSString *) toHex;

@end

@interface UIColor (Conversions)

- (NSString *) toHex;
- (HSLColor *) toHSL;
+ (UIColor *) fromHex: (NSString *) hex;
+ (UIColor *) fromHSL: (HSLColor *) hsl;

@end

