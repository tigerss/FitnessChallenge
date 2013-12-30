//
//  IncepeAntrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "IncepeAntrenament.h"
#import "STKSpinnerView.h"
#import <QuartzCore/QuartzCore.h>
#import "FitnessChallenge.h"
#import "AntrenamentRezultate.h"
#import "Autentificare.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "Challenges.h"

@interface IncepeAntrenament () {
    
    NSArray* users;
    NSArray* workouts;
    
}

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) NSArray *workoutExercices;

@end

@implementation IncepeAntrenament

@synthesize workoutExercices;

BOOL amInceputAntrenament=0, pauza, bgMusicWorkout=1;
int antrenamentNo=1,badgesEarnedWorkout;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    badgesEarnedWorkout = 0;
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:2];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"insertedAlready"] == nil) {
        
        [standardDefaults setObject:@"NO" forKey:@"insertedAlready"];
        [standardDefaults synchronize];
        
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterInBackGround) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterInForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    if (antrenamentNo==1) {
        
        progressBar.progress = 0.125;
        exerciseName.text = @"Jumping Jacks";
        
    }
    
    else if (antrenamentNo==2)
    {
        
        progressBar.progress = 0.250;
        exerciseName.text = @"Mountain Climbers";
        
    }
    
    else if (antrenamentNo==3)
    {
        
        progressBar.progress = 0.375;
        exerciseName.text = @"Planks (With Rotation)";
        
    }
    
    else if (antrenamentNo==4)
    {
        
        progressBar.progress = 0.500;
        exerciseName.text = @"Triceps Dips";
        
    }
    
    else if (antrenamentNo==5)
    {
        
        progressBar.progress = 0.625;
        exerciseName.text = @"Burpees";
        
    }
    
    else if (antrenamentNo==6)
    {
        
        progressBar.progress = 0.750;
        exerciseName.text = @"Bodyweight Squats";
        
    }
    
    else if (antrenamentNo==7)
    {
        
        progressBar.progress = 0.875;
        exerciseName.text = @"High Knee Drills";
        
    }
    
    else if (antrenamentNo==8)
    {
        
        progressBar.progress = 1.000;
        exerciseName.text = @"Double Crunches";
        
    }
    
    [self setupPushups];
    [self fillCircle];
    
}

- (void)setupPushups {
    
    seconds = 20;
    amInceputAntrenament = 1;
    
    secunde.text = [NSString stringWithFormat:@"%i", seconds];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(subtractTime)
                                            userInfo:nil
                                             repeats:YES];
}

- (IBAction)buttonPressed {
    
    if ([butonPauzaStart.titleLabel.text isEqualToString:@"pause"]) {
        
        pauza = 1;
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
            
            if(bgMusicWorkout == 1) {
                AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
                [sharedPlayerMusicForWorkout pause];
            }
            
        }
        
        [butonPauzaStart setTitle:@"resume" forState:UIControlStateNormal];
        
    }
    
    else if ([butonPauzaStart.titleLabel.text isEqualToString:@"resume"]) {
        
        pauza = 0;
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
            
            if(bgMusicWorkout == 1) {
                AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
                [sharedPlayerMusicForWorkout play];
            }
            
        }
        
        [butonPauzaStart setTitle:@"pause" forState:UIControlStateNormal];
        
    }
    
    
}

- (void)fillCircle {
    
    prog = 0.0;
    
    timer0 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinit) userInfo:nil repeats:YES];
    
}

