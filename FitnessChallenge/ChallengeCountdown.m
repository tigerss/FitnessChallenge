//
//  ChallengePushUps.m
//  FitnessChallenge
//
//  Created by Cristian on 12/29/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Test.h"
#import "UIImage+animatedGIF.h"
#import "Autentificare.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"
#import "MeniuDreaptaRegUsr.h"
#import "Challenges.h"
#import "ChallengeCountdown.h"
#import "ChallengeStart.h"
#import "ChallengePushUpsStart.h"

@interface ChallengeCountdown ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation ChallengeCountdown

@synthesize dataImageView;
@synthesize urlImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if((sharedPlayerAlertSound.isPlaying==YES))
            [sharedPlayerAlertSound stop];
        [sharedPlayerAlertSound setCurrentTime:0];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
        NSLog(@"%f",sharedPlayerMusicForWorkout.currentTime);
        if((sharedPlayerMusicForWorkout.isPlaying==YES))
            [sharedPlayerMusicForWorkout stop];
        [sharedPlayerMusicForWorkout setCurrentTime:0];
    }
    
    challengeExName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"]];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Push-Ups"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"pushups" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Jumping Jacks"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"jmpjack" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Mountain Climbers"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"mountainclimber" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Planks (With Rotation)"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"plankwrotation" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Triceps Dips"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"tricepsdip" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Burpees"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"burpee" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Bodyweight Squats"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"squat" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"High Knee Drills"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"highkneedrill" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Double Crunches"]) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"doublecrunch" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:3];
    
    [self setupCountdown];
    
}

- (IBAction)showMenu:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"home"],
                        [UIImage imageNamed:@"test"],
                        [UIImage imageNamed:@"workout"],
                        [UIImage imageNamed:@"challenges"],
                        [UIImage imageNamed:@"achievements"],
                        [UIImage imageNamed:@"gear"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    
    callout.delegate = self;
    
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
    if(index==0)
    {
        
        FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    if(index==1)
    {
        
        Test * view = [[Test alloc] initWithNibName:@"Test" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==2)
    {
        
        Antrenament * view = [[Antrenament alloc] initWithNibName:@"Antrenament" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==3)
    {
        
        Challenges * view = [[Challenges alloc] initWithNibName:@"Challenges" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==4)
    {
        
        Recompense * view = [[Recompense alloc] initWithNibName:@"Recompense" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==5)
    {
        
        Optiuni * view = [[Optiuni alloc] initWithNibName:@"Optiuni" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    
    if (itemEnabled)
        self.optionIndices = [NSMutableIndexSet indexSetWithIndex:index];
    
}

- (void)setupCountdown {
    
    timeTillChallengePushUpsStarts = 10;
    
    countdown.text = [NSString stringWithFormat:@"will begin in %i seconds", timeTillChallengePushUpsStarts];
    
    timerBeforeChallengePushUps = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                       target:self
                                                     selector:@selector(secondsBeforeChallengePushUps)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)secondsBeforeChallengePushUps {
    
    timeTillChallengePushUpsStarts--;
    
    countdown.text = [NSString stringWithFormat:@"will begin in %i seconds", timeTillChallengePushUpsStarts];
    
    if (timeTillChallengePushUpsStarts <=3)
    {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound play];
        }
    }
    
    if (timeTillChallengePushUpsStarts==0) {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
        {
            AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
            [sharedPlayerMusicForTest play];
        }
        
        [timerBeforeChallengePushUps invalidate];
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] isEqualToString:@"Push-Ups"]) {
        
            ChallengePushUpsStart * view = [[ChallengePushUpsStart alloc] initWithNibName:@"ChallengePushUpsStart" bundle:nil];
            [view setChallenge: _challenge];
            view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:view animated:YES completion:nil];
        }
        
        else {
            ChallengeStart * view = [[ChallengeStart alloc] initWithNibName:@"ChallengeStart" bundle:nil];
            [view setChallenge: _challenge];
            view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:view animated:YES completion:nil];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timerBeforeChallengePushUps invalidate];
}

- (IBAction)cancelChallengePushUps {
    
    Challenges * view = [[Challenges alloc] initWithNibName:@"Challenges" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

@end