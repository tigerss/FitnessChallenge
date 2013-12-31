//
//  AppDelegate.h
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AVFoundation/AVFoundation.h>
#import "MeniuDreaptaRegUsr.h"
#import "FitnessBadge.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVAudioPlayer *alertSound;
@property (strong, nonatomic) AVAudioPlayer *bgMusicForTest;
@property (strong, nonatomic) AVAudioPlayer *bgMusicForWorkout;
@property (strong, nonatomic) MeniuDreaptaRegUsr *customLoginViewController;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;

@end