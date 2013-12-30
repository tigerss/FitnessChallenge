//
//  ChallengeStart.h
//  FitnessChallenge
//
//  Created by Cristian on 12/31/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ChallengeStart : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonPauzaStart;
    
    NSInteger repsNumber;
    NSInteger seconds;
    
    float prog;
    
    NSTimer *timerTest;
    
}

@end
