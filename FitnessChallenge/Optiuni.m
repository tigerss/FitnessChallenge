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

@interface Optiuni () <FBLoginViewDelegate>

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation Optiuni

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:5];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userLvl = [standardDefaults stringForKey:@"userLevel"];
    
    if ([userLvl isEqualToString:@"0"]) {
    
        FBLoginView *loginview = [[FBLoginView alloc] init];
    
        loginview.frame = CGRectOffset(loginview.frame, 50, 410);
    
        loginview.delegate = self;
    
        [self.view addSubview:loginview];
    
        [loginview sizeToFit];
        
    }
    
    // app switches are ON by default
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] == nil) {
        
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [toggleMusic setOn:YES animated:NO];
        [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] == nil) {
        
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [toggleSoundAlerts setOn:YES animated:NO];
        [standardDefaults synchronize];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] == nil) {
        
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [toggleNotifications setOn:YES animated:NO];
        [standardDefaults synchronize];
        
    }

    //set switches ON or OFF
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appMusic"] isEqual:@"YES"]) {
        
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        [standardDefaults synchronize];
        [toggleMusic setOn:YES animated:NO];
        
    }
    
    else {
        
        [standardDefaults setObject:@"NO" forKey:@"appMusic"];
        [standardDefaults synchronize];
        [toggleMusic setOn:NO animated:NO];

    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appSoundAlerts"] isEqual:@"YES"]) {
        
        [standardDefaults setObject:@"YES" forKey:@"appSoundAlerts"];
        [standardDefaults synchronize];
        [toggleSoundAlerts setOn:YES animated:NO];
        
    }
    
    else {
        
        [standardDefaults setObject:@"NO" forKey:@"appSoundAlerts"];
        [standardDefaults synchronize];
        [toggleSoundAlerts setOn:NO animated:NO];
        
    }

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"appNotifications"] isEqual:@"YES"]) {
        
        [standardDefaults setObject:@"YES" forKey:@"appNotifications"];
        [standardDefaults synchronize];
        [toggleNotifications setOn:YES animated:NO];
        
    }
    
    else {
        
        [standardDefaults setObject:@"NO" forKey:@"appNotifications"];
        [standardDefaults synchronize];
        [toggleNotifications setOn:NO animated:NO];
        
    }

}

-(IBAction) switchAppMusic{
    if (toggleMusic.on) {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"YES" forKey:@"appMusic"];
        
    }
    
    else {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"NO" forKey:@"appMusic"];
        
    }
}

-(IBAction) switchAppSoundAlert{
    if (toggleSoundAlerts.on) {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"YES" forKey:@"appSoundAlerts"];
        
    }
    
    else {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"NO" forKey:@"appSoundAlerts"];
        
    }
}

-(IBAction) switchAppNotifications{
    if (toggleNotifications.on) {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"YES" forKey:@"appNotifications"];
        
    }
    
    else {
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"NO" forKey:@"appNotifications"];
        
    }
}


- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    //
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    //

    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
