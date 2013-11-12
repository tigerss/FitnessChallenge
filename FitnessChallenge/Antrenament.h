//
//  Antrenament.h
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Antrenament : UIViewController {
    
    IBOutlet UILabel *secunde;
    IBOutlet UIButton *butonRenunta;
    IBOutlet UIButton *butonSariPesteEx;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UIButton *butonInfo;
    IBOutlet UILabel *countdown;
    
    IBOutlet UILabel *p1;
    IBOutlet UILabel *p2;
    IBOutlet UILabel *p3;
    IBOutlet UILabel *p4;
    IBOutlet UILabel *p5;
    IBOutlet UILabel *p6;
    IBOutlet UILabel *p7;
    IBOutlet UILabel *p8;
    
    NSInteger count;
    NSInteger seconds;
    NSInteger seconds2;
    
    float prog;
    
    NSTimer *timer0;
    NSTimer *timer1;
    NSTimer *timer2;
    
}

@end
