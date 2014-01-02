//
//  PublicChallenge.h
//  FitnessChallenge
//
//  Created by Alex on 1/1/14.
//  Copyright (c) 2014 C.A.D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProperties.h"

@interface PublicChallenge : BaseProperties

@property NSString* challengerUsername;
@property NSString* challengeeUsername;

@property NSString* exerciseName;

@property int challengerRepsNumber;
@property int challengeeRepsNumber;

- (BOOL) isOpen;
- (BOOL) isTie;
- (BOOL) isChallengerWinner;
- (BOOL) isChallengeeWinner;

- (NSDictionary*) toDictionary;
+ (PublicChallenge*) fromDictionary:(NSDictionary*) dictionary;
@end
