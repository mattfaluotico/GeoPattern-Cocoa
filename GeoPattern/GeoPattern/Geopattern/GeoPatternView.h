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

- (void) generateFromString: (NSString *) string;
- (void) generateFromString: (NSString *) string withOptions: (NSDictionary *) options;

@end
