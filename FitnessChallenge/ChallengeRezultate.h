//
//  ChallengePushUpsRezultate.h
//  FitnessChallenge
//
//  Created by Cristian on 12/29/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ChallengeRezultate : UIViewController <RNFrostedSidebarDelegate> {
    
    IBOutlet UIButton *butonShare;
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    
    IBOutlet UILabel* labelChallengerUsername;
    IBOutlet UILabel* labelChallengeeUsername;
    
    IBOutlet UILabel* labelChallengerScore;
    IBOutlet UILabel* labelChallengeeScore;
    
    IBOutlet UILabel* labelOutcomeMessage;
}

@property PublicChallenge* challenge;
@property int repsNumber;

@end
