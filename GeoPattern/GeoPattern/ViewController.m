//
//  ViewController.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ViewController.h"
#import "GeoPatterns.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GeoPatternView *goeview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.goeview generateFromString:@"Matt"];
    
    GeoPatternView *v = [[GeoPatternView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [v generateFromString:@"Matt" withOptions:@{
                                                kGeoPatternType : [NSNumber numberWithInteger :GeoPatternSquares]
                                                }];
    [self.view addSubview:v];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
