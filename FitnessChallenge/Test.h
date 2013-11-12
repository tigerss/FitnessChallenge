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
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *countdown;
    IBOutlet UILabel *nrFlotari;

    NSInteger count;
    NSInteger seconds;
    NSInteger seconds2;
    
    float prog;
    
    NSTimer *timer1;
    NSTimer *timer2;

}

@end
