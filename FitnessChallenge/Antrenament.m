//
//  Antrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Antrenament.h"
#import "ECSlidingViewController.h"
#import "STKSpinnerView.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"
#import <QuartzCore/QuartzCore.h>

@interface Antrenament ()

@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;

@end

@implementation Antrenament

BOOL amInceputAntrenament=0, pauza;
int antrenamentNo=0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // design break
    
    p1.clipsToBounds = YES;
    p1.layer.cornerRadius = 10.0f;
    p2.clipsToBounds = YES;
    p2.layer.cornerRadius = 10.0f;
    p3.clipsToBounds = YES;
    p3.layer.cornerRadius = 10.0f;
    p4.clipsToBounds = YES;
    p4.layer.cornerRadius = 10.0f;
    
    // design break
    
    p5.clipsToBounds = YES;
    p5.layer.cornerRadius = 10.0f;
    p6.clipsToBounds = YES;
    p6.layer.cornerRadius = 10.0f;
    p7.clipsToBounds = YES;
    p7.layer.cornerRadius = 10.0f;
    p8.clipsToBounds = YES;
    p8.layer.cornerRadius = 10.0f;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeniuStanga class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuStanga"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MeniuDreapta class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuDreapta"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_antrenament.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    countdown.layer.shadowRadius = 2.0;
    countdown.layer.shadowOpacity = 0.8;
    countdown.layer.masksToBounds = NO;
    
    secunde.layer.shadowRadius = 2.0;
    secunde.layer.shadowOpacity = 0.8;
    secunde.layer.masksToBounds = NO;
    
    [self setupCountdown];
    
}

- (void)setupCountdown {
    
    antrenamentNo++;
    
    if (antrenamentNo==1)
        
        p1.backgroundColor = [UIColor brownColor];
        
    else if (antrenamentNo==2)
    {
        
        p1.backgroundColor = [UIColor blackColor];
        p2.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==3)
    {
        
        p2.backgroundColor = [UIColor blackColor];
        p3.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==4)
    {
        
        p3.backgroundColor = [UIColor blackColor];
        p4.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==5)
    {
        
        p4.backgroundColor = [UIColor blackColor];
        p5.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==6)
    {
        
        p5.backgroundColor = [UIColor blackColor];
        p6.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==7)
    {
        
        p6.backgroundColor = [UIColor blackColor];
        p7.backgroundColor = [UIColor brownColor];
        
    }
    
    else if (antrenamentNo==8)
    {
        
        p7.backgroundColor = [UIColor blackColor];
        p8.backgroundColor = [UIColor brownColor];
        
    }
    
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
    
    timer0 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(spinit) userInfo:nil repeats:YES];
    
}

- (void)subtractTime {
    
    if(pauza==0) {

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
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        if(antrenamentNo<8) {
        
        [countdown setHidden:FALSE];
        
        [secunde setHidden:TRUE];
        
        [[self spinnerView] setProgress:0.0 animated:YES];
        
        [self setupCountdown];
            
        }
        
        else {
            
            antrenamentNo=0;
            
            UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Ecran principal"];
            
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
            
        }
        
    }}

- (IBAction)renunta {
    
    if (seconds2!=0)
        
        [timer1 invalidate];
    
    if (seconds!=0)
        
        [timer2 invalidate];
    
    antrenamentNo=0;
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Ecran principal"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
}

- (IBAction)sariPesteEx {
    
    if (seconds2!=0)
        
        [timer1 invalidate];
    
    if (seconds!=0)
        
        [timer2 invalidate];
    
    [timer0 invalidate];
    
    if(antrenamentNo<8) {
        
        [countdown setHidden:FALSE];
        
        [secunde setHidden:TRUE];
        
        [[self spinnerView] setProgress:0.0 animated:YES];
        
        [self setupCountdown];
        
    }
    
    else {
        
        antrenamentNo=0;
        
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Ecran principal"];
        
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
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
