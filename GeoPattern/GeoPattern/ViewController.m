//
//  ViewController.m
//  GeoPattern
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import "ViewController.h"
#import "GeoPatterns.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet GeoPatternView *goeview;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.goeview generateFromString:@"Matt"];
    self.textfield.delegate = self;

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *s = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    [self.goeview generateFromString:s withOptions:@{
                                                     kGeoPatternType : [NSNumber numberWithInteger :GeoPatternXes]
                                                     }];
    
    return YES;
}

@end
