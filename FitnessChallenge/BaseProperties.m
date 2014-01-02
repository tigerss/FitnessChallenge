//
//  BaseProperties.m
//  FitnessChallenge
//
//  Created by Alex on 1/2/14.
//  Copyright (c) 2014 C.A.D. All rights reserved.
//

#import "BaseProperties.h"

@implementation BaseProperties

@synthesize _id;
@synthesize _rev;

- (id) init {
    self = [super init];
    if (self) {        
        _id = @"";
        _rev = @"";
    }
    return self;
}

@end
