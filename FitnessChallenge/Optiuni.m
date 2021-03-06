//
//  Optiuni.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
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
#import "Challenges.h"

@interface Optiuni ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation Optiuni

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:5];
    
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
    
    if (FBSession.activeSession.isOpen) {
        [_FBdisconnect setHidden:NO];
        [_aboutApp setHidden:YES];
    }
    else {
        [_FBdisconnect setHidden:YES];
        [_aboutApp setHidden:NO];
    }
    
    //set switches ON or OFF
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"])
        [toggleMusic setOn:YES animated:NO];
    else
        [toggleMusic setOn:NO animated:NO];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"])
        [toggleSoundAlerts setOn:YES animated:NO];
    else
        [toggleSoundAlerts setOn:NO animated:NO];

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appTutorial"] isEqual:@"YES"])
        [toggleNotifications setOn:YES animated:NO];
    else
        [toggleNotifications setOn:NO animated:NO];

}

- (IBAction)disconFacebook
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}

-(IBAction) showAppInfo {
    
    float versionNumber = 1.0f;
    NSString *creationDate = @"December, 2013";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FitnessChallenge for iOS"
                                                    message:[NSString stringWithFormat:@"Version %.1f (%@)", versionNumber,creationDate]
                                                   delegate:self
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}

-(IBAction) switchAppMusic {
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if (toggleMusic.on) {
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [standardDefaults synchronize];
    }
    else {
        [standardDefaults setObject:@"NO" forKey:@"appMusic"];
        [standardDefaults synchronize];
    }
}

-(IBAction) switchAppSoundAlert {
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if (toggleSoundAlerts.on) {
        [standardDefaults setObject:@"YES" forKey:@"appSoundAlerts"];
        [standardDefaults synchronize];
    }
    else {
        [standardDefaults setObject:@"NO" forKey:@"appSoundAlerts"];
        [standardDefaults synchronize];
    }
}

-(IBAction) switchAppTutorial {
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if (toggleNotifications.on) {
        [standardDefaults setObject:@"YES" forKey:@"appTutorial"];
        [standardDefaults synchronize];
    }
    else {
        [standardDefaults setObject:@"NO" forKey:@"appTutorial"];
        [standardDefaults synchronize];
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
