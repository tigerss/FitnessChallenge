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
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    users = [DatabaseHelper selectUsers];
    
    User* user = [users objectAtIndex:0];
    
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
    NSString *dateString=[dateFormat stringFromDate:today];
    
    NSNumber *esteTest = [NSNumber numberWithInt:1];
    
    [DatabaseHelper insertWorkout:dateString :nil :esteTest :user.userUUID];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
    
    NSURL *urlAlertSound = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"321"
                                         ofType:@"wav"]];
        
    NSError *error;
        
    _alertSound = [[AVAudioPlayer alloc]
                    initWithContentsOfURL:urlAlertSound
                    error:&error];
    
    _alertSound.delegate = self;
    [_alertSound prepareToPlay];
    [_alertSound setVolume: 1.0];
        
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
    
    NSURL *urlBgMusic = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:@"test"
                                                ofType:@"mp3"]];
    
    NSError *error;
    
    _bgMusic = [[AVAudioPlayer alloc]
                initWithContentsOfURL:urlBgMusic
                error:&error];
    
    _bgMusic.delegate = self;
    [_bgMusic prepareToPlay];
    [_bgMusic setVolume: 1.0];
        
    }
    
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
            
            [_alertSound play];
            
        }
        
    }
    
    if (seconds2==0) {
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
        {
            
            bgMusic = 1;
        
            [_bgMusic play];
            
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
        
            if(bgMusic == 1)
                [_bgMusic pause];
            
        }
        
        [butonPauzaStart setTitle:@"resume" forState:UIControlStateNormal];
        
    }
    
    else if ([butonPauzaStart.titleLabel.text isEqualToString:@"resume"]) {
        
        pauza = 0;
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
            
            if(bgMusic == 1)
                [_bgMusic play];
            
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
            
                [_alertSound play];
            
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
                [_bgMusic play];
            
        }
            
    }
    
    if (seconds == 0) {
        
        [timer2 invalidate];
        
        bgMusic = 0;
        
        [butonPauzaStart setEnabled:YES];
        
        secunde.text = [NSString stringWithFormat:@":)"];
        
        if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
            
            [_alertSound stop];
            [_bgMusic stop];
            
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
        
        //insert workout results into db
        
        NSDate *today2=[NSDate date];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
        NSString *dateString2=[dateFormat2 stringFromDate:today2];
        
        [DatabaseHelper updateWorkout:dateString2];
        
        workouts = [DatabaseHelper selectWorkout];
        
        Workout* workout = [workouts objectAtIndex:workouts.count-1];
        
        User* user = [users objectAtIndex:0];
        
        [DatabaseHelper insertWorkoutExercise:workout._id :@"Test" :user.userUUID :[NSNumber numberWithInt:repsNumber]];
        
        NSLog(@"Inserted: %@ %@ %i", workout._id, user.userUUID, repsNumber);
        
        // redirect to first screen
        
        TestRezultate * view = [[TestRezultate alloc] initWithNibName:@"TestRezultate" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:nil];
 
        
    }}

- (IBAction)renunta {
    
    [timer2 invalidate];
    
    NSDate *today2=[NSDate date];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"YYYY-MM-dd 'at' HH:mm"];
    NSString *dateString2=[dateFormat2 stringFromDate:today2];
    
    [DatabaseHelper updateWorkout:dateString2];
    
    workouts = [DatabaseHelper selectWorkout];
    
    Workout* workout = [workouts objectAtIndex:workouts.count-1];
    
    User* user = [users objectAtIndex:0];
    
    [DatabaseHelper insertWorkoutExercise:workout._id :@"Test" :user.userUUID :[NSNumber numberWithInt:repsNumber]];
    
    NSLog(@"Inserted: %@ %@ %i", workout._id, user.userUUID, repsNumber);
    
    repsNumber = 0;
    
    pauza = 0;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
        
        [_alertSound stop];
        [_bgMusic stop];
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer1 invalidate];
    [timer2 invalidate];
    
    if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])||([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])) {
        
        [_alertSound stop];
        [_bgMusic stop];
        
    }
}

@end
