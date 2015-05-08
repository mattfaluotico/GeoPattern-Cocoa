//
//  Pattern.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "Pattern.h"
#import "Graphics.h"

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
    self.hashValue = [Graphics generateHash:[options objectForKey:@"string"]];
    return self;
}

- (void) temp {
    CGColorRef color = ((UIColor*)[self.options objectForKey:@"color"]).CGColor;
    
    UIColor * dotColor = [UIColor colorWithCGColor:color];
    
    CGContextSetFillColorWithColor(self.context, dotColor.CGColor);
    
    CGContextAddArc(self.context, 3, 3, 6, 0, radians(360), 0);
    CGContextFillPath(self.context);
    
    CGContextAddArc(self.context, 20, 20, 6, 0, radians(360), 0);
    CGContextFillPath(self.context);
}

- (void) generate {
    CGColorRef fillColor = [Graphics fillColor:100].CGColor;
};

+ (NSDictionary*) defaults {
    return @{
             @"color" : [UIColor redColor]
             };
}

// TEMP
static inline double radians (double degrees)  {
    return degrees * M_PI/180;
}

@end
