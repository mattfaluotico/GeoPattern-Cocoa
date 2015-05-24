//
//  Pattern.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "Pattern.h"
#import "Graphics.h"
#import "GeoPatternConstants.h"
#import "ShapeDrawer.h"
#import "SizeCalculator.h"

@interface Pattern()
@property CGContextRef context;
@property NSString *hashValue;
@property NSDictionary *options;
@end

@implementation Pattern

- (id) initWithContext: (CGContextRef ) context WithOptions: (NSDictionary *) options; {
    self = [super init];
    self.context = context;
    self.options = options;
    self.hashValue = [options objectForKey:kGeoPatternHash];
    return self;
}

- (void) temp {
    
    CGColorRef color = ((UIColor*)[self.options objectForKey:kGeoPatternColor]).CGColor;
    
    UIColor * dotColor = [UIColor colorWithCGColor:color];
    
    CGContextSetFillColorWithColor(self.context, dotColor.CGColor);
    
    CGContextAddArc(self.context, 3, 3, 6, 0, radians(360), 0);
    CGContextFillPath(self.context);
    
    CGContextAddArc(self.context, 20, 20, 6, 0, radians(360), 0);
    CGContextFillPath(self.context);
}

- (void) generate {
    
    PATTERN pattern;
    
    if ([self.options objectForKey:kGeoPatternType]) {
        pattern = [[self.options objectForKey:kGeoPatternType] integerValue];
    } else {
        pattern = [Graphics intFromHex:self.hashValue atIndex:20 withLength:1];
    }
    
    switch (pattern) {
        case GeoPatternOctogons          : [self generateOctogons]; break;
        case GeoPatternOverlappingcircles: [self generateOverlappingcircles]; break;
        case GeoPatternPlussigns         : [self generatePlussigns]; break;
        case GeoPatternXes               : [self generateXes]; break;
        case GeoPatternSinewaves         : [self generateSinewaves]; break;
        case GeoPatternHexagons          : [self generateHexagons]; break;
        case GeoPatternOverlappingrings  : [self generateOverlappingrings]; break;
        case GeoPatternPlaid             : [self generatePlaid]; break;
        case GeoPatternTriangles         : [self generateTriangles]; break;
        case GeoPatternSquares           : [self generateSquares]; break;
        case GeoPatternConcentriccircles : [self generateConcentriccircles]; break;
        case GeoPatternDiamonds          : [self generateDiamonds]; break;
        case GeoPatternTessellation      : [self generateTessellation]; break;
        case GeoPatternNestedsquares     : [self generateNestedsquares]; break;
        case GeoPatternMosaicsquares     : [self generateMosaicsquares]; break;
        case GeoPatternChevrons          : [self generateChevrons]; break;
        default                          : [self generateSquares];
    }
};

+ (CGSize) calculateSizeFromOptions: (NSDictionary *) options {
    PATTERN pattern;
    
    if ([options objectForKey:kGeoPatternType]) {
        pattern = [[options objectForKey:kGeoPatternType] integerValue];
    } else {
        NSString *hash = [options objectForKeyedSubscript:kGeoPatternHash];
        pattern = [Graphics intFromHex:hash atIndex:20 withLength:1];
    }
    
    switch (pattern) {
        case GeoPatternOctogons          : return [SizeCalculator sizeForOctogons: options]; break;
        case GeoPatternOverlappingcircles: return [SizeCalculator sizeForOverlappingcircles: options]; break;
        case GeoPatternPlussigns         : return [SizeCalculator sizeForPlussigns: options]; break;
        case GeoPatternXes               : return [SizeCalculator sizeForXes: options]; break;
        case GeoPatternSinewaves         : return [SizeCalculator sizeForSinewaves: options]; break;
        case GeoPatternHexagons          : return [SizeCalculator sizeForHexagons: options]; break;
        case GeoPatternOverlappingrings  : return [SizeCalculator sizeForOverlappingrings: options]; break;
        case GeoPatternPlaid             : return [SizeCalculator sizeForPlaid: options]; break;
        case GeoPatternTriangles         : return [SizeCalculator sizeForTriangles: options]; break;
        case GeoPatternSquares           : return [SizeCalculator sizeForSquares: options]; break;
        case GeoPatternConcentriccircles : return [SizeCalculator sizeForConcentriccircles: options]; break;
        case GeoPatternDiamonds          : return [SizeCalculator sizeForDiamonds: options]; break;
        case GeoPatternTessellation      : return [SizeCalculator sizeForTessellation: options]; break;
        case GeoPatternNestedsquares     : return [SizeCalculator sizeForNestedsquares: options]; break;
        case GeoPatternMosaicsquares     : return [SizeCalculator sizeForMosaicsquares: options]; break;
        case GeoPatternChevrons          : return [SizeCalculator sizeForChevrons: options]; break;
        default                          : return [SizeCalculator sizeForSquares: options];
    }
}

