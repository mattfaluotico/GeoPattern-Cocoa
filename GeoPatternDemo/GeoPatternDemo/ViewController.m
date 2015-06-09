//
//  ViewController.m
//  GeoPatternDemo
//
//  Created by Matthew Faluotico on 6/3/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ViewController.h"
#import "GeoPattern.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet GeoPatternView *geoview;
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.geoview generateFromString:@"Matt"];
    self.text.delegate = self;
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *s = [NSString stringWithFormat: @"%@%@", self.text.text, string ];
    [self.geoview generateFromString:s];
    return YES;
}

@end
