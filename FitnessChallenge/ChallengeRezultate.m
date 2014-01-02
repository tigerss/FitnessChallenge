//
//  ChallengeRezultate.m
//  FitnessChallenge
//
//  Created by Cristian on 12/29/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "ChallengeRezultate.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "Recompense.h"
#import "FitnessChallenge.h"
#import "Test.h"
#import "Antrenament.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "MeniuDreaptaRegUsr.h"
#import "NetworkingHelper.h"
#import "Challenges.h"
#import "Utils.h"

@interface ChallengeRezultate ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;

@end

@implementation ChallengeRezultate {
    
    NSArray* users;
    NSArray* workouts;
    NSArray* workoutsReps;
    
}

@synthesize profilePic = _profilePic;

- (id) init {
    self = [super init];
    if (self) {
        _repsNumber = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:3];
    
    if (FBSession.activeSession.isOpen)
        
        [butonShare setEnabled:YES];
    
    else
        
        [butonShare setEnabled:NO];
    
    _profilePic.clipsToBounds = YES;
    _profilePic.layer.cornerRadius = 50.0f;
    _profilePic.layer.borderWidth = 3.0f;
    _profilePic.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [_profilePic setHidden:NO];
    
    img1.clipsToBounds = YES;
    img1.layer.cornerRadius = 50.0f;
    img1.layer.borderWidth = 3.0f;
    img1.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    img2.clipsToBounds = YES;
    img2.layer.cornerRadius = 50.0f;
    img2.layer.borderWidth = 3.0f;
    img2.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UIImage *image1 = [UIImage imageNamed: @"guest.jpg"];
    [img1 setImage:image1];
    
    if (FBSession.activeSession.isOpen) {
        
        [_profilePic setHidden:NO];
        [img1 setHidden:YES];
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 self.profilePic.profileID = [user objectForKey:@"id"];
             }
         }];
        
    }
    
    else if ([Utils isUserGuest]) {
        UIImage *image1 = [UIImage imageNamed: @"guest.jpg"];
        [img1 setImage:image1];
    }
    
    else if ([Utils isUserAuthenticated]) {
        UIImage *image1 = [UIImage imageNamed: @"registered.png"];
        [img1 setImage:image1];
    }

    
    UIImage *image2 = [UIImage imageNamed: @"guest.jpg"];
    [img2 setImage:image2];
    
    [_challenge setChallengeeRepsNumber: _repsNumber];
    
    [labelChallengerUsername setText: [_challenge challengerUsername]];
    [labelChallengeeUsername setText: [_challenge challengeeUsername]];

    [labelChallengerScore setText: [NSString stringWithFormat: @"%i reps",
                                    [_challenge challengerRepsNumber]]];
    [labelChallengeeScore setText: [NSString stringWithFormat: @"%i reps",
                                    [_challenge challengeeRepsNumber]]];
    
    if ([_challenge isTie]) {
        [labelOutcomeMessage setText: @"It's a tie :("];
    } else if ([_challenge isChallengeeWinner]) {
        [labelOutcomeMessage setText: @"You have won the challenge!"];
    } else if ([_challenge isChallengerWinner]) {
        [labelOutcomeMessage setText: @"You have lost the challenge!"];
    }
    
    [NetworkingHelper updateChallenge:_challenge success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Challenge updated successfully!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [error debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }];
    
//    users = [DatabaseHelper selectUsers];
//    workouts = [DatabaseHelper selectWorkoutIsTest];
//    [NetworkingHelper synchronizeUserData:nil failure:nil];
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

/**
 * A function for parsing URL parameters.
 */
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (IBAction)publishButtonAction:(id)sender {
    // Put together the dialog parameters
    
//    Workout* workout = [workouts objectAtIndex:workouts.count-1];
//    
//    User* user = [users objectAtIndex:0];
//    
//    workoutsReps = [DatabaseHelper selectWorkoutExerciseReps:workout._id :user.userUUID];
//    
//    WorkoutExercise* wrkoutReps = [workoutsReps objectAtIndex:workoutsReps.count-1];
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Fitness Challenge for iOS", @"name",
     @"Challenge session results", @"caption",
     [NSString stringWithFormat:@"I have just completed %@ challenge with %i reps.", [_challenge exerciseName], _repsNumber], @"description",
     @"https://raw.github.com/fbsamples/ios-3.x-howtos/master/Images/iossdk_logo.png", @"picture",
     nil];
    
    // Invoke the dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled story publishing.");
             } else {
                 // Handle the publish feed callback
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"post_id"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled story publishing.");
                 } else {
                     // User clicked the Share button
                     NSString *msg = [NSString stringWithFormat:
                                      @"Posted story, id: %@",
                                      [urlParams valueForKey:@"post_id"]];
                     NSLog(@"%@", msg);
                     // Show the result in an alert
                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil]
                      show];
                 }
             }
         }
     }];
}

- (IBAction)OptRecompense {
    
    Recompense * view = [[Recompense alloc] initWithNibName:@"Recompense" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)OptEcranInceput {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:view animated:YES completion:nil];
    
}

@end