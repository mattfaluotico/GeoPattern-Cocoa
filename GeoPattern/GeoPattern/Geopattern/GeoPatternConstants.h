//
//  GeoPatternConstants.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/12/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoPatternConstants : NSObject

typedef NS_ENUM(NSInteger, PATTERN) {
    PatternOctogons,
    PatternOverlappingcircles,
    PatternPlussigns,
    PatternXes,
    PatternSinewaves,
    PatternHexagons,
    PatternOverlappingrings,
    PatternPlaid,
    PatternTriangles,
    PatternSquares,
    PatternConcentriccircles,
    PatternDiamonds,
    PatternTessellation,
    PatternNestedsquares,
    PatternMosaicsquares,
    PatternChevrons
};

#pragma mark - Options

extern NSString *const kGeoPatternString;
extern NSString *const kGeoPatternColor;
extern NSString *const kGeoPatternBaseColor;
extern NSString *const kGeoPatternType;
extern NSString *const kGeoPatternHash;

@end
