//
//  Autentificare.m
//  FitnessChallenge
//
//  Created by Cristian on 11/12/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Autentificare.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"
#import "MeniuDreaptaRegUsr.h"
#import "NetworkingHelper.h"
#import "Utils.h"
#import "Challenges.h"

@interface Autentificare ()

@end

@implementation Autentificare

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    [email becomeFirstResponder];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [warning setHidden:YES];
}

- (IBAction) auth {
    
    NSString *eMail = email.text;
    NSString *Pass = pass.text;
    
    if(([eMail isEqual:@""])||([Pass isEqual:@""]))
    {
        warning.text = @"please enter your email address and/or password !";
        [warning setHidden:NO];
    }
    else
    {
        [NetworkingHelper fetchUserByUserName:eMail success:^(FitnessUser *fitnessUser) {
            if (nil == fitnessUser) {
                warning.text = @"wrong email address !";
                [warning setHidden:NO];
            } else {
                if ([Pass isEqual:[fitnessUser password]]) {
                    NSArray* users = [DatabaseHelper selectUsers];
                    //if we have no user, create dummy user account
                    if([users count]==0) {
                        NSString *uuid = @"1234567890";
                        NSString *user = [NSString stringWithFormat:@"guest%@", uuid];
                        NSString *smallerUser = [user substringToIndex:13];
                        NSString *dateString=[Utils dateToString];
                        [DatabaseHelper insertUser: uuid: smallerUser: @"": @"": @"": dateString];
                    }
                    NSArray* usersAfterInsert = [DatabaseHelper selectUsers];
                    User* localUser = [usersAfterInsert objectAtIndex:0];
                    NSString* regDate = [Utils dateToString];
                    [DatabaseHelper updateUserWithUsername:[fitnessUser name] password:[fitnessUser password] uuid:[fitnessUser uuid] nume:[fitnessUser nume] prenume:[fitnessUser prenume] regDate:regDate oldUserName:[localUser username]];
                    [Utils setUserAuthenticated];
                    
                    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
                    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:view animated:YES completion:nil];
                } else {
                    warning.text = @"wrong password !";
                    [warning setHidden:NO];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            warning.text = [error debugDescription];
            [warning setHidden:NO];
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
