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

@interface MeniuDreapta ()

@end

@implementation MeniuDreapta

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
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
