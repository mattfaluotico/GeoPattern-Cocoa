//
//  Graphics.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "Graphics.h"
#import "UIColor+Conversions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Graphics

+ (NSString *)generateHash: (NSString *) str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    NSString *s = [NSString  stringWithFormat:
                   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   result[0], result[1], result[2], result[3], result[4],
                   result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11], result[12],
                   result[13], result[14], result[15],
                   result[16], result[17], result[18], result[19]
                   ];
    
    return s;
}

#pragma mark - Helpers

+ (UIColor *) fillColor: (NSInteger) value {
    return (value % 2 == 0) ? [Graphics FILL_COLOR_LIGHT] : [Graphics FILL_COLOR_DARK];
}

+ (CGFloat) opacity: (CGFloat) value {
    return [Graphics mapValue:value
                 inRangeWithLower:0
                andUpperBound:15
     toNewRangeWithLowerBound:[Graphics OPACITY_MIN]
                andUpperBound:[Graphics OPACITY_MAX]];
}

+ (UIColor *) backgroundColorFromOptions: (NSDictionary *) options {
    
    UIColor *returnedColor = nil;
    
    if ([options objectForKey:@"color"]) {
        returnedColor = [options objectForKey:@"color"];
    } else {
        
        
        
    }
    
    return returnedColor;
}

#pragma mark - Helpers Arb.

+ (CGFloat) mapValue: (CGFloat) value
        inRangeWithLower: (NSInteger) lower 
       andUpperBound: (NSInteger) upper
toNewRangeWithLowerBound: (NSInteger) newLower
       andUpperBound: (NSInteger) newUpper {
    
    CGFloat oldRange = upper - lower;
    CGFloat newRange = newUpper - newLower;
    
    return (value - lower) * newRange / oldRange * newLower;
}

#pragma mark - Defaults

+ (UIColor*) FILL_COLOR_DARK {
    return [UIColor colorWithRed:0.133 green:0.133 blue:0.133 alpha:1]; /*#222222*/
}
+ (UIColor*) FILL_COLOR_LIGHT {
    return [UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1]; /*#dddddd*/
}
+ (UIColor*) STROKE_COLOR {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; /*#000000*/
}

+ (CGFloat) STROKE_OPACITY {
    return 0.02;
}
+ (CGFloat) OPACITY_MIN {
    return 0.02;
}
+ (CGFloat) OPACITY_MAX {
    return 0.15;
}


                               
@end
