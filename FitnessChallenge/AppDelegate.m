//
//  AppDelegate.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseHelper.h"
#import "FitnessChallenge.h"
#import "Utils.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize alertSound = _alertSound;
@synthesize bgMusicForTest = _bgMusicForTest;
@synthesize bgMusicForWorkout = _bgMusicForWorkout;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [FBSession.activeSession close];
    [DatabaseHelper closeDatabase];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"noTipsScreen"] == nil) {
        [standardDefaults setObject:@"0" forKey:@"userLevel"];
        [standardDefaults synchronize];
    }
    
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
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] == nil) {
        [standardDefaults setObject:@"YES" forKey:@"appNotifications"];
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
    bool usersNo = [DatabaseHelper selectUsersNr];
    
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
    
    if(usersNo==NO) {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        NSString *user = [NSString stringWithFormat:@"guest%@", uuid];
        NSString *smallerUser = [user substringToIndex:13];
        NSString *dateString=[Utils dateToString];
        [DatabaseHelper insertUser: uuid: smallerUser: @"": @"": @"": dateString];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[FitnessChallenge alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [FBProfilePictureView class];
    
    return YES;
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

@end
