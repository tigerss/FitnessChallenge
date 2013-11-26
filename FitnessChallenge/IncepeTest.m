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
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"
#import "MeniuDreaptaRegUsr.h"

@interface IncepeTest ()

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation IncepeTest

BOOL amInceput=0, pauza;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
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

- (IBAction)pushUserDetails {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userLvl = [standardDefaults stringForKey:@"userLevel"];
    
    if([userLvl isEqualToString:@"1"]) {
        
        MeniuDreaptaRegUsr *modal = [[MeniuDreaptaRegUsr alloc] initWithNibName:@"MeniuDreaptaRegUsr" bundle:nil];
        modal.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:modal animated:YES completion:nil];
        
    }
    
    else {
        
        MeniuDreapta *modal = [[MeniuDreapta alloc] initWithNibName:@"MeniuDreapta" bundle:nil];
        modal.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:modal animated:YES completion:nil];
        
    }
    
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
    
    if (seconds2==0) {
        
        [timer1 invalidate];
        
        [countdown setHidden:TRUE];
        
        [secunde setHidden:FALSE];
        
        [self setupPushups];
        
        [self umpleCerc];
        
    }
    
}


- (void)setupPushups {
    
    seconds = 60;
    count = 0;
    amInceput = 1;
    
    secunde.text = [NSString stringWithFormat:@"%i", seconds];
    nrFlotari.text = [NSString stringWithFormat:@"%i reps", count];
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (IBAction)buttonPressed {
    
    if ([butonPauzaStart.titleLabel.text isEqualToString:@"pause"]) {
        
        pauza = 1;
        
        [butonPauzaStart setTitle:@"resume" forState:UIControlStateNormal];
        
    }
    
    else if ([butonPauzaStart.titleLabel.text isEqualToString:@"resume"]) {
        
        pauza = 0;
        
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
    
    if (seconds == 0) {
        
        [timer2 invalidate];
        
        secunde.text = [NSString stringWithFormat:@":)"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Timpul a expirat!"
                                                        message:[NSString stringWithFormat:@"Ai efectuat %i flotari", count]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
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
        
        TestRezultate * view = [[TestRezultate alloc] initWithNibName:@"TestRezultate" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:nil];
 
        
    }}

- (IBAction)renunta {
    
    [timer2 invalidate];
    
    count = 0;
    
    pauza = 0;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];

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
        
        count++;
        nrFlotari.text = [NSString stringWithFormat:@"%i flotari", count];
    
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
}

@end
