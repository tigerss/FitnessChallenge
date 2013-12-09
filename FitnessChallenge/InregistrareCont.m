//
//  InregistrareCont.m
//  FitnessChallenge
//
//  Created by Cristian on 11/19/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "InregistrareCont.h"
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

@interface InregistrareCont () {
    
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation InregistrareCont

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
    [email becomeFirstResponder];
    
}

- (IBAction)showMenu:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"home"],
                        [UIImage imageNamed:@"test"],
                        [UIImage imageNamed:@"workout"],
                        [UIImage imageNamed:@"challenges"],
                        [UIImage imageNamed:@"achievements"],
                        [UIImage imageNamed:@"gear"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    
    callout.delegate = self;
    
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
    if(index==0)
    {
        
        FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    if(index==1)
    {
        
        Test * view = [[Test alloc] initWithNibName:@"Test" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==2)
    {
        
        Antrenament * view = [[Antrenament alloc] initWithNibName:@"Antrenament" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==3)
    {
        
        //Challenges
        
    }
    
    if(index==4)
    {
        
        Recompense * view = [[Recompense alloc] initWithNibName:@"Recompense" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
    if(index==5)
    {
        
        Optiuni * view = [[Optiuni alloc] initWithNibName:@"Optiuni" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    
    if (itemEnabled)
        self.optionIndices = [NSMutableIndexSet indexSetWithIndex:index];
    
}

- (IBAction)pushUserDetails {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userLvl = [standardDefaults stringForKey:@"userLevel"];
    
    if(([userLvl isEqualToString:@"1"])||(FBSession.activeSession.isOpen)) {
        
        MeniuDreaptaRegUsr *modal = [[MeniuDreaptaRegUsr alloc] initWithNibName:@"MeniuDreaptaRegUsr" bundle:nil];
        modal.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:modal animated:YES completion:nil];
        
    }
    
    else {
        
        MeniuDreapta *modal = [[MeniuDreapta alloc] initWithNibName:@"MeniuDreapta" bundle:nil];
        modal.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:modal animated:YES completion:nil];
        
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    [warning setHidden:YES];
}

- (IBAction) inregistrare {
    
    NSString *eMail = email.text;
    NSString *pW = pass.text;
    NSString *pRenume = prenume.text;
    NSString *Nume = nume.text;
    
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString=[dateFormat stringFromDate:today];
    
    if(([email.text isEqual:@""])||([pass.text isEqual:@""])) {
        
        warning.text = @"please complete email and password !";
        
        [warning setHidden:NO];
        
    }
    
    else if(!([prenume.text isEqual:@""])&&([nume.text isEqual:@""])) {
        
        warning.text = @"please complete both first and last name";
        
        [warning setHidden:NO];
        
    }
    
    else if(([prenume.text isEqual:@""])&&!([nume.text isEqual:@""])) {
        
        warning.text = @"please complete both first and last name";
        
        [warning setHidden:NO];
        
    }

    else {
        [NetworkingHelper fetchUserByUserName:eMail
                                      success:^(FitnessUser *fitnessUser) {
                                          if (nil == fitnessUser) {
                                              
                                              NSArray* users = [DatabaseHelper selectUsers];
                                              __block User* localUser = [users objectAtIndex:0];
                                              
                                              // Fetch the current user by uuid if exists
                                              
                                              [NetworkingHelper fetchUserByUUID:[localUser userUUID] success:^(FitnessUser *fitnessUser) {
                                                  
                                                  User* newUser = [[User alloc]init];
                                                  [newUser setUsername:eMail];
                                                  [newUser setPassword:pW];
                                                  [newUser setUserUUID:[localUser userUUID]];
                                                  [newUser setNume:Nume];
                                                  [newUser setPrenume:pRenume];
                                                  
                                                  if (nil == fitnessUser) { // inserting new user
                                                      
                                                      [NetworkingHelper insertUserInCloud:newUser success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          
                                                          [self onSuccessCallback:newUser :dateString :localUser.username];
                                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                          [self onErrorCallback:error];
                                                      }];
                                                  } else {
                                                      [fitnessUser setName:[newUser username]];
                                                      [fitnessUser setPassword:[newUser password]];
                                                      [fitnessUser setUuid:[newUser userUUID]];
                                                      [fitnessUser setNume:[newUser nume]];
                                                      [fitnessUser setPrenume:[newUser prenume]];
                                                      [NetworkingHelper updateUserInCloud: fitnessUser
                                                                              forceUpdate: YES
                                                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          [self onSuccessCallback:newUser :dateString :localUser.username];
                                                      }
                                                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                          [self onErrorCallback:error];
                                                      }];
                                                  }

                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  warning.text = [error debugDescription];
                                                  
                                                  [warning setHidden:NO];
                                              }];
                                             
                                          } else {
                                              [self onErrorCallbackMessage:@"The email has been already registered by another user"];
                                          }
                                      }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          [self onErrorCallback:error];
                                      }];
    }
    
}

- (void) onSuccessCallback:(User*) newUser :(NSString*) dateAsString :(NSString*) oldUserName {
    [DatabaseHelper updateUser: [newUser username]
                      password:[newUser password]
                          nume:[newUser nume]
                       prenume:[newUser prenume]
                       regDate:dateAsString
                   oldUserName:oldUserName];
    
    [Utils setUserAuthenticated];
    
    NSArray *badges = [DatabaseHelper selectBadgeWithID:[NSNumber numberWithInt:14]];
    NSArray *users = [DatabaseHelper selectUsers];
    User* user = [users objectAtIndex:0];
    int numberOfBadges = [badges count];
    if(numberOfBadges==0) {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] isEqual:@"YES"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                            message:@"New badge unlocked!"
                                                           delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 5;
            [alert show];
            
        }
        [DatabaseHelper insertBadgeUser:[NSNumber numberWithInt:14] :user.userUUID];
    }
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
//    Autentificare * view = [[Autentificare alloc] initWithNibName:@"Autentificare" bundle:nil];
//    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:view animated:YES completion:nil];
}

- (void) onErrorCallback:(NSError*) error {
    [self onErrorCallbackMessage:[error description]];
}

- (void) onErrorCallbackMessage:(NSString*) message {
    warning.text = message;
    
    [warning setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
