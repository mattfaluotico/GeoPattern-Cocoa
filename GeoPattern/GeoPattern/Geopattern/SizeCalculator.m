//
//  SizeCalculator.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/18/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "SizeCalculator.h"
#import "GeoPatternConstants.h"
#import "Graphics.h"

@implementation SizeCalculator

+ (CGSize) sizeForOctogons: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForOverlappingcircles: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForPlussigns: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForXes: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForSinewaves: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForHexagons: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForOverlappingrings: (NSDictionary*) options {

    NSInteger hex = [Graphics intFromHex:[options objectForKey:kGeoPatternHash] atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat ringSize = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:60];
    
    return CGSizeMake(ringSize * 6, ringSize * 6);
}
+ (CGSize) sizeForPlaid: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForTriangles: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForSquares: (NSDictionary*) options {
    NSString *hex = [options objectForKey:kGeoPatternHash];
    NSInteger fromHex = [Graphics intFromHex:hex atIndex:0 withLength:1];
    double squareSize = [Graphics mapValue:fromHex
                          inRangeWithLower:0
                             andUpperBound:15
                  toNewRangeWithLowerBound:10
                             andUpperBound:60];
    
    return CGSizeMake(squareSize * 6, squareSize * 6);
}
+ (CGSize) sizeForConcentriccircles: (NSDictionary*) options {
    
    NSInteger hex = [Graphics intFromHex:[options objectForKey:kGeoPatternHash] atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat ringSize = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:60];
    CGFloat strokeWidth = ringSize / 5.0;
    
    return CGSizeMake((ringSize + strokeWidth) * 6, (ringSize + strokeWidth) * 6);
}
+ (CGSize) sizeForDiamonds: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForTessellation: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForNestedsquares: (NSDictionary*) options {
    
    NSInteger hashInt = [Graphics intFromHex:[options objectForKey:kGeoPatternHash] atIndex:0 withLength:1];
    double blockSize = [Graphics mapValue:hashInt inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:4 andUpperBound:12];
    CGFloat squareSize = blockSize * 7;
    
    double size = ((squareSize + blockSize) * 6) + (blockSize * 6);
    return CGSizeMake(size, size);
}
+ (CGSize) sizeForMosaicsquares: (NSDictionary*) options {
    return CGSizeMake(0,0);
}
+ (CGSize) sizeForChevrons: (NSDictionary*) options {
    return CGSizeMake(0,0);
}


@end
