//
//  Test.h
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Test : UIViewController {
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *buton;
    IBOutlet UILabel *countdown;

    NSInteger count;
    NSInteger seconds;
    
    NSTimer *timer1;
    NSTimer *timer2;

}

@end