+ (NSDictionary*) defaults {
    return @{
             kGeoPatternBaseColor : [UIColor redColor]
             };
}

// TEMP
static inline double radians (double degrees)  {
    return degrees * M_PI/180;
}

#pragma mark - Pattern Generation

- (void) generateOctogons {
    
}

- (void) generateOverlappingcircles {
    NSInteger hex = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat diameter = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:25 andUpperBound:200];
    CGFloat radius = diameter / 2.0;
    
    NSInteger counter = 0, x = 0, y =0;
    
    for (y=0; y<6; y++) {
        for (x = 0; x <6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
            
            CGPoint center = CGPointMake(x * radius, y *radius);
            [ShapeDrawer drawCircleWithCenter:center withRadius:radius withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
            
            if (x==0) {
                center = CGPointMake(6 * radius, y * radius);
                [ShapeDrawer drawCircleWithCenter:center withRadius:radius withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
            }
            
            if (y==0) {
                center = CGPointMake(x * radius, 6 * radius);
                [ShapeDrawer drawCircleWithCenter:center withRadius:radius withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
            }
            
            if (x==0 && y==0) {
                center = CGPointMake(6 * radius, 6 * radius);
                [ShapeDrawer drawCircleWithCenter:center withRadius:radius withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
            }
            
            counter++;
        }
    }
}

- (void) generatePlussigns {
    
}

- (void) generateXes {
    
}

- (void) generateSinewaves {
    
}

- (void) generateHexagons {
    
}

- (void) generateOverlappingrings {
    NSInteger hex = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat ringSize = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:60];
    CGFloat strokeWidth = ringSize / 4.0;
    
    NSInteger counter = 0, x,y;
    
    for (y = 0; y <6; y++) {
        for (x=0;x<6;x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *stroke = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
            UIColor *fill = [UIColor clearColor];
            
            CGPoint center = CGPointMake(x * ringSize, y * ringSize);
            CGFloat radius = ringSize - (strokeWidth / 2.0);
            
            [ShapeDrawer
             drawCircleWithCenter:center
             withRadius:radius
             withFill:fill
             withStroke:stroke
             atWidth:strokeWidth
             inContext:self.context];
            
            if (x==0) {
                center = CGPointMake(6 * ringSize, y * ringSize);
                radius = ringSize - (strokeWidth/2.0);
                [ShapeDrawer
                 drawCircleWithCenter:center
                 withRadius:radius
                 withFill:fill
                 withStroke:stroke
                 atWidth:strokeWidth
                 inContext:self.context];
            }
            
            if (y ==0) {
                center = CGPointMake(x * ringSize, 6 * ringSize);
                radius = ringSize - (strokeWidth/2.0);
                [ShapeDrawer
                 drawCircleWithCenter:center
                 withRadius:radius
                 withFill:fill
                 withStroke:stroke
                 atWidth:strokeWidth
                 inContext:self.context];
            }
            
            if (x==0 && y==0) {
                center = CGPointMake(6 * ringSize, 6 * ringSize);
                radius = ringSize - (strokeWidth/2.0);
                [ShapeDrawer
                 drawCircleWithCenter:center
                 withRadius:radius
                 withFill:fill
                 withStroke:stroke
                 atWidth:strokeWidth
                 inContext:self.context];
            }
            
            counter++;
        }
    }

}

- (void) generatePlaid {
    CGFloat height = 0;
    CGFloat width = 0;
    NSValue *rect_ = [self.options objectForKey:@"size"];
    CGSize size = [rect_ CGSizeValue];
    
    NSInteger counter = 0, val, space;
    NSString *hex = self.hashValue;
    
    
    while (counter < 36) {
        space = [Graphics intFromHex:hex atIndex:counter withLength:1];
        height += (space + 5);
        val = [Graphics intFromHex:hex atIndex:counter + 1 withLength:1];
        CGFloat opacity = [Graphics opacity:val];
        UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
        NSInteger stripeHeight = val + 5;

        CGRect rect = CGRectMake(0, height, size.width, stripeHeight);
        
        [ShapeDrawer drawRectangle:rect withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
        
        height += stripeHeight;
        counter +=2;
    }
    
    counter = 0;
    
    while (counter < 36) {
        space = [Graphics intFromHex:hex atIndex:counter withLength:1];
        width += (space + 5);
        val = [Graphics intFromHex:hex atIndex:counter + 1 withLength:1];
        CGFloat opacity = [Graphics opacity:val];
        UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
        NSInteger stripeWidth = val + 5;
        
        CGRect rect = CGRectMake(width, 0, stripeWidth, size.height);
        
        [ShapeDrawer drawRectangle:rect withFill:fill withStroke:[UIColor clearColor] atWidth:0 inContext:self.context];
        
        width += stripeWidth;
        counter +=2;
    }
    
}

- (void) generateTriangles {
    
}

- (void) generateSquares {
    
    NSInteger fromHex = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    double squareSize = [Graphics mapValue:fromHex
                          inRangeWithLower:0
                             andUpperBound:15
                  toNewRangeWithLowerBound:10
                             andUpperBound:60];
    
    NSInteger counter = 0;
    NSInteger y;
    NSInteger x;
    
    for (y = 0; y < 6; y++) {
        for (x = 0; x < 6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *fillColor = [Graphics fillColor:val];
            
            UIColor *fillOpacity = [fillColor colorWithAlphaComponent:opacity];
            UIColor *strokeColor = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
            CGRect rect = CGRectMake(x * squareSize, y * squareSize, squareSize, squareSize);
            
            [ShapeDrawer drawRectangle:rect withFill:fillOpacity withStroke:strokeColor atWidth: 1 inContext:self.context];
            
            counter++;
        }
    }
    
    
}

- (void) generateConcentriccircles {
    NSInteger hex = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    CGFloat scale = hex;
    CGFloat ringSize = [Graphics mapValue:scale inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:60];
    CGFloat strokeWidth = ringSize / 5.0;
    
    NSInteger counter = 0, x = 0, y =0;
    
    for (y = 0; y < 6; y++) {
        for (x = 0; x < 6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *stroke = [Graphics fillColor:val];
            UIColor *fill = [UIColor clearColor];
            
            stroke = [stroke colorWithAlphaComponent:opacity];
            
            CGFloat centerX = x * ringSize + x * strokeWidth + ((ringSize + strokeWidth) / 2.0);
            CGFloat centerY = y * ringSize + y * strokeWidth + ((ringSize + strokeWidth) / 2.0);
            CGPoint center = CGPointMake(centerX, centerY);
            
            [ShapeDrawer drawCircleWithCenter:center withRadius:ringSize / 2 withFill:fill withStroke:stroke atWidth:strokeWidth inContext:self.context];
            
            val = [Graphics intFromHex:self.hashValue atIndex:39-counter withLength:1];
            opacity = [Graphics opacity:val];
            fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
            stroke = [UIColor clearColor];
            
            
            [ShapeDrawer drawCircleWithCenter:center withRadius:ringSize / 4 withFill:fill withStroke:stroke atWidth:0 inContext:self.context];
            
            counter++;
        }
    }
    
}

- (void) generateDiamonds {
    CGFloat width = [Graphics mapValue:[Graphics intFromHex:self.hashValue atIndex:0 withLength:1] inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:50];
    CGFloat height = [Graphics mapValue:[Graphics intFromHex:self.hashValue atIndex:1 withLength:1] inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:10 andUpperBound:50];
    
    NSInteger counter = 0, x, y;
    
    for (y=0; y<6; y++) {
        for (x=0; x <6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
            UIColor *stroke = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
            
            double dx = (y % 2 == 0) ? 0 : (width / 2.0);
            
            CGFloat tx = x * width - (width / 2.0) + dx;
            CGFloat ty = height / 2.0 * y - height / 2;
            
            [ShapeDrawer drawDiamondWithWidth:width
                                   withHeight:height 
                                     withFill:fill
                                   withStroke:stroke
                                      atWidth:0
                                    inContext:self.context
                             transformEffects:CGAffineTransformMakeTranslation(tx, ty)];
            
            if (x == 0) {
                
                tx = 6 * width - (width / 2.0) + dx;
                ty = height / 2.0 * y - height / 2;
                [ShapeDrawer drawDiamondWithWidth:width
                                       withHeight:height
                                         withFill:fill
                                       withStroke:stroke
                                          atWidth:0
                                        inContext:self.context
                                 transformEffects:CGAffineTransformMakeTranslation(tx, ty)];

            }
            
            if (y == 0) {
                
                tx = x * width - (width / 2.0) + dx;
                ty = height / 2.0 * 6 - height / 2;
                [ShapeDrawer drawDiamondWithWidth:width
                                       withHeight:height
                                         withFill:fill
                                       withStroke:stroke
                                          atWidth:0
                                        inContext:self.context
                                 transformEffects:CGAffineTransformMakeTranslation(tx, ty)];
                
            }
            
            
            if (x == 0 && y == 0) {
                
                tx = 6 * width - (width / 2.0) + dx;
                ty = height / 2.0 * 6 - height / 2;
                [ShapeDrawer drawDiamondWithWidth:width
                                       withHeight:height
                                         withFill:fill
                                       withStroke:stroke
                                          atWidth:0
                                        inContext:self.context
                                 transformEffects:CGAffineTransformMakeTranslation(tx, ty)];
                
            }
            
            counter++;
        }
    }
}

- (void) generateTessellation {
 
    CGFloat sideLength = [Graphics mapValue:[Graphics intFromHex:self.hashValue atIndex:0 withLength:1]
                             inRangeWithLower:0
                                andUpperBound:15
                     toNewRangeWithLowerBound:5
                                andUpperBound:40];
    
    NSLog(@"side length: %f", sideLength);
    
    CGFloat sq = 1.7320508075688772;
    CGFloat hexHeight = sideLength * sq;
    CGFloat hexWidth = sideLength  * 2;
    CGFloat triangleHeight = sideLength / 2.0 * sq;
    CGFloat tileWidth = sideLength * 3 + triangleHeight * 2.0;
    CGFloat tileHeight = (hexHeight * 2) + (sideLength * 2);
    
    NSLog(@"tile height: %f", tileHeight);
    
    NSInteger counter = 0;
    
    for (counter = 0; counter < 20; counter++) {
        
        // STYLES
        
        NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
        CGFloat opacity = [Graphics opacity:val];
        UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
        UIColor *stroke = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
        
        
        switch (counter) {
            case 0: {
                fill = [UIColor redColor];
                CGRect rect = CGRectMake(-sideLength / 2, -sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];

                fill = [UIColor blueColor];
                rect = CGRectMake(tileWidth - sideLength / 2, -sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                
                fill = [UIColor blackColor];
                rect = CGRectMake(-sideLength / 2, tileHeight - sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                fill = [UIColor whiteColor];
                rect = CGRectMake(tileWidth - sideLength / 2, tileHeight - sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                break;
            }
            case 1: {
                CGRect rect = CGRectMake(hexWidth / 2 + triangleHeight, hexHeight / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                break;
            }
            case 2: {
                CGRect rect = CGRectMake(-sideLength / 2, tileHeight / 2 - sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                rect = CGRectMake(tileWidth - sideLength / 2, tileHeight / 2 - sideLength / 2, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                break;
            }
            case 3: {
                CGRect rect = CGRectMake(hexWidth / 2 + triangleHeight, hexHeight * 1.5 + sideLength, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context];
                break;
            }
            case 4: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(sideLength / 2, -sideLength / 2);
                CGAffineTransform r = CGAffineTransformRotate(t, 0);
                CGAffineTransform tr = CGAffineTransformTranslate(r, sideLength / 2, triangleHeight / 2);
                CGAffineTransform s;
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:tr];
                
                t = CGAffineTransformMakeTranslation(sideLength / 2, tileHeight - (-sideLength / 2));
                r = CGAffineTransformRotate(t, 0);
                tr = CGAffineTransformTranslate(r, sideLength / 2, triangleHeight / 2);
                s = CGAffineTransformScale(tr, 1, -1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                break;
            }
            case 5: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(tileWidth - sideLength / 2, -sideLength / 2);
                CGAffineTransform r = CGAffineTransformRotate(t, 0);
                CGAffineTransform tr = CGAffineTransformTranslate(r, sideLength / 2, triangleHeight / 2);
                CGAffineTransform s = CGAffineTransformScale(tr, -1, 1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                
                t = CGAffineTransformMakeTranslation(tileWidth - sideLength / 2, tileHeight + sideLength / 2);
                r = CGAffineTransformRotate(t, 0);
                tr = CGAffineTransformTranslate(r, sideLength / 2, triangleHeight / 2);
                s = CGAffineTransformScale(tr, -1, -1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                break;
            } case 6: {
                CGAffineTransform t = CGAffineTransformMakeTranslation((tileWidth / 2) + (sideLength / 2),
                                                                       hexHeight /2);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:t];
                break;
            } case 7: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(tileWidth - tileWidth / 2 - sideLength / 2,
                                                                       hexHeight /2);
                CGAffineTransform s = CGAffineTransformScale(t, 1, -1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                break;
            } case 8: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(tileWidth / 2 + sideLength / 2,
                                                                       tileHeight - hexHeight / 2);
                CGAffineTransform s = CGAffineTransformScale(t, 1, -1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
            } case 9: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(tileWidth - tileWidth / 2 - sideLength / 2,
                                                                       tileHeight - hexHeight / 2);
                CGAffineTransform s = CGAffineTransformScale(t, -1, -1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                break;
            } case 10: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(sideLength / 2,
                                                                       tileHeight / 2 - sideLength / 2);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:t];
                break;
            } case 11: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(tileWidth - sideLength / 2,
                                                                       tileHeight /2 - sideLength / 2);
                CGAffineTransform s = CGAffineTransformScale(t, -1, 1);
                
                [ShapeDrawer
                 drawRotatedTriangleWithWidth:triangleHeight
                 withSideLength:sideLength withFill:fill
                 withStroke:stroke atWidth:1
                 inConext:self.context
                 transformEffects:s];
                break;
            } case 12: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(sideLength / 2,
                                                                       sideLength / 2);
                CGAffineTransform r = CGAffineTransformRotate(t, radians(-30));
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:r];
                break;
            } case 13: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(-tileHeight + sideLength / 2,
                                                                       sideLength / 2);
                CGAffineTransform s = CGAffineTransformScale(t, -1, 1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(-30));
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:r];
                break;
            } case 14: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(sideLength / 2,
                                                                       tileHeight / 2 - sideLength / 2 - sideLength);
                CGAffineTransform r = CGAffineTransformRotate(t, radians(30));
    
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:r];
                break;
            } case 15: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(-tileHeight + sideLength / 2,
                                                                       tileHeight / 2 - sideLength / 2 - sideLength);
                CGAffineTransform s = CGAffineTransformScale(t, -1, 1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(30));
                CGAffineTransform tr = CGAffineTransformTranslate(r, 0, sideLength);
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:tr];
                break;
            } case 16: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(sideLength / 2,
                                                                     -tileHeight + tileHeight / 2 - sideLength / 2 - sideLength);
                CGAffineTransform s = CGAffineTransformScale(t, 1, -1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(30));
                CGAffineTransform tr = CGAffineTransformTranslate(r, 0, sideLength);
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:tr];
                break;
            } case 17: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(-tileHeight + sideLength / 2,
                                                                       -tileHeight + tileHeight / 2 - sideLength / 2 - sideLength);
                CGAffineTransform s = CGAffineTransformScale(t, -1, -1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(30));
                CGAffineTransform tr = CGAffineTransformTranslate(r, 0, sideLength);
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:tr];
                break;
            } case 18: {
                CGAffineTransform t = CGAffineTransformMakeTranslation( sideLength / 2,
                                                                       -tileHeight + sideLength / 2);
                CGAffineTransform s = CGAffineTransformScale(t, -1, -1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(-30));
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:r];
                break;
            } case 19: {
                CGAffineTransform t = CGAffineTransformMakeTranslation(-tileHeight + sideLength / 2,
                                                                       -tileHeight + tileHeight / 2);
                CGAffineTransform s = CGAffineTransformScale(t, -1, -1);
                CGAffineTransform r = CGAffineTransformRotate(s, radians(30));
                
                CGRect rect = CGRectMake(0, 0, sideLength, sideLength);
                [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth:1 inContext:self.context transformEffects:r];
                break;
            }
            default:
                break;
        }
    }
    
}

