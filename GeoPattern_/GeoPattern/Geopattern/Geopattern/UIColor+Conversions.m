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

// c
- (UIColor *)toUIColor {
    return [UIColor fromHSL:self];
}

// c
- (NSString *)toHex {
    UIColor *c = [self toUIColor];
    return [c toHex];
}

@end

#pragma mark - Category

@implementation UIColor (Conversions)

+ (UIColor *)fromHSL:(HSLColor *)hsl {
    
    struct RGBColor rgb;
    
    CGFloat hue = hsl.hue;
    CGFloat sat = hsl.saturation;
    CGFloat lig = hsl.lightness;
    
    if (sat == 0) {
        rgb.red = rgb.green = rgb.blue = lig;
    } else {
        double q = (lig < 0.5) ? (lig * (1 + sat)) : ((lig + sat) - (lig * sat));
        double p = (2 * lig - q);
        rgb.red = [UIColor hue2rgbComponent:p andQ:q andT:(hue + (1/3.0))];
        rgb.green = [UIColor hue2rgbComponent:p andQ:q andT:(hue)];
        rgb.blue = [UIColor hue2rgbComponent:p andQ:q andT:(hue - (1/3.0))];
    }
    
    return [UIColor colorWithRed:rgb.red green:rgb.green blue:rgb.blue alpha:1];
}

+ (UIColor *)fromHex:(NSString *)hex {
    NSString *colorString = [[hex stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
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
    struct RGBColor colors = [UIColor getComponentsFromColor:self];
    
    CGFloat max = MAX(colors.red, MAX(colors.green, colors.blue));
    CGFloat min = MIN(colors.red, MIN(colors.green, colors.blue));
    HSLColor *hsl = [HSLColor new];
    
    hsl.lightness = (max + min) / 2;
    
    if (max == min) {
        hsl.hue = hsl.saturation = 0;
    } else {
        CGFloat diff = max - min;
        hsl.saturation = (hsl.lightness > 0.5) ? (diff / (2 - max - min)) : (diff / (max + min));
        
        if (max == colors.red) {
            hsl.hue = ( (colors.green - colors.blue) / diff) + ((colors.green < colors.blue) ? 6 : 0);
        } else if (max == colors.green) {
            hsl.hue = (colors.blue - colors.red) / diff + 2;
        } else {
            hsl.hue = (colors.red - colors.green) / diff + 4;
        }
        
        hsl.hue /= 6;
    }
    
    return hsl;
    
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

+ (double) hue2rgbComponent: (double) p andQ: (double) q andT: (double) t {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6.0) return p + (q - p) * 6 * t;
    if (t < 1 / 2.0) return q;
    if (t < 2 / 3.0) return p + (q - p) * (2 / 3.0 - t) * 6;
    return p;
}

// Strcut for easier RGB management

struct RGBColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
};


@end