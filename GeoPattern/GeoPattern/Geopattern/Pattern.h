//
//  Pattern.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Pattern : NSObject
@property UIColor *strokeColor;
@property UIColor *fillColorDark;
@property UIColor *fillColorLight;
@property CGFloat stokeOpacity;
@property CGFloat opacityDark;
@property CGFloat opacityLight;

- (id) initWithContext: (CGContextRef ) context WithOptions: (NSDictionary *) options;
- (void) temp;
- (void) generate;

+ (NSDictionary *) defaults;

typedef NS_ENUM(NSInteger, PATTERN) {
    OCTOGONS,
    OVERLAPPINGCIRCLES,
    PLUSSIGNS,
    XES,
    SINEWAVES,
    HEXAGONS,
    OVERLAPPINGRINGS,
    PLAID,
    TRIANGLES,
    SQUARES,
    CONCENTRICCIRCLES,
    DIAMONDS,
    TESSELLATION,
    NESTEDSQUARES,
    MOSAICSQUARES,
    CHEVRONS
};

@end
