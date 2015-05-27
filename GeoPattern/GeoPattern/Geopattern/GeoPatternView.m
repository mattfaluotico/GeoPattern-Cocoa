//
//  GeoPatternView.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "GeoPatternView.h"
#import "GeoPatternConstants.h"
#import "Graphics.h"

@interface GeoPatternView()
@end

@implementation GeoPatternView

#pragma mark - Generate

- (void) generate {
    [self setNeedsDisplay];
}

- (void) generateFromString: (NSString *) string {
    self.string = string;
    self.options = [Pattern defaults];
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
    }

    
}

#pragma mark - Primary generation method

- (void) generateAtRect: (CGRect) rect {
    // Adds String and Hash to the options dictionary
    NSMutableDictionary *optionsWithHash = [self.options mutableCopy];
    [optionsWithHash setObject:self.string forKey:kGeoPatternString];
    [optionsWithHash setObject:[Graphics generateHash:self.string] forKey:kGeoPatternHash];
    
    // Gathering context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Callbacks for generating a pattern
    static const CGPatternCallbacks callbacks = { 0, &DrawPattern, NULL };
    
    // Set the background color
    UIColor *backgroundColor = [Graphics backgroundColor:optionsWithHash];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    // save context before generating pattern
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    // Get the size
    CGSize size = [Pattern calculateSizeFromOptions:optionsWithHash];
    [optionsWithHash setObject:[NSValue valueWithCGSize:size] forKey:@"size"];

    // Passes the Objective-C NSDictionary to a void pointe
    // allowing it to be passed as a callback parameter
    void *o = (void*)CFBridgingRetain(optionsWithHash);
    
    
    
    CGPatternRef pattern = CGPatternCreate(o,
                                           self.frame,
                                           CGAffineTransformIdentity,
                                           size.width,
                                           size.height,
                                           kCGPatternTilingNoDistortion,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
}

#pragma mark - Handling Callbacks

// Draws the pattern itself. Info is a void pointer holding the users options
// context is the graphic context from the view
void DrawPattern (void *info, CGContextRef context) {

    NSDictionary *args = (__bridge NSDictionary*)info;
    Pattern *pattern = [[Pattern alloc] initWithContext:context WithOptions:args];
//    [pattern temp];
    [pattern generate];
    
}



@end
