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
#import "Challenges.h"
#import "Optiuni.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "MeniuDreaptaRegUsr.h"
#import "Utils.h"

@interface FitnessChallenge () {
    NSArray* users;
    User* _user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *nume;
@property (strong, nonatomic) IBOutlet UILabel *registrationDate;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation FitnessChallenge

@synthesize nume = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;
@synthesize profilePic = _profilePic;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

	// Do any additional setup after loading the view.
    
    int score=0;
    
    NSArray *workouts = [DatabaseHelper selectWorkoutExercises];
    
    for(WorkoutExercise *wT in workouts)
        score+=wT.numberOfReps;

    userScore.text=[NSString stringWithFormat:@"%i pts",score];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerAlertSound = [SharedAppDelegate alertSound];
        if((sharedPlayerAlertSound.isPlaying==YES))
            [sharedPlayerAlertSound stop];
        [sharedPlayerAlertSound setCurrentTime:0];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        AVAudioPlayer *sharedPlayerMusicForWorkout = [SharedAppDelegate bgMusicForWorkout];
        NSLog(@"%f",sharedPlayerMusicForWorkout.currentTime);
        if((sharedPlayerMusicForWorkout.isPlaying==YES))
            [sharedPlayerMusicForWorkout stop];
        [sharedPlayerMusicForWorkout setCurrentTime:0];
    }
    
    users = [DatabaseHelper selectUsers];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
    _profilePic.clipsToBounds = YES;
    _profilePic.layer.cornerRadius = 50.0f;
    _profilePic.layer.borderWidth = 3.0f;
    _profilePic.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    img.clipsToBounds = YES;
    img.layer.cornerRadius = 50.0f;
    img.layer.borderWidth = 3.0f;
    img.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    users = [DatabaseHelper selectUsers];
    _user = [users objectAtIndex:0];
    
    if (FBSession.activeSession.isOpen) {
   
        [buton1 setEnabled:YES];
        
        [buton3 setEnabled:YES];
        
        [_profilePic setHidden:NO];
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 self.nume.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"first_name"], [user objectForKey:@"last_name"]];
                 self.profilePic.profileID = [user objectForKey:@"id"];
                 self.loggedInUser = user;
             }
         }];
        
    }
    
    else if ([Utils isUserGuest]) {
        [buton3 setEnabled:NO];
        
        self.nume.text = _user.username;
        UIImage *image = [UIImage imageNamed: @"guest.jpg"];
        [img setImage:image];
        [_profilePic setHidden:NO];
        [img setHidden:NO];
        
    }
    
    else if ([Utils isUserAuthenticated]) {
//        bool usersNo = [DatabaseHelper selectUsersWithName: user.nume: user.prenume];
        
        [buton3 setEnabled:YES];
        
        if([[_user nume] isEqualToString:@""] || [[_user prenume] isEqualToString:@""]) {
            self.nume.text = [NSString stringWithFormat:@"%@", _user.username];
        } else {
            self.nume.text = [NSString stringWithFormat:@"%@ %@", _user.prenume, _user.nume];
        }
        
        UIImage *image = [UIImage imageNamed: @"registered.png"];
        [img setImage:image];
        [_profilePic setHidden:NO];
        [img setHidden:NO];
        
    }

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    NSDate *thisDate = [dateFormat dateFromString:_user.regDate];
    [dateFormat setDateFormat:@"MMM d, yyyy"];
    
    if(FBSession.activeSession.isOpen) {
        self.registrationDate.text = [NSString stringWithFormat:@"(connected with Facebook)"];
    } else if([_user.username rangeOfString:@"guest"].location != NSNotFound) {
        self.registrationDate.text = [NSString stringWithFormat:@"(not registered yet)"];
    } else {
        self.registrationDate.text = [NSString stringWithFormat:@"(registered on %@)", [dateFormat stringFromDate:thisDate]];
    }

    
    [NetworkingHelper synchronizeUserData:nil failure:nil];
    
    [NetworkingHelper fetchLeaderBoard:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* response = (NSDictionary*) responseObject;
        NSMutableArray* leaderboardRows = [response objectForKey:@"rows"];
        NSString* username = [_user username];
        __block NSString* rank = @"n/a";
        int index = 0;
        for (NSDictionary* row in leaderboardRows) {
            index += 1;
            NSString* name = [row objectForKey:@"value"];
            if (nil != name && [name isEqualToString:username]) {
                NSNumber* score = [row objectForKey:@"key"];
                if (nil != score) {
                    rank = [@(index) stringValue];
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [userRank setText:[NSString stringWithFormat:@"#%@", rank]];
        });
    } failure:
     ^(AFHTTPRequestOperation* operation, NSError* error) {
         NSLog(@"%@", [error debugDescription]);
         dispatch_async(dispatch_get_main_queue(), ^{
             [userRank setText:[NSString stringWithFormat:@"%@", @"n/a"]];
         });
     }];
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

- (IBAction)butonChallengeSomebody {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"PLEASE SELECT EXERCISE:"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Push-Ups",@"Jumping Jacks",
                                  @"Mountain Climbers",
                                  @"Planks (With Rotation)",
                                  @"Triceps Dips",
                                  @"Burpees",
                                  @"Bodyweight Squats",
                                  @"High Knee Drills",
                                  @"Double Crunches", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:[self.view window]];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSArray* exercises = [NSArray arrayWithObjects:@"Push-Ups",@"Jumping Jacks",
                          @"Mountain Climbers",
                          @"Planks (With Rotation)",
                          @"Triceps Dips",
                          @"Burpees",
                          @"Bodyweight Squats",
                          @"High Knee Drills",
                          @"Double Crunches", nil];
    
    if(buttonIndex <= [exercises count]-1) {
        NSString* exerciseName = [exercises objectAtIndex:buttonIndex];
        PublicChallenge* challenge = [[PublicChallenge alloc]init];
        [challenge setChallengerUsername:[_user username]];
        [challenge setExerciseName:exerciseName];
        [NetworkingHelper insertChallenge:challenge success:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"%@",exerciseName] message: @"Challenge created!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [error debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }];
    }
    else
        NSLog(@"cancel button pressed");
    
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
        
        Challenges * view = [[Challenges alloc] initWithNibName:@"Challenges" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        [sidebar dismissAnimated:YES completion:nil];
        
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

