//
//  Test.m
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Test.h"
#import "ECSlidingViewController.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"

@interface Test ()

@end

@implementation Test

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

BOOL amInceput=0, pauza, clicked=0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Enabled monitoring of the sensor
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    // Set up an observer for proximity changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_test.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeniuStanga class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuStanga"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MeniuDreapta class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuDreapta"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];

    
}

- (void)setupPushups {
    
    clicked = 1;
    seconds = 60;
    count = 0;
    amInceput = 1;
    
    secunde.text = [NSString stringWithFormat:@"%i", seconds];
    flotari.text = [NSString stringWithFormat:@"%i", count];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)subtractTime {
    
    if(pauza==0) {
        
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    seconds--;
    secunde.text = [NSString stringWithFormat:@"%i",seconds];
    
    if (seconds == 0) {
        [timer invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Timpul a expirat!"
                                                        message:[NSString stringWithFormat:@"Ai efectuat %i flotari", count]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        [buton setEnabled:NO];
    }
        
    }
    
    else if(pauza==1){
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
}

- (void)sensorStateChange:(NSNotificationCenter *)notification
{
    if ( ([[UIDevice currentDevice] proximityState] == YES)&&(amInceput==1)&&(pauza==0)) {
        
        count++;
    
        flotari.text = [NSString stringWithFormat:@"%i", count];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed {
    
    if(clicked == 0)
        
        [self setupPushups];
    
    if([buton.titleLabel.text isEqualToString:@"PAUZA"]){
        
        pauza=1;
        
        [buton setTitle:@"START" forState:UIControlStateNormal];
        
    }
    
    else if([buton.titleLabel.text isEqualToString:@"START"]) {
        
        pauza=0;
    
        [buton setTitle:@"PAUZA" forState:UIControlStateNormal];
        
    }
    
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
