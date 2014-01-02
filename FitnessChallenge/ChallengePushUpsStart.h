//
//  ChallengePushUpsStart.h
//  FitnessChallenge
//
//  Created by Cristian on 12/29/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ChallengePushUpsStart : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *nrFlotari;
    
    NSInteger repsNumber;
    NSInteger seconds;
    
    float prog;
    
    NSTimer *timerTest;
    
}

@property PublicChallenge* challenge;

@end
