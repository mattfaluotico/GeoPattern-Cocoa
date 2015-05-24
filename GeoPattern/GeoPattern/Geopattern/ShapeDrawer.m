//
//  ShapeDrawer.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/18/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ShapeDrawer.h"

@implementation ShapeDrawer

+ (void) drawRectangle: (CGRect) rect
              withFill: (UIColor *) fill
            withStroke: (UIColor *) stroke
               atWidth: (CGFloat) width
             inContext: (CGContextRef) context {
    
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
    [ShapeDrawer drawCircleIn:rect
                     withFill:fill
                   withStroke:stroke
                      atWidth:width
                    inContext:context];
    
}

+ (void) drawDiamondWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context {
    
    NSArray *points = @[ [NSValue valueWithCGPoint:(CGPointMake(width/2.0, 0))],
                         [NSValue valueWithCGPoint:(CGPointMake(width, height/2.0))],
                         [NSValue valueWithCGPoint:(CGPointMake(width/2.0, height))],
                         [NSValue valueWithCGPoint:(CGPointMake(0, height/2.0))]
                        ];
    
    [ShapeDrawer drawShapeWithPoints:points
                            withFill:fill
                          withStroke:stroke
                             atWidth:width
                           inContext:context];
    
}

+ (void)drawChevronWithWidth:(CGFloat)width
                  withHeight:(CGFloat)height
                    withFill:(UIColor *)fill
                  withStroke:(UIColor *)stroke 
                     atWidth:(CGFloat)strokeWidth
                    inConext:(CGContextRef)context{
    
    [ShapeDrawer drawChevronWithWidth:width withHeight:height withFill:fill withStroke:stroke atWidth:strokeWidth inConext:context transformEffects:CGAffineTransformIdentity];
}


+ (void) drawShapeWithPoints: (NSArray *) points
                   withFill : (UIColor *) fill
                  withStroke: (UIColor *) stroke
                     atWidth: (CGFloat) strokeWith
                   inContext: (CGContextRef) context {
    
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    CGPoint starPoint = [[points objectAtIndex:0] CGPointValue];
    [shapePath moveToPoint:starPoint];
    
    for (NSValue *point_ in points) {
        CGPoint point = [point_ CGPointValue];
        [shapePath addLineToPoint:point];
    }
    
    [shapePath closePath];
    
    if (strokeWith > 0) {
        shapePath.lineWidth = strokeWith;
    }
    [stroke setStroke];
    [fill setFill];
    [shapePath fill];
    [shapePath stroke];
    
}

// --------------------------


+ (void) drawDiamondWithWidth: (CGFloat) width
                   withHeight: (CGFloat) height
                    withFill : (UIColor *) fill
                   withStroke: (UIColor *) stroke
                      atWidth: (CGFloat) strokeWith
                    inContext: (CGContextRef) context
             transformEffects: (CGAffineTransform)tranforms {

    
    NSArray *points = @[ [NSValue valueWithCGPoint:(CGPointMake(width/2.0, 0))],
                         [NSValue valueWithCGPoint:(CGPointMake(width, height/2.0))],
                         [NSValue valueWithCGPoint:(CGPointMake(width/2.0, height))],
                         [NSValue valueWithCGPoint:(CGPointMake(0, height/2.0))]
                         ];
    
    [ShapeDrawer drawShapeWithPoints:points
                            withFill:fill
                          withStroke:stroke
                             atWidth:strokeWith
                           inContext:context
                     transformEffects:tranforms];
    
}

+ (void) drawShapeWithPoints: (NSArray *) points
                   withFill : (UIColor *) fill
                  withStroke: (UIColor *) stroke
                     atWidth: (CGFloat) strokeWith
                   inContext: (CGContextRef) context
             transformEffects: (CGAffineTransform)tranforms {
    
    UIGraphicsPushContext(context);
    
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    CGPoint starPoint = [[points objectAtIndex:0] CGPointValue];
    [shapePath moveToPoint:starPoint];
    
    for (NSValue *point_ in points) {
        CGPoint point = [point_ CGPointValue];
        [shapePath addLineToPoint:point];
    }
    
    [shapePath closePath];
        
    if (strokeWith > 0) {
        shapePath.lineWidth = strokeWith;
    }
    
    [stroke setStroke];
    [fill setFill];
    [shapePath applyTransform:tranforms];
    [shapePath fill];
    [shapePath stroke];
    
    UIGraphicsPopContext();
    
}

