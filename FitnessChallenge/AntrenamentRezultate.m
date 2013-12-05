//
//  AntrenamentRezultate.m
//  FitnessChallenge
//
//  Created by Cristian on 11/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "AntrenamentRezultate.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "Recompense.h"
#import "FitnessChallenge.h"
#import "Autentificare.h"
#import "Test.h"
#import "Antrenament.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "MeniuDreaptaRegUsr.h"

@interface AntrenamentRezultate () {
    
    NSArray* users;
    NSArray* workouts;
    NSArray* workoutsReps;
    
}

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation AntrenamentRezultate

@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:2];
    
    self.section1 = [NSArray arrayWithObjects:
                     @"Jumping Jacks",
                     @"Mountain Climbers",
                     @"Planks (With Rotation)",
                     @"Triceps Dips",
                     @"Burpees",
                     @"Bodyweight Squats",
                     @"High Knee Drills",
                     @"Double Crunches",
                     nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
    
    if (FBSession.activeSession.isOpen)
        
        [butonShare setEnabled:YES];
    
    else
        
        [butonShare setEnabled:NO];
    
    users = [DatabaseHelper selectUsers];
    workouts = [DatabaseHelper selectWorkoutIsNotTest];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.menu1 count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.section1 count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    
    Workout* workout = [workouts objectAtIndex:workouts.count-1];
    
    User* user = [users objectAtIndex:0];
    
    workoutsReps = [DatabaseHelper selectWorkoutExerciseReps:workout._id:user.userUUID];
    
    WorkoutExercise* wrkoutReps8 = [workoutsReps objectAtIndex:workoutsReps.count-1];
    WorkoutExercise* wrkoutReps7 = [workoutsReps objectAtIndex:workoutsReps.count-2];
    WorkoutExercise* wrkoutReps6 = [workoutsReps objectAtIndex:workoutsReps.count-3];
    WorkoutExercise* wrkoutReps5 = [workoutsReps objectAtIndex:workoutsReps.count-4];
    WorkoutExercise* wrkoutReps4 = [workoutsReps objectAtIndex:workoutsReps.count-5];
    WorkoutExercise* wrkoutReps3 = [workoutsReps objectAtIndex:workoutsReps.count-6];
    WorkoutExercise* wrkoutReps2 = [workoutsReps objectAtIndex:workoutsReps.count-7];
    WorkoutExercise* wrkoutReps1 = [workoutsReps objectAtIndex:workoutsReps.count-8];
    
    self.section2 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld", (long)wrkoutReps1.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps2.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps3.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps4.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps5.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps6.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps7.numberOfReps],
                     [NSString stringWithFormat:@"%ld", (long)wrkoutReps8.numberOfReps],
                     nil];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ reps", [self.section2 objectAtIndex:indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userInteractionEnabled = NO;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
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
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Fitness Challenge for iOS", @"name",
     @"Workout session results", @"caption",
     @"I have just completed my workout session with a total score of 146 pts.", @"description",
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

@end
