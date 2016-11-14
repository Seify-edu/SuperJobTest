//
//  testConnectionService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ConnectionService.h"

@interface testConnectionService : XCTestCase <ConnectionServiceDelegate>
@property ConnectionService *connectionService;
@property BOOL didCallbackLoad;
@property BOOL didCallbackFail;
@property NSData *data;
@end

@implementation testConnectionService

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    self.connectionService = [ConnectionService sharedService];
    self.connectionService.delegate = self;
}

- (void)tearDown
{
    self.data = nil;
    self.didCallbackLoad = NO;
    self.didCallbackFail = NO;
    [super tearDown];
}

#pragma mark - Helpers

- (BOOL)waitForLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didCallbackLoad );
    
    return self.didCallbackLoad;
}

- (BOOL)waitForFail:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didCallbackFail );
    
    return self.didCallbackFail;
}

#pragma mark - ConnectionServiceDelegate methods

- (void)connectionServiceDidLoadData:(NSData *)data
{
    self.didCallbackLoad = YES;
    self.data = data;
};

- (void)connectionDidFailWithError:(NSError *)error
{
    self.didCallbackFail = YES;
    self.data = nil;
};

#pragma mark - Tests

- (void)testConnectionServiceCallsItsDelegateOnLoadGoodURL
{
    NSURL *goodURL = [NSURL URLWithString:@"https://api.superjob.ru/:2.0/vacancies"];
    [self.connectionService loadDataFromURL:goodURL];
    [self waitForLoad:10];
    XCTAssertTrue( self.didCallbackLoad );
}

- (void)testConnectionServiceCallsItsDelegateOnLoadBadURL
{
    NSURL *badURL = [NSURL URLWithString:@"nasty"];
    [self.connectionService loadDataFromURL:badURL];
    [self waitForFail:10];
    XCTAssertTrue( self.didCallbackFail );
}

@end
