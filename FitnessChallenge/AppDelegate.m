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

@implementation AppDelegate

@synthesize window = _window;

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
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
    
    [DatabaseHelper closeDatabase];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        
        NSURL *urlAlertSound = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"321"
                                                       ofType:@"wav"]];
        
        NSError *error;
        
        _alertSound = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:urlAlertSound
                       error:&error];
        
        [_alertSound prepareToPlay];
        [_alertSound setVolume: 1.0];
        
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        
        NSURL *urlBgMusic = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                    pathForResource:@"workout"
                                                    ofType:@"mp3"]];
        
        NSError *error;
        
        _bgMusic = [[AVAudioPlayer alloc]
                    initWithContentsOfURL:urlBgMusic
                    error:&error];
        
        [_bgMusic prepareToPlay];
        [_bgMusic setVolume: 1.0];
        
    }

    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    // default application settings for FitnessChallenge, if not set
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userLevel"] == nil) {
        
    [standardDefaults setObject:@"0" forKey:@"userLevel"]; // 0=guest, 1=registered
    [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"music"] == nil) {
    
    [standardDefaults setObject:@"On" forKey:@"music"];
    [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"alert"] == nil) {
    
    [standardDefaults setObject:@"On" forKey:@"alert"];
    [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"notifications"] == nil) {
    
    [standardDefaults setObject:@"On" forKey:@"notifications"];
    [standardDefaults synchronize];
        
    }
    
    [DatabaseHelper openDatabase];
    
    bool usersNo = [DatabaseHelper selectUsersNr];
    
    if(usersNo==NO) {
        
        NSString *uuid = [[NSUUID UUID] UUIDString];
        
        NSString *user = [NSString stringWithFormat:@"guest%@", uuid];
        
        NSString *smallerUser = [user substringToIndex:13];
        
        NSDate *today=[NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString=[dateFormat stringFromDate:today];
        
        [DatabaseHelper insertUser: uuid: smallerUser: @"": @"": @"": dateString];
        
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[FitnessChallenge alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [FBProfilePictureView class];
    
    // Load default settings and stored variables
    
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
