//
//  Graphics.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Graphics : NSObject

+ (NSString *) generateHash: (NSString *) str;

#pragma mark - Color helpers

+ (UIColor *) fillColor: (NSInteger) value;

+ (CGFloat) opacity: (CGFloat) value;

+ (UIColor *) backgroundColorFromOptions: (NSDictionary *) options

#pragma mark - Defaults

+ (UIColor*) FILL_COLOR_DARK;
+ (UIColor*) FILL_COLOR_LIGHT;
+ (UIColor*) STROKE_COLOR;

+ (CGFloat) STROKE_OPACITY;
+ (CGFloat) OPACITY_MIN;
+ (CGFloat) OPACITY_MAX;


@end
