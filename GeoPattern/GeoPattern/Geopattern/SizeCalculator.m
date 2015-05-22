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

    NSInteger hex = [Graphics intFromHex:[options objectForKey:kGeoPatternHash] atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat diameter = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:25 andUpperBound:200];
    CGFloat radius = diameter / 2.0;
    
    return CGSizeMake(radius * 6, radius * 6);
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
    CGFloat height = 0;
    CGFloat width = 0;
    
    NSInteger counter = 0, val, space;
    NSString *hex = [options objectForKey:kGeoPatternHash];
    
    while (counter < 36) {
        space = [Graphics intFromHex:hex atIndex:counter withLength:1];
        height += (space + 5);
        val = [Graphics intFromHex:hex atIndex:counter + 1 withLength:1];
        NSInteger stripeHeight = val + 5;
        height += stripeHeight;
        counter +=2;
    }
    
    counter = 0;
    
    while (counter < 36) {
        space = [Graphics intFromHex:hex atIndex:counter withLength:1];
        width += (space + 5);
        val = [Graphics intFromHex:hex atIndex:counter + 1 withLength:1];
        NSInteger stripeWidth = val + 5;
        width += stripeWidth;
        counter +=2;
    }
    
    return CGSizeMake(width, height);
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
    NSString *hash = [options objectForKey:kGeoPatternHash];
    CGFloat width = [Graphics mapValue:[Graphics intFromHex:hash atIndex:0 withLength:1]
                      inRangeWithLower:0
                         andUpperBound:15
              toNewRangeWithLowerBound:10
                         andUpperBound:50];
    
    CGFloat height = [Graphics mapValue:[Graphics intFromHex:hash atIndex:1 withLength:1]
                       inRangeWithLower:0
                          andUpperBound:15
               toNewRangeWithLowerBound:10
                          andUpperBound:50];
    NSLog(@"%f", height);
    return CGSizeMake(width * 6, height * 3);
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

    NSInteger hexVal = [Graphics
                        intFromHex:[options objectForKey:kGeoPatternHash]
                        atIndex:0
                        withLength:1];
    
    CGFloat triangleSize = [Graphics mapValue:hexVal inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:15 andUpperBound:50];
    
    return CGSizeMake(triangleSize * 8, triangleSize * 8);
    
}
+ (CGSize) sizeForChevrons: (NSDictionary*) options {
    
    CGFloat width = [Graphics mapValue:[Graphics intFromHex:[options objectForKey:kGeoPatternHash] atIndex:0 withLength:1] inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:30 andUpperBound:80];
    CGFloat height = width;
    return CGSizeMake(width * 6, height * 6);
    
}


@end
