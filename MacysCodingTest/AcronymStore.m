//
//  AcronymStore.m
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import "AcronymStore.h"


@implementation AcronymStore

-(NSURL* )url {
    return [NSURL URLWithString:@"http://www.nactem.ac.uk/software/acromine/dictionary.py"];
}

// AFNetworking manager property to handle request and response
-(AFHTTPSessionManager* )manager {
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.url];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    return manager;
}

// Takes in string of user input
// Turns JSON into Acronym, calls completion block to handle results
-(void)fetchAcronym:(NSString *)shortForm completion:(void (^)(NSError * _Nullable))handler {
    NSDictionary* params = @{@"sf": shortForm};
    
    [self downloadJSON: params completion:^(NSArray* _Nullable json, NSError * _Nullable error) {
        if(error) {
            handler(error);
        } else if(json.count <= 0) {
            NSError* jsonCountError = [[NSError alloc] initWithDomain:@"com.YemiAjibola.MacysCodingTest" code:200 userInfo:@{@"errorReason": @"No results found"}];
            handler(jsonCountError);
        }
        else {
            Acronym* acronym = [[Acronym alloc] initWithJSONObject:json[0]];
            self.searchedAcronym = acronym;
            handler(NULL);
        }
        
    }];
}
// Takes in dictionary of parameters to pass
// Downloads JSON based on parameters, calls completion to handle results
-(void)downloadJSON:(NSDictionary* )params completion:(JSONHandler) handler {
    [self.manager GET:self.url.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData* responseData = (NSData *) responseObject;
        NSError* jsonError;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error: &jsonError];
        
        if (jsonError) {
            handler(NULL, jsonError);
        } else {
            handler(jsonObject, NULL);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(NULL, error);
    }];
}



@end
