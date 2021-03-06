//
//  Test.h
//  FitnessChallenge
//
//  Created by Cristian on 11/18/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface Test : UIViewController<RNFrostedSidebarDelegate> {
    
    NSInteger timeTillTestStarts;
    IBOutlet UILabel *countdown;
    NSTimer *timerBeforeTest;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;

@end