- (void) generateNestedsquares {
    
    NSInteger hashInt = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    CGFloat blockSize = [Graphics mapValue:hashInt inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:4 andUpperBound:12];
    CGFloat squareSize = blockSize * 7;
    
    NSInteger counter = 0, x = 0,y = 0;
    
    for (y = 0; y < 6; y++) {
        for (x = 0; x < 6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *stroke = [Graphics fillColor:val];
            UIColor *fill = [UIColor clearColor];
            
//            fill = [fill colorWithAlphaComponent:opacity];
            stroke = [stroke colorWithAlphaComponent:opacity];
            
            CGRect rect = CGRectMake(x * squareSize + x * blockSize * 2 + blockSize / 2.0,
                                     y * squareSize + y * blockSize * 2 + blockSize / 2.0,
                                     squareSize,
                                     squareSize);
            
            [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth: blockSize inContext:self.context];
            
            val = [Graphics intFromHex:self.hashValue atIndex:39-counter withLength:1];
            opacity = [Graphics opacity:val];
            stroke = [Graphics fillColor:val];
            
//            fill = [fill colorWithAlphaComponent:opacity];
            stroke = [stroke colorWithAlphaComponent:opacity];
            
            
            rect = CGRectMake(x * squareSize + x * blockSize * 2 + blockSize / 2.0 + blockSize * 2,
                              y * squareSize + y * blockSize * 2 + blockSize / 2.0 + blockSize * 2,
                              blockSize * 3,
                              blockSize * 3);
            
            [ShapeDrawer drawRectangle:rect withFill:fill withStroke:stroke atWidth: blockSize inContext:self.context];
            
            counter++;
        }
    }
    
}

