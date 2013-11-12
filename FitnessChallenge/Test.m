//
//  Test.m
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Test.h"
#import "ECSlidingViewController.h"
#import "STKSpinnerView.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"
#import <QuartzCore/QuartzCore.h>

@interface Test ()

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;

@end

@implementation Test

BOOL amInceput=0, pauza;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeniuStanga class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuStanga"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MeniuDreapta class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuDreapta"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // Enabled monitoring of the sensor
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    // Set up an observer for proximity changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_antrenament.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    countdown.layer.shadowRadius = 2.0;
    countdown.layer.shadowOpacity = 0.8;
    countdown.layer.masksToBounds = NO;
    
    nrFlotari.layer.shadowRadius = 5.0;
    nrFlotari.layer.shadowOpacity = 0.5;
    nrFlotari.layer.masksToBounds = NO;
    
    secunde.layer.shadowRadius = 2.0;
    secunde.layer.shadowOpacity = 0.8;
    secunde.layer.masksToBounds = NO;
    
    [self setupCountdown];
    
}

- (void)setupCountdown {
    
    seconds2 = 10;
    
    countdown.text = [NSString stringWithFormat:@"%i", seconds2];
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(subtractTime2)
                                            userInfo:nil
                                             repeats:YES];
    
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
    nrFlotari.text = [NSString stringWithFormat:@"%i flotari", count];
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (IBAction)buttonPressed {
    
    if ([butonPauzaStart.titleLabel.text isEqualToString:@"pauza"]) {
        
        pauza = 1;
        
        UIImage *bI = [UIImage imageNamed:@"continue.png"];
        UIImage *bISel = [UIImage imageNamed:@"continue_selected.png"];
        
        [butonPauzaStart setTitle:@"start" forState:UIControlStateNormal];
        
        [butonPauzaStart setBackgroundImage:bI forState:UIControlStateNormal];
        
        [butonPauzaStart setBackgroundImage:bISel forState:UIControlStateHighlighted];
        
    }
    
    else if ([butonPauzaStart.titleLabel.text isEqualToString:@"start"]) {
        
        pauza = 0;
        
        UIImage *bI1 = [UIImage imageNamed:@"pause.png"];
        UIImage *bISel1 = [UIImage imageNamed:@"pause_selected.png"];
        
        [butonPauzaStart setTitle:@"pauza" forState:UIControlStateNormal];
        
        [butonPauzaStart setBackgroundImage:bI1 forState:UIControlStateNormal];
        
        [butonPauzaStart setBackgroundImage:bISel1 forState:UIControlStateHighlighted];
        
    }
    

}

- (void)umpleCerc {
    
    prog = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
    
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
        
        [butonRenunta setEnabled:NO];
        
        [butonRenunta setHidden:TRUE];
        
        [butonPauzaStart setEnabled:NO];
        
        [butonPauzaStart setHidden:TRUE];
        
    }
        
    }
    
    else if(pauza==1){
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Inregistrare"];
        
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
 
        
    }}

- (IBAction)renunta {
    
    [timer2 invalidate];
    
    count = 0;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];

    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Inregistrare"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
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

- (IBAction)revealMenuLeft:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (IBAction)revealMenuRight:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
