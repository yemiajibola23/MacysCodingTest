//
//  AcronymStoreTests.m
//  MacysCodingTest
//
//  Created by User on 4/24/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AcronymStore.h"

@interface AcronymStoreTests : XCTestCase

@end

@implementation AcronymStoreTests
AcronymStore* store;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    store = [[AcronymStore alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    store = NULL;
    [super tearDown];
    
}

-(void)testAcronymStoreReturnsResult{
    XCTestExpectation* expectation = [self expectationWithDescription:@"Store timed out."];
    
    NSString* testAcronym = @"FEMA";
    
    [store fetchAcronym:testAcronym completion:^(NSError*  _Nullable error) {
        XCTAssertNotNil(store.searchedAcronym, @"Acronym should return a result");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Error");
        }
    }];
    
}

-(void)testAcronymStoreReturnsErrorForBadInput {
    XCTestExpectation* expectation = [self expectationWithDescription:@"Store timed out."];
    
    NSString* testAcronym = @"dafasfsaffgag";
    
    [store fetchAcronym:testAcronym completion:^(NSError*  _Nullable error) {
        XCTAssertNotNil(error, @"Acronym should return an error for bad input");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Error");
        }
    }];
}

-(void)testAcronymStoreReturnsErrorForNoInput {
    XCTestExpectation* expectation = [self expectationWithDescription:@"Store timed out."];
    
    NSString* testAcronym = @"";
    
    [store fetchAcronym:testAcronym completion:^(NSError*  _Nullable error) {
        XCTAssertNotNil(error, @"Acronym should return an error for no input");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Error");
        }
    }];
}


@end
