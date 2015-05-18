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
    
}

- (void) generatePlaid {
    
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
            NSLog(@"%f", opacity);
            UIColor *fillColor = [Graphics fillColor:val];
            
            UIColor *fillOpacity = [fillColor colorWithAlphaComponent:opacity];
            UIColor *strokeColor = [[Graphics STROKE_COLOR] colorWithAlphaComponent:[Graphics STROKE_OPACITY]];
            CGRect rect = CGRectMake(x * squareSize, y * squareSize, squareSize, squareSize);
            
            [ShapeDrawer drawRectangle:rect withFill:fillOpacity withStroke:strokeColor inContext:self.context];
            
            counter++;
        }
    }
    
    
}

- (void) generateConcentriccircles {
    
}

- (void) generateDiamonds {
    
}

- (void) generateTessellation {
    
}

- (void) generateNestedsquares {
    
}

- (void) generateMosaicsquares {
    
}

- (void) generateChevrons {
    
}



@end
