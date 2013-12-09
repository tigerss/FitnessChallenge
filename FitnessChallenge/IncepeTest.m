//
//  IncepeTest.m
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "IncepeTest.h"
#import "STKSpinnerView.h"
#import <QuartzCore/QuartzCore.h>
#import "TestRezultate.h"
#import "Autentificare.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"

@interface IncepeTest () {
    
    NSArray* users;
    NSArray* workouts;
    
}

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation IncepeTest

BOOL amInceput=0, pauza, bgMusic=0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterInBackGround) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterInForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    // Enabled monitoring of the sensor
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    // Set up an observer for proximity changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
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
    
    seconds2 = 10;
    
    countdown.text = [NSString stringWithFormat:@"%i", seconds2];
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(subtractTime2)
                                            userInfo:nil
                                             repeats:YES];
    
    [self golesteCerc];
    
}

- (void)subtractTime2 {
    
    if (pauza==0)
    
        seconds2--;
    
        countdown.text = [NSString stringWithFormat:@"%i", seconds2];
    
    if (seconds2 <=3)
    {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            
            [butonPauzaStart setEnabled:NO];
            
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound play];
            
        }
        
    }
    
    if (seconds2==0) {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
        {
            
            bgMusic = 1;
        
            AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
            [sharedPlayerMusicForTest play];
            
        }
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            
            [butonPauzaStart setEnabled:YES];
            
        }
        
        [timer1 invalidate];
        
        [countdown setHidden:TRUE];
        
        [secunde setHidden:FALSE];
        
        [self setupPushups];
        
        [self umpleCerc];
        
    }
    
}


- (void)setupPushups {
    
    seconds = 60;
    repsNumber = 0;
    amInceput = 1;
    
    secunde.text = [NSString stringWithFormat:@"%i", seconds];
    nrFlotari.text = [NSString stringWithFormat:@"%i reps", repsNumber];
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (IBAction)buttonPressed {
    
    if ([butonPauzaStart.titleLabel.text isEqualToString:@"pause"]) {
        
        pauza = 1;
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
        
            if(bgMusic == 1) {
                AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
                [sharedPlayerMusicForTest pause];
            }
            
        }
        
        [butonPauzaStart setTitle:@"resume" forState:UIControlStateNormal];
        
    }
    
    else if ([butonPauzaStart.titleLabel.text isEqualToString:@"resume"]) {
        
        pauza = 0;
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
            
            if(bgMusic == 1) {
                AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
                [sharedPlayerMusicForTest play];
            }
            
        }
        
        [butonPauzaStart setTitle:@"pause" forState:UIControlStateNormal];
        
    }
    

}

- (void)umpleCerc {
    
    prog = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
    
}

- (void)golesteCerc {
    
    prog = 1.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinitB:) userInfo:nil repeats:YES];
    
}


- (void)subtractTime {
    
    if(pauza==0) {
        
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    seconds--;
    secunde.text = [NSString stringWithFormat:@"%i",seconds];
        
    if (seconds <=3) {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            
            [butonPauzaStart setEnabled:NO];
            
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound play];
            
        }
            
    }
    
    if (seconds == 0) {
        
        [timer2 invalidate];
        
        bgMusic = 0;
        
        [butonPauzaStart setEnabled:YES];
        
        secunde.text = [NSString stringWithFormat:@":)"];
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound stop];
            [sharedPlayerAlertSound setCurrentTime:0];
        }
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
            [sharedPlayerMusicForTest stop];
            [sharedPlayerMusicForTest setCurrentTime:0];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time's up !"
                                                        message:[NSString stringWithFormat:@"You have made %i push-ups.", repsNumber]
                                                       delegate:self
                                              cancelButtonTitle:@"Continue"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
        
    }
    
    else if(pauza==1){
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        //insert test results into db
        
        users = [DatabaseHelper selectUsers];
        
        User* user = [users objectAtIndex:0];
        
        NSDate *today=[NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
        NSString *dateString=[dateFormat stringFromDate:today];
        
        NSNumber *esteTest = [NSNumber numberWithInt:1];
        
        [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
        
        NSDate *today2=[NSDate date];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
        NSString *dateString2=[dateFormat2 stringFromDate:today2];
        
        [DatabaseHelper updateWorkout:dateString2];
        
        workouts = [DatabaseHelper selectWorkoutIsTest];
        
        Workout* workout = [workouts objectAtIndex:workouts.count-1];
        
        [DatabaseHelper insertWorkoutExercise:workout._id :@"Test" :user.userUUID :[NSNumber numberWithInt:repsNumber]];
        
        // check if user earned a new badge
        if(repsNumber>40) {
            NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:9]];
            users = [DatabaseHelper selectUsers];
            User* user = [users objectAtIndex:0];
            int numberOfBadges = [badges count];
            if(numberOfBadges==0) {
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] isEqual:@"YES"]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                                    message:@"New badge unlocked!"
                                                                   delegate:self cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                }
                [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:9] :user.userUUID];
            }
        }
        
        // redirect to first screen
        
        TestRezultate * view = [[TestRezultate alloc] initWithNibName:@"TestRezultate" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:nil];
 
        
    }}

