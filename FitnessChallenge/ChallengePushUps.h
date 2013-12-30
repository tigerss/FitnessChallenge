//
//  ChallengePushUps.h
//  FitnessChallenge
//
//  Created by Cristian on 12/29/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ChallengePushUps : UIViewController<RNFrostedSidebarDelegate> {
    
    NSInteger timeTillChallengePushUpsStarts;
    IBOutlet UILabel *countdown;
    NSTimer *timerBeforeChallengePushUps;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;

@end
