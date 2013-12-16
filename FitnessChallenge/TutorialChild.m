//
//  APPChildViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "TutorialChild.h"
#import "FitnessChallenge.h"
#import "InregistrareCont.h"

@interface TutorialChild ()

@end

@implementation TutorialChild

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    btn1.clipsToBounds = YES;
    btn1.layer.cornerRadius = 5.0f;
    btn2.clipsToBounds = YES;
    btn2.layer.cornerRadius = 5.0f;
    btn3.clipsToBounds = YES;
    btn3.layer.cornerRadius = 5.0f;
    
    if(self.index==0) {
        screenNumber.text = [NSString stringWithFormat:@"Step 1"];
        UIImage *img = [UIImage imageNamed: @"step1.png"];
        [image setImage:img];
        description.text = [NSString stringWithFormat:@"Get started as guest user, register an account or connect with Facebook. Simple as that."];
        [btn1 setHidden:NO];
        [btn2 setHidden:NO];
        [btn3 setHidden:YES];
    }
    if(self.index==1) {
        screenNumber.text = [NSString stringWithFormat:@"Step 2"];
        UIImage *img = [UIImage imageNamed: @"step2.png"];
        [image setImage:img];
        description.text = [NSString stringWithFormat:@"Test yourself, train hard, challenge other people and earn badges. Reputation is everything."];
        [btn1 setHidden:NO];
        [btn2 setHidden:NO];
        [btn3 setHidden:YES];
    }
    if(self.index==2) {
        screenNumber.text = [NSString stringWithFormat:@"Step 3"];
        UIImage *img = [UIImage imageNamed: @"step3.png"];
        [image setImage:img];
        description.text = [NSString stringWithFormat:@"You can always enable or disable this screen as well as other options from the settings screen."];
        [btn1 setHidden:YES];
        [btn2 setHidden:YES];
        [btn3 setHidden:NO];
    }
}

- (IBAction)skipbtn {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)regbtn {
    
    InregistrareCont * view = [[InregistrareCont alloc] initWithNibName:@"InregistrareCont" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)getstartedbtn {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end