//
//  AcronymStore.h
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Acronym.h"

typedef void (^JSONHandler)(NSArray* _Nullable, NSError* _Nullable);

@interface AcronymStore: NSObject
@property Acronym* _Nonnull searchedAcronym;

-(void)fetchAcronym:(NSString* _Nonnull)shortForm completion:(void (^_Nonnull)(NSError* _Nullable)) handler;


@end
