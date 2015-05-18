//
//  ShapeDrawer.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/18/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShapeDrawer : NSObject

+ (void) drawRectangle: (CGRect) rect withFill: (UIColor *) fill withStroke: (UIColor *) stroke inContext: (CGContextRef) context;

@end
