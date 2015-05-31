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
    GeoPatternOctogons,
    GeoPatternOverlappingcircles,
    GeoPatternPlussigns,
    GeoPatternXes,
    GeoPatternSinewaves,
    GeoPatternHexagons,
    GeoPatternOverlappingrings,
    GeoPatternPlaid,
    GeoPatternTriangles,
    GeoPatternSquares,
    GeoPatternConcentriccircles,
    GeoPatternDiamonds,
    GeoPatternTessellation,
    GeoPatternNestedsquares,
    GeoPatternMosaicsquares,
    GeoPatternChevrons
};

#pragma mark - Options

extern NSString *const kGeoPatternString;
extern NSString *const kGeoPatternColor;
extern NSString *const kGeoPatternBaseColor;
extern NSString *const kGeoPatternType;
extern NSString *const kGeoPatternHash;

extern NSInteger const kGeoPatternString2;

@end
