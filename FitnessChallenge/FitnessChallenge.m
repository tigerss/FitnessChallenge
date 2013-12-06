//
//  FitnessChallenge.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "FitnessChallenge.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "MeniuDreapta.h"
#import "Optiuni.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "MeniuDreaptaRegUsr.h"
#import "Utils.h"


@interface FitnessChallenge () <FBLoginViewDelegate>{
    
    NSArray* users;
    
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *nume;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@property FBLoginView* fbview;

@end

@implementation FitnessChallenge

@synthesize nume = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;
@synthesize profilePic = _profilePic;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    users = [DatabaseHelper selectUsers];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.delegate = self;
    
    _profilePic.clipsToBounds = YES;
    _profilePic.layer.cornerRadius = 50.0f;
    _profilePic.layer.borderWidth = 3.0f;
    _profilePic.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    img.clipsToBounds = YES;
    img.layer.cornerRadius = 50.0f;
    img.layer.borderWidth = 3.0f;
    img.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    users = [DatabaseHelper selectUsers];
    User* user = [users objectAtIndex:0];
    
    if (FBSession.activeSession.isOpen) {
   
        [buton1 setEnabled:YES];
        
        [buton3 setEnabled:YES];
        
        [img setHidden:YES];
        
    }
    
    else if ([Utils isUserGuest]) {
        [buton3 setEnabled:NO];
        
        self.nume.text = user.username;
        UIImage *image = [UIImage imageNamed: @"guest.jpg"];
        [img setImage:image];
        
    }
    
    else if ([Utils isUserAuthenticated]) {
//        bool usersNo = [DatabaseHelper selectUsersWithName: user.nume: user.prenume];
        
        [buton3 setEnabled:YES];
        
        if([[user nume] isEqualToString:@""] || [[user prenume] isEqualToString:@""]) {
            self.nume.text = [NSString stringWithFormat:@"%@", user.username];
        } else {
            self.nume.text = [NSString stringWithFormat:@"%@ %@", user.prenume, user.nume];
        }
        
        UIImage *image = [UIImage imageNamed: @"registered.jpg"];
        [img setImage:image];
        
    }
    
    [NetworkingHelper synchronizeUserData:nil failure:nil];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.nume.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.id;
    self.loggedInUser = user;
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

- (IBAction)butonTest {
    
    Test * view = [[Test alloc] initWithNibName:@"Test" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)butonAntrenament {
    
    Antrenament * view = [[Antrenament alloc] initWithNibName:@"Antrenament" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

