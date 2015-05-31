//
//  GeoPatternView.h
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pattern.h"

@interface GeoPatternView : UIView

@property NSString *string;
@property NSDictionary *options;

// Generate with a passed string
- (void) generateFromString: (NSString *) string;
// generate with a passed string and options
- (void) generateFromString: (NSString *) string withOptions: (NSDictionary *) options;
// generate when the string and options have already been set
- (void) generate;

@end
