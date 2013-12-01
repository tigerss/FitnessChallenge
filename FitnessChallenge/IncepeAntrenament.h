//
//  IncepeAntrenament.h
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"
#import <AVFoundation/AVFoundation.h>

@interface IncepeAntrenament : UIViewController<RNFrostedSidebarDelegate,AVAudioPlayerDelegate> {
    
    IBOutlet UILabel *secunde;
    IBOutlet UILabel *exercise;
    IBOutlet UIButton *butonPauzaStart;
    IBOutlet UILabel *countdown;
    IBOutlet UIProgressView *progressBar;
    
    NSInteger count;
    NSInteger seconds;
    NSInteger seconds2;
    
    float prog;
    
    NSTimer *timer0;
    NSTimer *timer1;
    NSTimer *timer2;
    NSTimer *timer3;
    
}

@property (strong, nonatomic) AVAudioPlayer *alertSound;
@property (strong, nonatomic) AVAudioPlayer *bgMusic;

@end