- (void)subtractTime {
    
    if(pauza==0) {
        
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
            
            [timer invalidate];
            
            [butonPauzaStart setEnabled:YES];
            
            secunde.text = [NSString stringWithFormat:@":)"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time's up !"
                                                            message:[NSString stringWithFormat:@"Please enter your number of reps:"]
                                                           delegate:self
                                                  cancelButtonTitle:@"Continue"
                                                  otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            alert.tag = 1;
            [alert show];
            
        }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1) {
    if (buttonIndex == 0) {
        
        if(antrenamentNo<8) {
            
            //insert workout results into db
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"insertedAlready"] isEqual:@"NO"]) {
                
                NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                
                users = [DatabaseHelper selectUsers];
                
                User* user = [users objectAtIndex:0];
                
                NSDate *today=[NSDate date];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
                NSString *dateString=[dateFormat stringFromDate:today];
                
                NSNumber *esteTest = [NSNumber numberWithInt:0];
                
                [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
                
                [standardDefaults setObject:@"YES" forKey:@"insertedAlready"];
                [standardDefaults synchronize];
                
            }
            
            NSDate *today2=[NSDate date];
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
            NSString *dateString2=[dateFormat2 stringFromDate:today2];
            
            self.workoutExercices = [NSArray arrayWithObjects:
                                     @"Jumping Jacks",
                                     @"Mountain Climbers",
                                     @"Planks (With Rotation)",
                                     @"Triceps Dips",
                                     @"Burpees",
                                     @"Bodyweight Squats",
                                     @"High Knee Drills",
                                     @"Double Crunches",
                                     nil];
            
            [DatabaseHelper updateWorkout:dateString2];
            
            users = [DatabaseHelper selectUsers];
            
            User* user = [users objectAtIndex:0];
            
            workouts = [DatabaseHelper selectWorkoutIsNotTest];
            
            Workout* workout = [workouts objectAtIndex:workouts.count-1];
            
            int repsNr = [[[alertView textFieldAtIndex:0] text] integerValue];
            
            [DatabaseHelper insertWorkoutExercise:workout._id :[NSString stringWithFormat:@"%@", [self.workoutExercices objectAtIndex:antrenamentNo-1]] :user.userUUID :[NSNumber numberWithInt:repsNr]];
            
            // check if user earned a new badge
            if(repsNr>15) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:antrenamentNo]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:antrenamentNo] :user.userUUID];
                }
            }
            
            int userScore=0;
            workouts = [DatabaseHelper selectWorkoutExercises];
            for(WorkoutExercise *wT in workouts)
                userScore+=wT.numberOfReps;
            
            if(userScore>175) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:10]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:10] :user.userUUID];
                }
            }
            
            if(repsNr>50) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:11]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:11] :user.userUUID];
                }
            }
            
            if(badgesEarnedWorkout>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                            message:[NSString stringWithFormat:@"You have earned %d new badge(s) !",badgesEarnedWorkout]
                                                           delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 2;
            [alert show];
            }
            
            // reset progress and prepare for next exercise
        
            [[self spinnerView] setProgress:1.0 animated:YES];
        
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            
            [standardDefaults setInteger:antrenamentNo+1 forKey:@"currentEx"];
            [standardDefaults setObject:@"YES" forKey:@"currentExIsSet"];
            [standardDefaults synchronize];
            
            antrenamentNo++;
            
            [self setupCountdown];
            
            Antrenament * view = [[Antrenament alloc] initWithNibName:@"Antrenament" bundle:nil];
            view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:view animated:YES completion:nil];
            
        }
        
        else if(antrenamentNo==8) {
            
            //insert workout results into db
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"insertedAlready"] isEqual:@"NO"]) {
                
                NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                
                users = [DatabaseHelper selectUsers];
                
                User* user = [users objectAtIndex:0];
                
                NSDate *today=[NSDate date];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
                NSString *dateString=[dateFormat stringFromDate:today];
                
                NSNumber *esteTest = [NSNumber numberWithInt:0];
                
                [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
                
                [standardDefaults setObject:@"YES" forKey:@"insertedAlready"];
                [standardDefaults synchronize];
                
            }
            
            NSDate *today2=[NSDate date];
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
            NSString *dateString2=[dateFormat2 stringFromDate:today2];
            
            self.workoutExercices = [NSArray arrayWithObjects:
                                     @"Jumping Jacks",
                                     @"Mountain Climbers",
                                     @"Planks (With Rotation)",
                                     @"Triceps Dips",
                                     @"Burpees",
                                     @"Bodyweight Squats",
                                     @"High Knee Drills",
                                     @"Double Crunches",
                                     nil];
            
            [DatabaseHelper updateWorkout:dateString2];
            
            workouts = [DatabaseHelper selectWorkoutIsNotTest];
            
            Workout* workout = [workouts objectAtIndex:workouts.count-1];
            
            users = [DatabaseHelper selectUsers];
            
            User* user = [users objectAtIndex:0];
            
            int repsNr = [[[alertView textFieldAtIndex:0] text] integerValue];
            
            [DatabaseHelper insertWorkoutExercise:workout._id :[NSString stringWithFormat:@"%@", [self.workoutExercices objectAtIndex:antrenamentNo-1]] :user.userUUID :[NSNumber numberWithInt:repsNr]];
            
            // check if user earned a new badge
            if(repsNr>15) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:antrenamentNo]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:antrenamentNo] :user.userUUID];
                }
            }
            
            int userScore=0;
            workouts = [DatabaseHelper selectWorkoutExercises];
            for(WorkoutExercise *wT in workouts)
                userScore+=wT.numberOfReps;
            
            if(userScore>175) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:10]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:10] :user.userUUID];
                }
            }
            
            if(repsNr>50) {
                NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:11]];
                users = [DatabaseHelper selectUsers];
                User* user = [users objectAtIndex:0];
                int numberOfBadges = [badges count];
                if(numberOfBadges==0) {
                    badgesEarnedWorkout++;
                    [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:11] :user.userUUID];
                }
            }
            
            if(badgesEarnedWorkout>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                            message:[NSString stringWithFormat:@"You have earned %d new badge(s) !",badgesEarnedWorkout]
                                                           delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
            }
            
            antrenamentNo=1;
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
                AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
                [sharedPlayerAlertSound stop];
                [sharedPlayerAlertSound setCurrentTime:0];
            }
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
                AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
                [sharedPlayerMusicForWorkout stop];
                [sharedPlayerMusicForWorkout setCurrentTime:0];
            }
        
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        
            [standardDefaults setInteger:1 forKey:@"currentEx"];
            [standardDefaults setObject:@"NO" forKey:@"currentExIsSet"];
            [standardDefaults setObject:nil forKey:@"insertedAlready"];
            [standardDefaults synchronize];
        
            AntrenamentRezultate * view = [[AntrenamentRezultate alloc] initWithNibName:@"AntrenamentRezultate" bundle:nil];
            view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:view animated:YES completion:nil];

            
        }
    }
        
    }}

