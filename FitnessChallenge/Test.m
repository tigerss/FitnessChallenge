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

@interface Test ()

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;

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

BOOL amInceput=0, pauza;

int seconds2;

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
    [[UIImage imageNamed:@"testBG.png"] drawInRect:self.view.bounds];
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
    
    [self setupCountdown];
    
}

- (void)setupCountdown {
    
    seconds2 = 5;
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(subtractTime2)
                                            userInfo:nil
                                             repeats:YES];
    
}

- (void)subtractTime2 {
    
    seconds2--;
    countdown.text = [NSString stringWithFormat:@"%i", seconds2];
    
    if (seconds2==0) {
        
        [timer1 invalidate];
        
        [countdown setHidden:TRUE];
        
        [buton setHidden:FALSE];
        
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
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (IBAction)buttonPressed {

    if([buton.titleLabel.text isEqualToString:@"| |"]){
        
        pauza=1;
        
        [buton setTitle:@">" forState:UIControlStateNormal];
        
    }
    
    else if([buton.titleLabel.text isEqualToString:@">"]) {
        
        pauza=0;
        
        [buton setTitle:@"| |" forState:UIControlStateNormal];
        
    }
    

}

- (void)umpleCerc {
    
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
        
        [buton setEnabled:NO];
        
        [buton setHidden:TRUE];
        
    }
        
    }
    
    else if(pauza==1){
        
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        
    }
}

- (void)spinit:(NSTimer *)timer
{
    if (pauza == 0) {
        
    static float prog = 0.0;
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
