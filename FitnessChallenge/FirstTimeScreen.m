//
//  FirstTimeScreen.m
//  FitnessChallenge
//
//  Created by Cristian on 1/12/14.
//  Copyright (c) 2014 C.A.D. All rights reserved.
//

#import "FirstTimeScreen.h"
#import "FitnessChallenge.h"
#import "Utils.h"
#import "Autentificare.h"

@interface FirstTimeScreen ()

@end

@implementation FirstTimeScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)firstTime {
    //create guest user account
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *user = [NSString stringWithFormat:@"guest%@", uuid];
    NSString *smallerUser = [user substringToIndex:13];
    NSString *dateString=[Utils dateToString];
    [DatabaseHelper insertUser: uuid: smallerUser: @"": @"": @"": dateString];
    
    //load default screen
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)notFirstTime {
    //load log in screen
    Autentificare * view = [[Autentificare alloc] initWithNibName:@"Autentificare" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