- (IBAction)renunta {
    
    if (seconds!=0)
        
        [timer invalidate];
    
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
            badgesEarnedWorkout++;
            [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:12] :user.userUUID];
        }
    }
    
    if(badgesEarnedWorkout>0) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                    message:[NSString stringWithFormat:@"You have earned %d new badge(s) !",badgesEarnedWorkout]
                                                   delegate:self cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    alert.tag = 4;
    [alert show];
    }
    
    if(antrenamentNo<=8) {
        
        //insert workout results into db
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"insertedAlready"] isEqual:@"NO"]) {
            
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            
            users = [DatabaseHelper selectUsers];
            
            User* user = [users objectAtIndex:0];
            
            NSDate *today=[NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
            NSString *dateString=[dateFormat stringFromDate:today];
            
            NSNumber *esteTest = [NSNumber numberWithInt:0];
            
            [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
            
            [standardDefaults setObject:@"YES" forKey:@"insertedAlready"];
            [standardDefaults synchronize];
            
        }
        
        NSDate *today2=[NSDate date];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
        NSString *dateString2=[dateFormat2 stringFromDate:today2];
        
        [DatabaseHelper updateWorkout:dateString2];
        
        workouts = [DatabaseHelper selectWorkoutIsNotTest];
        
        Workout* workout = [workouts objectAtIndex:workouts.count-1];
        
        users = [DatabaseHelper selectUsers];
        
        User* user = [users objectAtIndex:0];
        
        self.workoutExercices = [NSArray arrayWithObjects:
                                 @"Jumping Jacks",
                                 @"Mountain Climbers",
                                 @"Planks (With Rotation)",
                                 @"Triceps Dips",
                                 @"Burpees",
                                 @"Bodyweight Squats",
                                 @"High Knee Drills",
                                 @"Double Crunches",
                                 nil];
        
        for (int i=antrenamentNo; i <=8; i++ ) {
        
        [DatabaseHelper insertWorkoutExercise:workout._id :[NSString stringWithFormat:@"%@", [self.workoutExercices objectAtIndex:i-1]] :user.userUUID :0];
            
        }
        
    }
    
    antrenamentNo=1;
    
    count = 0;
    
    pauza = 0;
    
    [standardDefaults setInteger:1 forKey:@"currentEx"];
    [standardDefaults setObject:@"NO" forKey:@"currentExIsSet"];
    [standardDefaults setObject:nil forKey:@"insertedAlready"];
    [standardDefaults synchronize];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        [sharedPlayerAlertSound stop];
        [sharedPlayerAlertSound setCurrentTime:0];
    }

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
        [sharedPlayerMusicForWorkout stop];
        [sharedPlayerMusicForWorkout setCurrentTime:0];
    }
    
    AntrenamentRezultate * view = [[AntrenamentRezultate alloc] initWithNibName:@"AntrenamentRezultate" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)sariPesteEx {
    
    if (seconds!=0)
        
        [timer invalidate];
    
    [timer0 invalidate];
    
    if(antrenamentNo<=8) {
    
    //insert workout results into db
        
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"insertedAlready"] isEqual:@"NO"]) {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        
        users = [DatabaseHelper selectUsers];
        
        User* user = [users objectAtIndex:0];
        
        NSDate *today=[NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
        NSString *dateString=[dateFormat stringFromDate:today];
        
        NSNumber *esteTest = [NSNumber numberWithInt:0];
        
        [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
        
        [standardDefaults setObject:@"YES" forKey:@"insertedAlready"];
        [standardDefaults synchronize];
        
    }
    
    NSDate *today2=[NSDate date];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
    NSString *dateString2=[dateFormat2 stringFromDate:today2];
    
    [DatabaseHelper updateWorkout:dateString2];
    
    workouts = [DatabaseHelper selectWorkoutIsNotTest];
    
    Workout* workout = [workouts objectAtIndex:workouts.count-1];
        
    users = [DatabaseHelper selectUsers];
    
    User* user = [users objectAtIndex:0];
        
    self.workoutExercices = [NSArray arrayWithObjects:
                             @"Jumping Jacks",
                             @"Mountain Climbers",
                             @"Planks (With Rotation)",
                             @"Triceps Dips",
                             @"Burpees",
                             @"Bodyweight Squats",
                             @"High Knee Drills",
                             @"Double Crunches",
                             nil];
    
    [DatabaseHelper insertWorkoutExercise:workout._id :[NSString stringWithFormat:@"%@", [self.workoutExercices objectAtIndex:antrenamentNo-1]] :user.userUUID :0];
        
    }
    
    if(antrenamentNo<8) {
        
        [countdown setHidden:FALSE];
        
        [secunde setHidden:TRUE];
        
        [[self spinnerView] setProgress:1.0 animated:YES];
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        
        [standardDefaults setInteger:antrenamentNo+1 forKey:@"currentEx"];
        [standardDefaults setObject:@"YES" forKey:@"currentExIsSet"];
        [standardDefaults synchronize];
        
        antrenamentNo++;
        
        [self setupCountdown];
        
        Antrenament * view = [[Antrenament alloc] initWithNibName:@"Antrenament" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];

        
    }
    
    else {
        
        antrenamentNo=1;
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
            [sharedPlayerAlertSound stop];
            [sharedPlayerAlertSound setCurrentTime:0];
        }
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
            AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
            [sharedPlayerMusicForWorkout stop];
            [sharedPlayerMusicForWorkout setCurrentTime:0];
        }
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        
        [standardDefaults setInteger:1 forKey:@"currentEx"];
        [standardDefaults setObject:@"NO" forKey:@"currentExIsSet"];
        [standardDefaults setObject:nil forKey:@"insertedAlready"];
        [standardDefaults synchronize];
        
        AntrenamentRezultate * view = [[AntrenamentRezultate alloc] initWithNibName:@"AntrenamentRezultate" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:nil];
        
    }
    
}

- (void)spinit
{
    if (pauza == 0) {
        
        prog += 0.05;
        if(prog >= 1.0) {
            prog = 1.0;
            [timer0 invalidate];
        }
        
        [[self spinnerView] setProgress:prog animated:YES];
        
    }
}

- (void)applicationWillEnterInBackGround {
    pauza = 1;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if(sharedPlayerAlertSound.isPlaying==YES)
            [sharedPlayerAlertSound pause];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
        NSLog(@"%f",sharedPlayerMusicForWorkout.currentTime);
        if(sharedPlayerMusicForWorkout.isPlaying==YES)
            [sharedPlayerMusicForWorkout pause];
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
        AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
        NSLog(@"%f",sharedPlayerMusicForWorkout.currentTime);
        if((sharedPlayerMusicForWorkout.isPlaying==NO)&&(sharedPlayerMusicForWorkout.currentTime!=0))
            [sharedPlayerMusicForWorkout play];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer0 invalidate];
    [timer invalidate];
}

@end
