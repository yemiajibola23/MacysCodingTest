//
//  Acronym.h
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LongForm.h"

@interface Acronym : NSObject
@property NSString* shortForm;
@property NSMutableArray<LongForm* >* longForms;
-(instancetype) initWithJSONObject: (NSDictionary* )json;
@end
