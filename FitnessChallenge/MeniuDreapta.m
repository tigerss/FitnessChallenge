//
//  Antrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreapta.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "FitnessChallenge.h"
#import "Autentificare.h"
#import "InregistrareCont.h"

@interface MeniuDreapta () <FBLoginViewDelegate>
@end

@implementation MeniuDreapta

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!(FBSession.activeSession.isOpen)) {
        FBLoginView *loginview = [[FBLoginView alloc] init];
        loginview.frame = CGRectOffset(loginview.frame, 50, 270);
        loginview.delegate = self;
        [self.view addSubview:loginview];
        [loginview sizeToFit];
    }
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)auth {
    
        Autentificare * view = [[Autentificare alloc] initWithNibName:@"Autentificare" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)inregCont {
    
        InregistrareCont * view = [[InregistrareCont alloc] initWithNibName:@"InregistrareCont" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissThisView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
