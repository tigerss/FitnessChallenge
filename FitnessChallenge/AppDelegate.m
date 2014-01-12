//
//  AppDelegate.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseHelper.h"
#import "Tutorial.h"
#import "FitnessChallenge.h"
#import "Utils.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize alertSound = _alertSound;
@synthesize bgMusicForTest = _bgMusicForTest;
@synthesize bgMusicForWorkout = _bgMusicForWorkout;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userLevel"] == nil) {
        [standardDefaults setObject:@"0" forKey:@"userLevel"]; // 0=guest, 1=registered
        [standardDefaults synchronize];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] == nil) {
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [standardDefaults synchronize];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] == nil) {
        [standardDefaults setObject:@"YES" forKey:@"appSoundAlerts"];
        [standardDefaults synchronize];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appTutorial"] == nil) {
        [standardDefaults setObject:@"YES" forKey:@"appTutorial"];
        [standardDefaults synchronize];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        NSURL *urlAlertSound = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"321"
                                                       ofType:@"wav"]];
        NSError *error;
        _alertSound = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:urlAlertSound
                       error:&error];
        [_alertSound prepareToPlay];
    }
    
    // for user badges
    int givenUpTimes = [standardDefaults integerForKey:@"givenUpTimes"];
    int challengesInitiated = [standardDefaults integerForKey:@"challengesInitiated"];
    
    if(givenUpTimes==0) {
        givenUpTimes=0;
        [standardDefaults setInteger:givenUpTimes forKey:@"givenUpTimes"];
        [standardDefaults synchronize];
    }

    if(challengesInitiated==0) {
        challengesInitiated=0;
        [standardDefaults setInteger:challengesInitiated forKey:@"challengesInitiated"];
        [standardDefaults synchronize];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        NSURL *urlBgMusicForTest = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                           pathForResource:@"test"
                                                           ofType:@"mp3"]];
        NSURL *urlBgMusicForWorkout = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                              pathForResource:@"workout"
                                                              ofType:@"mp3"]];
        NSError *error;
        _bgMusicForTest = [[AVAudioPlayer alloc]
                           initWithContentsOfURL:urlBgMusicForTest
                           error:&error];
        _bgMusicForWorkout = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:urlBgMusicForWorkout
                              error:&error];
        [_bgMusicForTest prepareToPlay];
        [_bgMusicForWorkout prepareToPlay];
    }
    
    [DatabaseHelper openDatabase];
    
    NSArray* badges = [DatabaseHelper selectBadges];
    int badgesNumber = [badges count];
    
    if(badgesNumber==0) {
        [DatabaseHelper insertBadge:@"Jumping Jacks Master" :@"jumpingjacks" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Mountain Climbers Master" :@"mountainclimbers" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Planks Master" :@"planks" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Triceps Dips Master" :@"tricepsdips" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Burpees Master" :@"burpees" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Squats Master" :@"squats" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Drills Master" :@"drills" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Crunches Master" :@"crunches" :@"Earned for managing to execute more than 15 reps in 20 secs"];
        [DatabaseHelper insertBadge:@"Push Ups Master" :@"pushups" :@"Earned for managing to execute more than 40 reps in 60 secs"];
        [DatabaseHelper insertBadge:@"King of the Hill" :@"kingofthehill" :@"Earned for managing to get a score higher than 175 points"];
        [DatabaseHelper insertBadge:@"Restless Cheater" :@"restlesscheater" :@"Earned for pushing your luck by entering false values"];
        [DatabaseHelper insertBadge:@"Dangerous Coward" :@"coward" :@"Earned for giving up more than 10 times during workouts"];
        [DatabaseHelper insertBadge:@"Skilled Challenger" :@"challenger" :@"Earned for launching more than 20 challenges to other users"];
        [DatabaseHelper insertBadge:@"VIP User" :@"vip" :@"Earned for registering an account"];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create a LoginUIViewController instance where we will put the login button
    MeniuDreaptaRegUsr *customLoginViewController = [[MeniuDreaptaRegUsr alloc] init];
    self.customLoginViewController = customLoginViewController;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appTutorial"] isEqual:@"YES"])
        self.window.rootViewController = [[Tutorial alloc] init];
    else
        self.window.rootViewController = [[FitnessChallenge alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [FBProfilePictureView class];
    
    // Whenever a person opens the app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
        
        // If there's no cached session, we will show a login button
    } else {
        UIButton *loginButton = [self.customLoginViewController FBconnect];
        [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    }
    return YES;
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

// Show the user the logged-out UI
- (void)userLoggedOut
{
    // Set the button title as "Log in with Facebook"
    UIButton *loginButton = [self.customLoginViewController FBconnect];
    [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
}

// Show the user the logged-in UI
- (void)userLoggedIn
{
    // Set the button title as "Log out"
    UIButton *loginButton = self.customLoginViewController.FBconnect;
    [loginButton setTitle:@"Log out" forState:UIControlStateNormal];
}

// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}

// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [FBSession.activeSession close];
    [DatabaseHelper closeDatabase];
}

@end
