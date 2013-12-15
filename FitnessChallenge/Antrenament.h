//
//  Antrenament.h
//  FitnessChallenge
//
//  Created by Cristian on 11/18/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface Antrenament : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UILabel *exercise;
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *secondsBeforeWorkout;
    
    NSInteger seconds;
    NSTimer *timerBeforeWorkout;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;

@end
