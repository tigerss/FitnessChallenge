//
//  IncepeAntrenament.h
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface IncepeAntrenament : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UILabel *secunde;
    IBOutlet UILabel *exerciseName;
    IBOutlet UILabel *exerciseText;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *countdown;
    IBOutlet UIProgressView *progressBar;
    
    NSInteger count;
    NSInteger seconds;
    
    float prog;
    
    NSTimer *timer0;
    NSTimer *timer;
    
}

@end