- (IBAction)renunta {
    
    [timer2 invalidate];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    int givenUpTimes = [standardDefaults integerForKey:@"givenUpTimes"];
    givenUpTimes++;
    [standardDefaults setInteger:givenUpTimes forKey:@"givenUpTimes"];
    [standardDefaults synchronize];
    
    if(givenUpTimes>10) {
        NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:12]];
        users = [DatabaseHelper selectUsers];
        User* user = [users objectAtIndex:0];
        int numberOfBadges = [badges count];
        if(numberOfBadges==0) {
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] isEqual:@"YES"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                                message:@"New badge unlocked!"
                                                               delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
            [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:12] :user.userUUID];
        }
    }
    
    // insert test results into db
    
    users = [DatabaseHelper selectUsers];
    
    User* user = [users objectAtIndex:0];
    
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
    NSString *dateString=[dateFormat stringFromDate:today];
    
    NSNumber *esteTest = [NSNumber numberWithInt:1];
    
    [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
    
    NSDate *today2=[NSDate date];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
    NSString *dateString2=[dateFormat2 stringFromDate:today2];
    
    [DatabaseHelper updateWorkout:dateString2];
    
    workouts = [DatabaseHelper selectWorkoutIsTest];
    
    Workout* workout = [workouts objectAtIndex:workouts.count-1];
    
    [DatabaseHelper insertWorkoutExercise:workout._id :@"Test" :user.userUUID :[NSNumber numberWithInt:repsNumber]];
    
    // reset values, stop music or other things
    
    repsNumber = 0;
    
    pauza = 0;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        [sharedPlayerAlertSound stop];
        [sharedPlayerAlertSound setCurrentTime:0];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
        [sharedPlayerMusicForTest stop];
        [sharedPlayerMusicForTest setCurrentTime:0];
    }

    TestRezultate * view = [[TestRezultate alloc] initWithNibName:@"TestRezultate" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (void)spinit:(NSTimer *)timer
{
    if (pauza == 0) {

            prog += 0.0167;
            if(prog >= 1.0) {
                prog = 1.0;
                [timer invalidate];
            }
        
    [[self spinnerView] setProgress:prog animated:YES];
        
    }
}

- (void)spinitB:(NSTimer *)timer
{
    if (pauza == 0) {
            
            prog -= 0.1;
            if(prog <= 0.0) {
                prog = 0.0;
                [timer invalidate];
            }
        
        [[self spinnerView] setProgress:prog animated:YES];
        
    }
}

- (void)sensorStateChange:(NSNotificationCenter *)notification
{
    if ( ([[UIDevice currentDevice] proximityState] == YES)&&(amInceput==1)&&(pauza==0))
        
        repsNumber++;
        nrFlotari.text = [NSString stringWithFormat:@"%i reps", repsNumber];
    
}

- (void)applicationWillEnterInBackGround {
    pauza = 1;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if(sharedPlayerAlertSound.isPlaying==YES)
            [sharedPlayerAlertSound pause];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
        NSLog(@"%f",sharedPlayerMusicForTest.currentTime);
        if(sharedPlayerMusicForTest.isPlaying==YES)
            [sharedPlayerMusicForTest pause];
    }
}

- (void)applicationWillEnterInForeground {
    pauza = 0;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if((sharedPlayerAlertSound.isPlaying==NO)&&(sharedPlayerAlertSound.currentTime!=0))
            [sharedPlayerAlertSound play];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
        NSLog(@"%f",sharedPlayerMusicForTest.currentTime);
            if((sharedPlayerMusicForTest.isPlaying==NO)&&(sharedPlayerMusicForTest.currentTime!=0))
                [sharedPlayerMusicForTest play];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer1 invalidate];
    [timer2 invalidate];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        [sharedPlayerAlertSound stop];
        [sharedPlayerAlertSound setCurrentTime:0];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForTest = [SharedAppDelegate bgMusicForTest];
        [sharedPlayerMusicForTest stop];
        [sharedPlayerMusicForTest setCurrentTime:0];
    }

}

@end
