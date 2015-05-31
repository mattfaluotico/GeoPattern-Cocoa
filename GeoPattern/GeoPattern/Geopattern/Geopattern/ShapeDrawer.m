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

+ (void)drawOctogonWithSize:(CGFloat)size
                           withFill:(UIColor *)fill
                         withStroke:(UIColor *)stroke
                            atWidth:(CGFloat)strokeWidth
                           inConext:(CGContextRef)context
                   transformEffects:(CGAffineTransform)tranforms {
    
    CGFloat s = size;
    CGFloat c = s * 0.33;
    
    NSArray *points = @[
                        [NSValue valueWithCGPoint: CGPointMake(c, 0)],
                        [NSValue valueWithCGPoint: CGPointMake(s - c, 0)],
                        [NSValue valueWithCGPoint: CGPointMake(s, c)],
                        [NSValue valueWithCGPoint: CGPointMake(s, s - c)],
                        [NSValue valueWithCGPoint: CGPointMake(s - c, s)],
                        [NSValue valueWithCGPoint: CGPointMake(c, s)],
                        [NSValue valueWithCGPoint: CGPointMake(0, s - c)],
                        [NSValue valueWithCGPoint: CGPointMake(0, c)],
                        ];
    
    [ShapeDrawer drawShapeWithPoints:points withFill:fill withStroke:stroke atWidth:strokeWidth inContext:context transformEffects:tranforms];
    
}

+ (void)drawHexagonWithSize:(CGFloat)size
                   withFill:(UIColor *)fill
                 withStroke:(UIColor *)stroke
                    atWidth:(CGFloat)strokeWidth
                   inConext:(CGContextRef)context
           transformEffects:(CGAffineTransform)tranforms {
    
    CGFloat c = size;
    CGFloat a = c / 2;
    CGFloat b = sin(60 * M_PI/180) * c;
    
    NSArray *points = @[
                        [NSValue valueWithCGPoint: CGPointMake(0, b)],
                        [NSValue valueWithCGPoint: CGPointMake(a, 0)],
                        [NSValue valueWithCGPoint: CGPointMake(a + c, 0)],
                        [NSValue valueWithCGPoint: CGPointMake(2 * c, b)],
                        [NSValue valueWithCGPoint: CGPointMake(a + c, 2 * b)],
                        [NSValue valueWithCGPoint: CGPointMake(a, 2 * b)]
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

+ (void) drawWaveWithPeriod: (NSInteger) period
                  amplitude: (NSInteger) amplitude
                  waveWidth: (NSInteger) waveWidth
                    xOffset: (CGFloat) xOffset
                       fill: (UIColor *) fill
                     stroke: (UIColor *) stroke
                strokeWidth: (CGFloat) strokeWidth
                  inContext: (CGContextRef) context
             withTransforms: (CGAffineTransform) transforms {
    
    UIGraphicsPushContext(context);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // M0 39
    CGPoint start = CGPointMake(0, amplitude);
    [path moveToPoint:start];
    // C 52.5 0, 97.5 0, 150 39
    CGPoint controlPoint1 = CGPointMake(xOffset, 0);
    CGPoint controlPoint2 = CGPointMake((period / 2 - xOffset), 0);
    CGPoint toPoint = CGPointMake((period / 2), amplitude);
    
    [path addCurveToPoint:toPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    // S 247.5 78, 300 39
    controlPoint1.y = amplitude * 2;
    controlPoint1.x = toPoint.x + xOffset;
    toPoint = CGPointMake(period, amplitude);
    controlPoint2 = CGPointMake(period - xOffset, amplitude * 2);
    [path addCurveToPoint:toPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    // S 397.5 0, 450, 39
    controlPoint1.y = 0;
    controlPoint1.x = period + xOffset;
    controlPoint2 = CGPointMake((period * 1.5 - xOffset), 0);
    toPoint = CGPointMake((period * 1.5), amplitude);
    [path addCurveToPoint:toPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    if (strokeWidth > 0) {
        path.lineWidth = strokeWidth;
    }
    
    [stroke setStroke];
    [fill setFill];
    [path applyTransform:transforms];
    [path fill];
    [path stroke];
    
    UIGraphicsPopContext();
}

+ (void) drawPlusSignWithSize: (CGFloat) size
                       fill: (UIColor *) fill
                     stroke: (UIColor *) stroke
                strokeWidth: (CGFloat) strokeWidth
                  inContext: (CGContextRef) context
             withTransforms: (CGAffineTransform) transforms {
    
    UIGraphicsPushContext(context);
    [fill setFill];
    [stroke setStroke];
    
    CGRect rect1 = CGRectMake(size, 0, size, size * 3);
    CGRect rect2 = CGRectMake(0, size, size * 3, size);
    
    // drawing rectangle 1
    UIBezierPath *path  = [UIBezierPath bezierPathWithRect:rect1];
    
    CGPoint start = CGPointMake(rect2.origin.x, rect2.origin.y);
    CGPoint first = CGPointMake(rect2.origin.x + rect2.size.width, rect2.origin.y);
    CGPoint second = CGPointMake(rect2.origin.x + rect2.size.width, rect2.origin.y + rect2.size.height);
    CGPoint third = CGPointMake(rect2.origin.x, rect2.origin.y + rect2.size.height);
    
    [path closePath];
    [path moveToPoint:start];
    [path addLineToPoint:first];
    [path addLineToPoint:second];
    [path addLineToPoint:third];
    [path closePath];
    
    // drawign rectanlge 2
    
    [path closePath];
    
    
    if (strokeWidth > 0) {
        path.lineWidth = strokeWidth;
//        path2.lineWidth = strokeWidth;
    }
    
    [path applyTransform:transforms];
//    [path2 applyTransform:transforms];
    [path fill];
//    [path2 fill];
    
    UIGraphicsPopContext();
}

+ (void)drawTriangleWithSideLength:(CGFloat) sideLength
                            height:(CGFloat) height
                           withFill:(UIColor *)fill
                         withStroke:(UIColor *)stroke
                            atWidth:(CGFloat)strokeWidth
                           inConext:(CGContextRef)context
                   transformEffects:(CGAffineTransform)tranforms {
    
    
    CGFloat haldWidth = sideLength / 2;
    
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(haldWidth, 0)],
                        [NSValue valueWithCGPoint:CGPointMake(sideLength, height)],
                        [NSValue valueWithCGPoint:CGPointMake(0, height)]
                        ];
    
    [ShapeDrawer drawShapeWithPoints:points withFill:fill withStroke:stroke atWidth:strokeWidth inContext:context transformEffects:tranforms];
}

@end
