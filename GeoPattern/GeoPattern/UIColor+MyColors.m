//
//  UIColor+MyColors.m
//  PlayWithColors
//
//  Created by Matthew Faluotico on 4/11/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "UIColor+MyColors.h"

static NSMutableDictionary *colors;

@implementation UIColor (MyColors)

#pragma mark - My COlors, setting colors to keys

// Sets up the MyColor dicionary
+ (void) useMyColors {
    colors = [NSMutableDictionary new];
}

// Adds a color to the dictionary. Referene it with the key
+ (void) setColor: (UIColor*) color forKey: (NSString *) key {
    [colors setObject: color forKey: key];
}

// Gets the color from the dictionary
+ (UIColor * ) colorForKey: (NSString *) key {
    return [colors objectForKey:key];
}

#pragma mark - Generating colors

// generates a color from a string. A string will always generate the same color.
+ (UIColor *) colorFromString: (NSString *) string {
    
    NSUInteger hash = [string hash];
    NSUInteger salt = 15257;
    
    NSUInteger result = (hash* (salt % hash)) + (hash / salt) + (hash % salt);
    
    NSString *asString = [NSString stringWithFormat:@"%lu", result];
    
    NSInteger length = [asString length];
    NSInteger partial = length / 3;
    
    NSString *first, *second, *third;
    
    first = [asString substringToIndex:partial];
    second = [asString substringWithRange:NSMakeRange(partial, partial)];
    third = [asString substringWithRange:NSMakeRange(partial*2, partial - 1)];
    
    CGFloat red = ([first integerValue] % 255) / 255.0;
    CGFloat green = ([second integerValue] % 255) / 255.0;
    CGFloat blue = ([third integerValue] % 255) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (UIColor *) shadeDarker {return nil;}
- (UIColor *) shadeLighter {return nil;}

- (BOOL) isDarkColor { return YES;}


@end
