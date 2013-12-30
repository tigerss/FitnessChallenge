//
//  IncepeTest.h
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface IncepeTest : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *nrFlotari;

    NSInteger repsNumber;
    NSInteger seconds;
    
    float prog;
    
    NSTimer *timerTest;

}

@end
