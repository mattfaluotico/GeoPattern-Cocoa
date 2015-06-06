//
//  ViewController.m
//  GeoPatternDemo
//
//  Created by Matthew Faluotico on 6/3/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ViewController.h"
#import "GeoPatterns.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GeoPatternView *v = [GeoPatternView new];
    v.frame = CGRectMake(0, 0, 100, 100);
    [v generateFromString:@"Matt"];
    [self.view addSubview:v];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
