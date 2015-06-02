//
//  GeoPatternView.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "GeoPatternView.h"
#import "GeoPatternConstants.h"
#import "Helpers.h"

@interface GeoPatternView()
@end

@implementation GeoPatternView

#pragma mark - Generate

- (void) generate {
    [self setNeedsDisplay];
}

- (void) generateFromString: (NSString *) string {
    self.string = string;
    self.options = [NSMutableDictionary new];
    [self generate];
}

- (void) generateFromString: (NSString *) string withOptions: (NSDictionary *) options {
    
    self.string = string;
    self.options = options;
    
    [self generate];
    
}

#pragma mark - Override

- (void) drawRect: (CGRect)rect {
    
    if (self.string || self.options) {
        [self generateAtRect:rect];
    } else {
        [super drawRect:rect];
    }

}

#pragma mark - Primary generation method

- (void) generateAtRect: (CGRect) rect {
    // Adds String and Hash to the options dictionary
    NSMutableDictionary *options = [self.options mutableCopy];
    [options setObject:self.string forKey:kGeoPatternString];
    [options setObject:[Helpers generateHash:self.string] forKey:kGeoPatternHash];
    CGSize size = [Pattern calculateSizeFromOptions:options];
    [options setObject:[NSValue valueWithCGSize:size] forKey:@"size"];
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0); // 0.0 = auto scale
    CGContextRef imgContext = UIGraphicsGetCurrentContext();
    
    UIColor *backgroundColor = [Helpers backgroundColor:options];
    NSLog(backgroundColor.description);
    CGContextSetFillColorWithColor(imgContext, backgroundColor.CGColor);
    CGContextFillRect(imgContext, rect);
    
    Pattern *pattern = [[Pattern alloc]
                        initWithContext:imgContext
                        WithOptions:options];
    [pattern generate];
    
    UIImage *patternImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIColor *patternAsColor = [UIColor colorWithPatternImage:patternImage];
    [patternAsColor setFill];
    [[UIColor clearColor] setStroke];
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
}

@end
