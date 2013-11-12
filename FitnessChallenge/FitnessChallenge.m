//
//  FitnessChallenge.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessChallenge.h"
#import "ECSlidingViewController.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"

@interface FitnessChallenge ()

@end

@implementation FitnessChallenge

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!(FBSession.activeSession.isOpen)) {
        
        [buton1 setEnabled:NO];
        
        [buton3 setEnabled:NO];
        
    }
    else {
        
        [buton1 setEnabled:YES];
        
        [buton3 setEnabled:YES];
        
    }
    
    buton1.layer.cornerRadius = 5;
    buton1.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    buton2.layer.cornerRadius = 5;
    buton2.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    buton3.layer.cornerRadius = 5;
    buton3.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    tvOne.layer.cornerRadius = 5;
    
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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_autentificare.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

- (IBAction)butonApasat {
    
    UIViewController *newTopViewController;
    
    newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
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

