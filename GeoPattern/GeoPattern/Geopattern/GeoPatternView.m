//
//  GeoPatternView.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "GeoPatternView.h"
#import "UIColor+MyColors.h"

@interface GeoPatternView()
@end

@implementation GeoPatternView

#pragma mark - Generate

- (void) generateFromString: (NSString *) string {

    NSDictionary *defaults = [Pattern defaults];
    [self generateFromString:string withOptions:defaults];
}
- (void) generateFromString: (NSString *) string withOptions: (NSDictionary *) options {
    
    // Adds color to the options dictionary
    NSMutableDictionary *optionsWithString = [options mutableCopy];
    [optionsWithString setObject:string forKey:@"string"];
    
    // Gathering context
    CGContextRef context = UIGraphicsGetCurrentContext();
    static const CGPatternCallbacks callbacks = { 0, &DrawPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    // Passes the Objective-C NSDictionary to a void pointe
    // allowing it to be passed as a callback parameter
    void *o = (void*)CFBridgingRetain(optionsWithString);
    
    CGPatternRef pattern = CGPatternCreate(o,
                                           self.frame,
                                           CGAffineTransformIdentity,
                                           32,
                                           32,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
    
}

#pragma mark - Override

- (void) drawRect: (CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *backgroundColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    [self generateFromString:@"Matt"];
}

#pragma mark - Handling Callbacks

// Draws the repeatable pattern itself
void DrawPattern (void *info, CGContextRef context) {
    
    NSDictionary *options = (__bridge NSDictionary*)info;
    Pattern *pattern = [[Pattern alloc] initWithContext:context WithOptions:options];
    [pattern temp];
    
}



@end
