//
//  LongForm.h
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongForm : NSObject
@property NSString* name;
@property int frequency;
@property int since;

-(instancetype) initWithJSONObject:(NSDictionary *)json;

@end
