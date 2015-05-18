//
//  ShapeDrawer.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/18/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ShapeDrawer.h"

@implementation ShapeDrawer

+ (void) drawRectangle: (CGRect) rect withFill: (UIColor *) fill withStroke: (UIColor *) stroke atWidth: (CGFloat) width inContext: (CGContextRef) context {
    
    CGContextSetFillColorWithColor(context, fill.CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, stroke.CGColor);
    CGContextStrokeRectWithWidth(context, rect, width);
}

+ (void) drawCircleIn: (CGRect) rect
             withFill: (UIColor *) fill
           withStroke: (UIColor *) stroke
              atWidth: (CGFloat) width
            inContext: (CGContextRef) context {
    
    CGContextSetFillColorWithColor(context, fill.CGColor);
    CGContextSetStrokeColorWithColor(context, stroke.CGColor);
    CGContextFillEllipseInRect(context, rect);
    CGContextSetLineWidth(context, width);
    CGContextStrokeEllipseInRect(context, rect);
    
    
}

+ (void) drawCircleWithCenter: (CGPoint) center
                   withRadius: (CGFloat) radius
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) width
                    inContext: (CGContextRef) context {
    
    CGFloat startX, startY;
    startX = center.x - radius;
    startY = center.y - radius;
    CGRect rect = CGRectMake(startX, startY, radius * 2, radius * 2);
    [ShapeDrawer drawCircleIn:rect withFill:fill withStroke:stroke atWidth:width inContext:context];
    
}

@end