+ (void)drawChevronWithWidth:(CGFloat)width
                  withHeight:(CGFloat)height
                    withFill:(UIColor *)fill
                  withStroke:(UIColor *)stroke
                     atWidth:(CGFloat)strokeWidth
                    inConext:(CGContextRef)context
            transformEffects:(CGAffineTransform)tranforms {
    
    CGFloat e = height * 0.66;
    
    NSArray *pointsFirst = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                             [NSValue valueWithCGPoint:CGPointMake(width / 2.0, height - e)],
                             [NSValue valueWithCGPoint:CGPointMake(width / 2.0, height)],
                             [NSValue valueWithCGPoint:CGPointMake(0, e)]
                             ];
    
    NSArray *pointsSecon = @[[NSValue valueWithCGPoint:CGPointMake(width / 2.0, height - e)],
                             [NSValue valueWithCGPoint:CGPointMake(width, 0)],
                             [NSValue valueWithCGPoint:CGPointMake(width, e)],
                             [NSValue valueWithCGPoint:CGPointMake(width / 2.0, height)]
                             ];
    UIGraphicsPushContext(context);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[[pointsFirst objectAtIndex:0] CGPointValue]];
    
    for (NSValue *point_ in pointsFirst) {
        CGPoint point = [point_ CGPointValue];
        [path addLineToPoint:point];
    }
    
    [path closePath];
    
    [path moveToPoint:[[pointsSecon objectAtIndex:0] CGPointValue]];
    
    for (NSValue *point_ in pointsSecon) {
        CGPoint point = [point_ CGPointValue];
        [path addLineToPoint:point];
    }
    
    [path closePath];
    if (strokeWidth > 0) {
        path.lineWidth = strokeWidth;
    }
    
    [stroke setStroke];
    [fill setFill];
    [path applyTransform:tranforms];
    [path fill];
    [path stroke];
    
    UIGraphicsPopContext();
    
}


+ (void)drawRightTriangleWithLength:(CGFloat)length
                    withFill:(UIColor *)fill
                  withStroke:(UIColor *)stroke
                     atWidth:(CGFloat)strokeWidth
                    inConext:(CGContextRef)context
            transformEffects:(CGAffineTransform)tranforms {
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                             [NSValue valueWithCGPoint:CGPointMake(length, length)],
                             [NSValue valueWithCGPoint:CGPointMake(0, length)]
                             ];
    
    [ShapeDrawer drawShapeWithPoints:points withFill:fill withStroke:stroke atWidth:strokeWidth inContext:context transformEffects:tranforms];
    
}

+ (void)drawRotatedTriangleWithWidth: (CGFloat) width
                      withSideLength: (CGFloat) sideLength
                           withFill:(UIColor *)fill
                         withStroke:(UIColor *)stroke
                            atWidth:(CGFloat)strokeWidth
                           inConext:(CGContextRef)context
                   transformEffects:(CGAffineTransform)tranforms {
    
    CGFloat height = sideLength / 2;
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                        [NSValue valueWithCGPoint:CGPointMake(width, height)],
                        [NSValue valueWithCGPoint:CGPointMake(0, sideLength)]
                        ];
    
    [ShapeDrawer drawShapeWithPoints:points withFill:fill withStroke:stroke atWidth:strokeWidth inContext:context transformEffects:tranforms];
    
}

+ (void) drawRectangle: (CGRect) rect
              withFill: (UIColor *) fill
            withStroke: (UIColor *) stroke
               atWidth: (CGFloat) width
             inContext: (CGContextRef) context
      transformEffects:(CGAffineTransform)tranforms {
    
    NSArray *points = @[ [NSValue valueWithCGPoint:rect.origin],
                         [NSValue valueWithCGPoint:CGPointMake(rect.size.width, 0)],
                         [NSValue valueWithCGPoint:CGPointMake(rect.size.width, rect.size.height)],
                         [NSValue valueWithCGPoint:CGPointMake(0, rect.size.height)]
                         ];
    
    [self drawShapeWithPoints:points withFill:fill withStroke:stroke atWidth:width inContext:context transformEffects:tranforms];
}

@end
