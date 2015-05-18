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
#import "GeoPatternConstants.h"

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

#pragma mark - Color Helpers

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

+ (UIColor *) backgroundColor: (NSDictionary *) options {
    
    UIColor *returnedColor = [options objectForKey:kGeoPatternColor];
    
    if (!returnedColor) {
        NSString *hash = [options objectForKey:kGeoPatternHash];
        NSInteger i = [Graphics intFromHex:hash atIndex:14 withLength:3];
        NSInteger hueOffset = [Graphics mapValue:i inRangeWithLower:14 andUpperBound:4085 toNewRangeWithLowerBound:0 andUpperBound:359];
        NSInteger satOffset = [Graphics intFromHex:hash atIndex:17 withLength:1];
        
        UIColor *basedOptionColor = [Graphics BASE_COLOR];
        
        if ([options objectForKey:kGeoPatternBaseColor]) {
            basedOptionColor = [options objectForKey:kGeoPatternBaseColor];
        }
        
        HSLColor *base = [basedOptionColor toHSL];

        base.hue = ((NSInteger)((base.hue * 360 - hueOffset) + 360) % 360) / 360;
        if (satOffset % 2 == 0) {;
            base.saturation = MIN(1, ((base.saturation * 100 + satOffset) / 100) );
        } else {
            base.saturation = MIN(0, ((base.saturation * 100 + satOffset) / 100) );
        }
        
        returnedColor = [base toUIColor];
    }
    
    return returnedColor;
}

#pragma mark - Process Helpers

// Map value in the range lower and upper, to the new range (newUpper, newLower)
+ (CGFloat) mapValue: (CGFloat) value
        inRangeWithLower: (NSInteger) lower 
       andUpperBound: (NSInteger) upper
toNewRangeWithLowerBound: (double) newLower
       andUpperBound: (double) newUpper {
    
    CGFloat oldRange = upper - lower;
    CGFloat newRange = newUpper - newLower;
    
    CGFloat val = (((value - lower) * newRange) / oldRange) + newLower;
    return val;
}

// Extracts a part of a hex string and returns an NSInteger
+ (NSInteger) intFromHex: (NSString *) hash
                 atIndex: (NSInteger) index
              withLength: (NSInteger) length {
    
    unsigned result = 0;
    
    NSUInteger actualLength = hash.length;
    
    if (actualLength + 1 > length) {
        length = 1;
    }
    
    NSString * string = [hash substringWithRange:NSMakeRange(index, length)];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];
    
    return (NSInteger)result;
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
+ (UIColor *) BASE_COLOR {
    return [UIColor colorWithRed:0.459 green:0.118 blue:0.118 alpha:1];
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
