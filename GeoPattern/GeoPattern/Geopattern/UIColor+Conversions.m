//
//  UIColor+Conversions.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/8/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "UIColor+Conversions.h"

#pragma mark - HSLColor

@implementation HSLColor

- (UIColor *)toUIColor {
    return [UIColor fromHSL:self];
}

- (NSString *)toHex {

}

@end

#pragma mark - Category

@implementation UIColor (Conversions)

+ (UIColor *)fromHSL:(HSLColor *)hsl {
    
}

+ (UIColor *)fromHex:(NSString *)hex {
    NSString *colorString = [[hex stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    NSLog(@"colorString :%@",colorString);
    CGFloat alpha, red, blue, green;
    
    // #RGB
    alpha = 1.0f;
    red   = [UIColor colorComponentFrom: colorString start: 0 length: 2];
    green = [UIColor colorComponentFrom: colorString start: 2 length: 2];
    blue  = [UIColor colorComponentFrom: colorString start: 4 length: 2];
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (NSString *)toHex {

    struct RGBColor colors = [UIColor getComponentsFromColor:self];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(colors.red * 255),
            lroundf(colors.green * 255),
            lroundf(colors.blue * 255)];
}

- (HSLColor *)toHSL {
    
}

#pragma mark - Extracting components

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (struct RGBColor) getComponentsFromColor: (UIColor *) color {
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    struct RGBColor colors;
    colors.red = components[0];
    colors.green = components[1];
    colors.blue = components[2];
    
    return colors;
}

// Strcut for easier RGB management

struct RGBColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
};


@end