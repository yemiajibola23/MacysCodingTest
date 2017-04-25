//
//  Acronym.m
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import "Acronym.h"

@implementation Acronym
-(instancetype) initWithJSONObject: (NSDictionary* )json {
    self = [super init];
    
    if(self) {
        self.shortForm = [json objectForKey:@"sf"];
        self.longForms = [[NSMutableArray alloc] init];
        for(NSDictionary* longForm in json[@"lfs"]) {
            LongForm* lf = [[LongForm alloc]initWithJSONObject:longForm];
            [self.longForms addObject:lf];
        }
    }
    
    return self;
}


@end