- (void) generateMosaicsquares {
    
    NSInteger hexVal = [Graphics intFromHex:self.hashValue atIndex:0 withLength:1];
    CGFloat triangleSize = [Graphics mapValue:hexVal inRangeWithLower:0 andUpperBound:15 toNewRangeWithLowerBound:15 andUpperBound:50];
    
    NSInteger counter = 0, x = 0, y = 0;
    
    for (y = 0; y < 4; y++) {
        for (x = 0; x < 4; x++) {
            if (x % 2 == 0) {
                if (y % 2 == 0) {
                    NSInteger i = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
                    NSArray *values = @[[NSNumber numberWithInteger:i]];
                    
                    [self doOuterTrianglesX:x * triangleSize * 2
                                          y:y * triangleSize * 2
                                       size:triangleSize
                                     andVal:values];
                } else{
                    NSInteger i = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
                    NSInteger j = [Graphics intFromHex:self.hashValue atIndex:counter + 1 withLength:1];
                    
                    NSArray *values = @[[NSNumber numberWithInteger:i],
                                        [NSNumber numberWithInteger:j]];
                    
                    [self doInnerTrianglesX:x * triangleSize * 2
                                          y:y * triangleSize * 2
                                       size:triangleSize
                                     andVal:values];
                }
            } else {
                if (y % 2 == 0) {
                    NSInteger i = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
                    NSInteger j = [Graphics intFromHex:self.hashValue atIndex:counter + 1 withLength:1];
                    
                    NSArray *values = @[[NSNumber numberWithInteger:i],
                                        [NSNumber numberWithInteger:j]];
                    
                    [self doInnerTrianglesX:x * triangleSize * 2
                                          y:y * triangleSize * 2
                                       size:triangleSize
                                     andVal:values];
                } else {
                    NSInteger i = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
                    NSArray *values = @[[NSNumber numberWithInteger:i]];
                    
                    [self doOuterTrianglesX:x * triangleSize * 2
                                          y:y * triangleSize * 2
                                       size:triangleSize
                                     andVal:values];
                }
            }
            
            counter++;
        }
    }
 }

