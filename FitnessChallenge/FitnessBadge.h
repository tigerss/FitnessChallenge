//
//  FitnessBadge.h
//  FitnessChallenge
//
//  Created by Alex on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseTables.h"

@interface FitnessBadge : NSObject

@property NSString* name;
@property NSString* image;
@property NSString* description;

+ (FitnessBadge*) fromBadge: (Badge*) badge;

- (NSDictionary*) toDictionary;
+ (FitnessBadge*) fromDictionary:(NSDictionary*) dictionary;
@end
