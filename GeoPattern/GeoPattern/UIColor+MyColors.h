//
//  UIColor+MyColors.h
//  PlayWithColors
//
//  Created by Matthew Faluotico on 4/11/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MyColors)

#pragma mark - MyColors

+ (void) useMyColors;
+ (void) setColor: (UIColor*) color forKey: (NSString *) key;
+ (UIColor *) colorForKey: (NSString *) key;

#pragma mark - generting colors

+ (UIColor *) colorFromString: (NSString *) string;
- (UIColor *) shadeDarker;
- (UIColor *) shadeLighter;

#pragma mark - etc

- (BOOL) isDarkColor;

#pragma mark - keys

extern NSString * const kMCPrimary;
extern NSString * const kMCSecondary;
extern NSString * const kMCTertiary;

extern NSString * const kMCFontDark;
extern NSString * const kMCFontLight;

@end
