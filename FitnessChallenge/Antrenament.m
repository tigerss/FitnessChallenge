//
//  Antrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/18/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "UIImage+animatedGIF.h"
#import "IncepeAntrenament.h"
#import "Autentificare.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"
#import "MeniuDreaptaRegUsr.h"
#import "IncepeAntrenament.h"

@interface Antrenament ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) NSArray *exerciseNames;

@end

@implementation Antrenament

@synthesize dataImageView;
@synthesize urlImageView;
@synthesize exerciseNames;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:2];
    
    self.exerciseNames = [NSArray arrayWithObjects:
                          @"Jumping Jacks",
                          @"Mountain Climbers",
                          @"Planks (With Rotation)",
                          @"Triceps Dips",
                          @"Burpees",
                          @"Bodyweight Squats",
                          @"High Knee Drills",
                          @"Double Crunches",
                          nil];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentExIsSet"]==NULL) {
    
    [standardDefaults setInteger:1 forKey:@"currentEx"];
    [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] > 1) {
        
        [cancelButton setEnabled:FALSE];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 1) {
            
            exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:0]];
            
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"jmpjack" withExtension:@"gif"];
            self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
            self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 2) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:1]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"mountainclimber" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 3) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:2]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"plankwrotation" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 4) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:3]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"tricepsdip" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 5) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:4]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"burpee" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 6) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:5]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"squat" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 7) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:6]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"highkneedrill" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }

    if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentEx"] == 8) {
        
        exercise.text = [NSString stringWithFormat:@"%@", [self.exerciseNames objectAtIndex:7]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"doublecrunch" withExtension:@"gif"];
        self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
    }
    
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
        
        //Challenges
        
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
    
    seconds = 10;
    
    secondsBeforeWorkout.text = [NSString stringWithFormat:@"will begin in %i seconds", seconds];
    
    timerBeforeWorkout = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(subtractTime)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)subtractTime {
        
        seconds--;
    
    secondsBeforeWorkout.text = [NSString stringWithFormat:@"will begin in %i seconds", seconds];
    
    if (seconds <=3)
    {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound play];
        }
        
    }
    
    if (seconds==0) {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
        {
            AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
            [sharedPlayerMusicForWorkout play];
        }
        
        [timerBeforeWorkout invalidate];
        
        IncepeAntrenament * view = [[IncepeAntrenament alloc] initWithNibName:@"IncepeAntrenament" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timerBeforeWorkout invalidate];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if(sharedPlayerAlertSound.isPlaying==YES) {
            [sharedPlayerAlertSound stop];
            [sharedPlayerAlertSound setCurrentTime:0];
        }
    }
}

- (IBAction)cancelWorkout {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

@end
