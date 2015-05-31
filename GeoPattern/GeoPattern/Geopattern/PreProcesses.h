//
//  SizeCalculator.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/18/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PreProcesses : NSObject

// Calculating Sizes
+ (CGSize) sizeForOctogons: (NSDictionary*) options;
+ (CGSize) sizeForOverlappingcircles: (NSDictionary*) options;
+ (CGSize) sizeForPlussigns: (NSDictionary*) options;
+ (CGSize) sizeForXes: (NSDictionary*) options;
+ (CGSize) sizeForSinewaves: (NSDictionary*) options;
+ (CGSize) sizeForHexagons: (NSDictionary*) options;
+ (CGSize) sizeForOverlappingrings: (NSDictionary*) options;
+ (CGSize) sizeForPlaid: (NSDictionary*) options;
+ (CGSize) sizeForTriangles: (NSDictionary*) options;
+ (CGSize) sizeForSquares: (NSDictionary*) options;
+ (CGSize) sizeForConcentriccircles: (NSDictionary*) options;
+ (CGSize) sizeForDiamonds: (NSDictionary*) options;
+ (CGSize) sizeForTessellation: (NSDictionary*) options;
+ (CGSize) sizeForNestedsquares: (NSDictionary*) options;
+ (CGSize) sizeForMosaicsquares: (NSDictionary*) options;
+ (CGSize) sizeForChevrons: (NSDictionary*) options;

// Use imaging mode of CGPattern Mode

+ (BOOL) shouldUseImagingMode;

@end
