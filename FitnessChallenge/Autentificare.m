//
//  Autentificare.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
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
    
    tw1.clipsToBounds = YES;
    tw1.layer.cornerRadius = 5.0f;
    
    tw2.clipsToBounds = YES;
    tw2.layer.cornerRadius = 5.0f;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)butonApasat {
    
    UIViewController *newTopViewController;
    
    newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
}

- (IBAction)autentificare {
    
    if (([email.text isEqualToString:@"demo"])&&([pass.text isEqualToString:@"fitnesschallenge"])) {
        
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
        
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
    }
    
    else if (([email.text isEqualToString:@""])||([pass.text isEqualToString:@""])) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                        message:[NSString stringWithFormat:@"Nu ai completat adresa de mail si/sau parola!"]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    else if (!(([email.text isEqualToString:@"demo"])&&([pass.text isEqualToString:@"fitnesschallenge"]))) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                        message:[NSString stringWithFormat:@"Ai gresit adresa de mail si/sau parola!"]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
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

