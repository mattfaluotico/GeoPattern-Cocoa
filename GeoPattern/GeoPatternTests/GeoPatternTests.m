//
//  GeoPatternTests.m
//  GeoPatternTests
//
//  Created by Matthew Faluotico on 5/7/15.
//  Copyright (c) 2015 MF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

// --

#import "Graphics.h"
#import "Pattern.h"

@interface GeoPatternTests : XCTestCase

@end

@implementation GeoPatternTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Hex generation

- (void) testGenerateHash {
    
    NSString *me = @"Matt";
    NSString *hash = [Graphics generateHash:me];
    // #0f9fe690f38da67968280971584cf9c16541f07b From Jason Longs script
    
    XCTAssert([hash isEqualToString:@"0f9fe690f38da67968280971584cf9c16541f07b"], @"Matches Jason Long value");
}

- (void) testGenerateHash2 {
    
    NSString *hash = [Graphics generateHash:@"Matt Faluotico"];
    // #6e6c409873b65d686d9262e34ee6281c722bc786 From Jason Longs script
    
    XCTAssert([hash isEqualToString:@"6e6c409873b65d686d9262e34ee6281c722bc786"], @"Matches Jason Long value");
}

@end
