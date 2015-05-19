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
    
}

- (void) generateTessellation {
    
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
    
}

- (void) generateChevrons {
    
}



@end