- (void) generateChevrons {
    
    CGFloat width = [Graphics mapValue:[Graphics intFromHex:self.hashValue atIndex:0 withLength:1]
                      inRangeWithLower:0
                         andUpperBound:15
              toNewRangeWithLowerBound:30
                         andUpperBound:80];
    
    CGFloat height = width;
    
    NSInteger counter = 0, y, x;
    
    for (y=0; y<6; y++) {
        for (x=0; x<6; x++) {
            NSInteger val = [Graphics intFromHex:self.hashValue atIndex:counter withLength:1];
            CGFloat opacity = [Graphics opacity:val];
            UIColor *stroke = [[Graphics STROKE_COLOR]
                                colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
            UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
            CGFloat strokeWidth = 1;
            
            CGFloat tx = x * width, ty = y * height * 0.66 - height / 2;
            
            [ShapeDrawer drawChevronWithWidth:width
                                   withHeight:height
                                     withFill:fill
                                   withStroke:stroke
                                      atWidth:strokeWidth
                                     inConext:self.context
                             transformEffects:CGAffineTransformMakeTranslation(tx, ty)];
            
            if (y==0) {
                
                ty = 6 * height * 0.66 - height / 2;
                
                [ShapeDrawer drawChevronWithWidth:width
                                       withHeight:height
                                         withFill:fill
                                       withStroke:stroke
                                          atWidth:strokeWidth
                                         inConext:self.context
                                 transformEffects:CGAffineTransformMakeTranslation(tx, ty)];
            }
            
            counter++;
        }
    }
    
}

#pragma mark - Shape Point Helpers

- (void) doInnerTrianglesX: (NSInteger) x y: (NSInteger) y size: (CGFloat) size andVal: (NSArray *) values {
    NSInteger val = [[values objectAtIndex:0] integerValue];
    CGFloat opacity = [Graphics opacity:val];
    UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
    UIColor *stroke = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
    
    CGFloat tx = x + size,
    ty = y;
    CGPoint scale = CGPointMake(-1, 1);
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    tx = x + size;
    ty = y + size * 2;
    scale.x = 1;
    scale.y = -1;
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    // update vals
    val = [[values objectAtIndex:1] integerValue];
    opacity = [Graphics opacity: val];
    fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
    
    tx = x + size;
    ty = y + size * 2;
    scale.x = -1;
    scale.y = -1;
    
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    tx = x + size;
    ty = y;
    scale.x = 1;
    scale.y = 1;
    
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];

    
    
}

- (void) doOuterTrianglesX: (NSInteger) x y: (NSInteger) y size: (CGFloat) size andVal: (NSArray *) values {
    NSInteger val = [[values objectAtIndex:0] integerValue];
    CGFloat opacity = [Graphics opacity:val];
    UIColor *fill = [[Graphics fillColor:val] colorWithAlphaComponent:opacity];
    UIColor *stroke = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
    
    CGFloat tx = x,
    ty = y + size;
    
    CGPoint scale = CGPointMake(1, -1);
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    tx = x + size * 2;
    ty = y + size;
    scale.x = -1;
    scale.y = -1;
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    tx = x;
    ty = y + size;
    scale.x = 1;
    scale.y = 1;
    
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    tx = x + size * 2;
    ty = y + size;
    scale.x = -1;
    scale.y = 1;
    
    t = CGAffineTransformMakeTranslation(tx, ty);
    
    [ShapeDrawer drawRightTriangleWithLength:size
                               withFill:fill
                             withStroke:stroke
                                atWidth:1
                               inConext:self.context
                       transformEffects:CGAffineTransformScale(t, scale.x, scale.y)];
    
    
    
}
@end
