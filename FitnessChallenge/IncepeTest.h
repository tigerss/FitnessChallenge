//
//  IncepeTest.h
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface IncepeTest : UIViewController<RNFrostedSidebarDelegate>{
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *countdown;
    IBOutlet UILabel *nrFlotari;

    NSInteger repsNumber;
    NSInteger seconds;
    NSInteger seconds2;
    
    float prog;
    
    NSTimer *timer1;
    NSTimer *timer2;

}

@end
