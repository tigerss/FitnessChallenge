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
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "MeniuDreaptaRegUsr.h"

@interface IncepeAntrenament ()

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation IncepeAntrenament

BOOL amInceputAntrenament=0, pauza;
int antrenamentNo=0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
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
    
    antrenamentNo++;
    
    if (antrenamentNo==1) {
        
        progressBar.progress = 0.125;
        exercise.text = @"Burpees";
        
    }
    
    else if (antrenamentNo==2)
    {
        
        progressBar.progress = 0.250;
        exercise.text = @"Body Weight Squats";
        
    }
    
    else if (antrenamentNo==3)
    {
        
        progressBar.progress = 0.375;
        exercise.text = @"Jumping Jacks";
        
    }
    
    else if (antrenamentNo==4)
    {
        
        progressBar.progress = 0.500;
        exercise.text = @"Double Crunches";
        
    }
    
    else if (antrenamentNo==5)
    {
        
        progressBar.progress = 0.625;
        exercise.text = @"Burpees";
        
    }
    
    else if (antrenamentNo==6)
    {
        
        progressBar.progress = 0.750;
        exercise.text = @"Jumping Jacks";
        
    }
    
    else if (antrenamentNo==7)
    {
        
        progressBar.progress = 0.875;
        exercise.text = @"Body Weight Squats";
        
    }
    
    else if (antrenamentNo==8)
    {
        
        progressBar.progress = 1.000;
        exercise.text = @"Double Crunches";
        
    }
    
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
    
    seconds = 20;
    amInceputAntrenament = 1;
    
    secunde.text = [NSString stringWithFormat:@"%i", seconds];
    
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
    
    timer0 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinit) userInfo:nil repeats:YES];
    
}

- (void)golesteCerc {
    
    prog = 1.0;
    
    timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinitB) userInfo:nil repeats:YES];
    
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
                                                            message:[NSString stringWithFormat:@"Introdu mai jos numarul de repetari efectuate:"]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
            
        }
        
    }
    
    else if(pauza==1){
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        if(antrenamentNo<8) {
        
        [countdown setHidden:FALSE];
        
        [secunde setHidden:TRUE];
        
        [[self spinnerView] setProgress:1.0 animated:YES];
        
        [self setupCountdown];
            
        }
        
        else {
            
            antrenamentNo=0;
            
            AntrenamentRezultate * view = [[AntrenamentRezultate alloc] initWithNibName:@"AntrenamentRezultate" bundle:nil];
            view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:view animated:YES completion:nil];
            
        }
        
    }}

- (IBAction)renunta {
    
    if (seconds2!=0)
        
        [timer1 invalidate];
    
    if (seconds!=0)
        
        [timer2 invalidate];
    
    antrenamentNo=0;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    AntrenamentRezultate * view = [[AntrenamentRezultate alloc] initWithNibName:@"AntrenamentRezultate" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)sariPesteEx {
    
    if (seconds2!=0)
        
        [timer1 invalidate];
    
    if (seconds!=0)
        
        [timer2 invalidate];
    
    [timer0 invalidate];
    
    [timer3 invalidate];
    
    if(antrenamentNo<8) {
        
        [countdown setHidden:FALSE];
        
        [secunde setHidden:TRUE];
        
        [[self spinnerView] setProgress:1.0 animated:YES];
        
        [self setupCountdown];
        
    }
    
    else {
        
        antrenamentNo=0;
        
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

- (void)spinitB
{
    if (pauza == 0) {
        
        prog -= 0.1;
        if(prog <= 0.0) {
            prog = 0.0;
            [timer3 invalidate];
        }
        
        [[self spinnerView] setProgress:prog animated:YES];
        
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
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
}

@end
