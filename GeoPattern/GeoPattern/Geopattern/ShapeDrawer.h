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

#pragma mark - Rectangle

+ (void) drawRectangle: (CGRect) rect
              withFill: (UIColor *) fill
            withStroke: (UIColor *) stroke
               atWidth: (CGFloat) width
             inContext: (CGContextRef) context;

#pragma mark - Elipse

+ (void) drawCircleIn: (CGRect) rect
              withFill: (UIColor *) fill
            withStroke: (UIColor *) stroke
               atWidth: (CGFloat) width
             inContext: (CGContextRef) context;

+ (void) drawCircleWithCenter: (CGPoint) center
                   withRadius: (CGFloat) radius
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context;

#pragma mark - Diamond

+ (void) drawDiamondWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context;

#pragma mark - Chevron 

+ (void) drawChevronWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                     withFill: (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWidth
                     inConext: (CGContextRef) context;

#pragma mark - Generic Shape Drawing

+ (void) drawShapeWithPoints: (NSArray *) points
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context;


#pragma mark - Shapes that take Tranformation effects

+ (void) drawDiamondWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context
             transformEffects: (CGAffineTransform)tranforms;

+ (void) drawChevronWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                     withFill: (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWidth
                     inConext: (CGContextRef) context
             transformEffects: (CGAffineTransform)tranforms;

+ (void) drawShapeWithPoints: (NSArray *) points
                   withFill : (UIColor *) fill
                  withStroke: (UIColor *) stroke
                     atWidth: (CGFloat) strokeWith
                   inContext: (CGContextRef) context
             transformEffects: (CGAffineTransform)tranforms;

+ (void)drawRightTriangleWithLength:(CGFloat)length
                      withFill:(UIColor *)fill
                    withStroke:(UIColor *)stroke
                       atWidth:(CGFloat)strokeWidth
                      inConext:(CGContextRef)context
              transformEffects:(CGAffineTransform)tranforms;

@end
