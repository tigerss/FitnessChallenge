//
//  Autentificare.m
//  FitnessChallenge
//
//  Created by Cristian on 11/12/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Autentificare.h"
#import "ECSlidingViewController.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"

@interface Autentificare ()

@end

@implementation Autentificare

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    butonAutentificare.layer.cornerRadius = 5;
    butonAutentificare.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"autentificare.png"] drawInRect:self.view.bounds];
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
    
    [self->campNume becomeFirstResponder];
    
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
