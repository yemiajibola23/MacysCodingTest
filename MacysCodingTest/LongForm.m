//
//  LongForm.m
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import "LongForm.h"

@implementation LongForm

-(instancetype) initWithJSONObject:(NSDictionary *)json {
    self = [super init];
    
    if (self) {
        self.name = json[@"lf"];
        self.since = (int)json[@"since"];
        self.frequency = (int)json[@"freq"];
    }
    
    return self;
}


@end
