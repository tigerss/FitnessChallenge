//
//  TestRezultate.m
//  FitnessChallenge
//
//  Created by Cristian on 10/28/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "TestRezultate.h"
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
#import "NetworkingHelper.h"
#import "Challenges.h"

@interface TestRezultate ()

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation TestRezultate {
    
    NSArray* users;
    NSArray* workouts;
    NSArray* workoutExercises;
    WorkoutExercise* lastWorkoutExercise;
    
    int indexRowHighlight;
    
}

@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    self.section1 = [NSArray arrayWithObjects:@"User 1", @"User 2", @"User 3", @"My result", @"User 5", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"29", @"25", @"23", @"21", @"12", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
    
    if (FBSession.activeSession.isOpen)
        
        [butonShare setEnabled:YES];
    
    else
        
        [butonShare setEnabled:NO];
    
    users = [DatabaseHelper selectUsers];
    workouts = [DatabaseHelper selectWorkoutIsTest];
    Workout* lastWorkout = [workouts objectAtIndex:workouts.count-1];
    User* user = [users objectAtIndex:0];
    workoutExercises = [DatabaseHelper selectWorkoutExerciseReps:lastWorkout._id :user.userUUID];
    lastWorkoutExercise = [workoutExercises objectAtIndex:workoutExercises.count-1];
    [NetworkingHelper synchronizeUserData:nil failure:nil];
    [NetworkingHelper fetchLastTestScores:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* response = (NSDictionary*) responseObject;
        NSMutableArray* leaderboardRows = [response objectForKey:@"rows"];
        NSMutableArray* names = [[NSMutableArray alloc] init];
        NSMutableArray* scores = [[NSMutableArray alloc] init];
        for (NSDictionary* row in leaderboardRows) {
            NSString* name = [row objectForKey:@"value"];
            NSString* score = [row objectForKey:@"key"];
            if (nil != name && nil != score && ([name caseInsensitiveCompare:[user username]] != NSOrderedSame))
            {
                [names addObject:name];
                [scores addObject:score];
            }
        }
        
        int lastWorkoutRepsNumber = [lastWorkoutExercise numberOfReps];
        int indexOfFirstWeakerPlayer = [scores count] - 1;
        for (int index = 0; index < [scores count]; index++) {
            NSString* score = [scores objectAtIndex:index];
            int scoreValue = [score intValue];
            if (lastWorkoutRepsNumber >= scoreValue) {
                indexOfFirstWeakerPlayer = index;
                break;
            }
        }
        
        @try {
            int firstIndex = indexOfFirstWeakerPlayer - 3;
            while (firstIndex < 0 && firstIndex < indexOfFirstWeakerPlayer) {
                firstIndex++;
            }
            int lastIndex = indexOfFirstWeakerPlayer;
            
            NSMutableArray* playerScores = [[NSMutableArray alloc]init];
            NSMutableArray* playerNames = [[NSMutableArray alloc]init];
            for (int index = firstIndex; index <= lastIndex; index++) {
                [playerScores addObject:[scores objectAtIndex:index]];
                [playerNames addObject:[names objectAtIndex:index]];
            }
            
            for (int index = 0; index <= (lastIndex - firstIndex); index++) {
                NSString* score = [scores objectAtIndex:(index + firstIndex)];
                int scoreValue = [score intValue];
                if (lastWorkoutRepsNumber >= scoreValue) {
                    [playerScores insertObject:[@(lastWorkoutRepsNumber) stringValue] atIndex:index];
                    [playerNames insertObject:[user username] atIndex:index];
                    indexRowHighlight = index;
                    break;
                }
            }
            
//            NSString* firstPlayerName = [names objectAtIndex:indexOfFirstWeakerPlayer];
//            NSString* firstPlayerScore = [scores objectAtIndex:indexOfFirstWeakerPlayer];
//            
//            NSString* secondPlayerName = [user username];
//            NSString* secondPlayerScore = [NSString stringWithFormat:@"%d", [lastWorkoutExercise numberOfReps]];
//            
//            self.section1 = [NSArray arrayWithObjects:secondPlayerName, firstPlayerName, nil];
//            self.section2 = [NSArray arrayWithObjects:secondPlayerScore, firstPlayerScore, nil];
            self.section1 = playerNames;
            self.section2 = playerScores;
            
            [self.tableView reloadData];
        } @catch (NSError* e) {
            NSLog(@"%@", [e debugDescription]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error debugDescription]);
    } includeDocs:NO];
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
    
    Workout* workout = [workouts objectAtIndex:workouts.count-1];
    
    User* user = [users objectAtIndex:0];
    
    workoutExercises = [DatabaseHelper selectWorkoutExerciseReps:workout._id :user.userUUID];
    
    WorkoutExercise* wrkoutReps = [workoutExercises objectAtIndex:workoutExercises.count-1];
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Fitness Challenge for iOS", @"name",
     @"Test session results", @"caption",
     [NSString stringWithFormat:@"I have just completed my test with %i push-ups.", wrkoutReps.numberOfReps], @"description",
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    
    if(indexPath.row == 3) {
        
//        Workout* workout = [workouts objectAtIndex:workouts.count-1];
//        
//        User* user = [users objectAtIndex:0];
//        
//        workoutsReps = [DatabaseHelper selectWorkoutExerciseReps:workout._id :user.userUUID];
//        
//        WorkoutExercise* wrkoutReps = [workoutsReps objectAtIndex:workoutsReps.count-1];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i reps", lastWorkoutExercise.numberOfReps];
        
    }
        
    else {
    
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ reps", [self.section2 objectAtIndex:indexPath.row]];
        
    }
    
    UIImage *image = [UIImage imageNamed:@"guest.jpg"];
    
    CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.imageView.image = img;
    
    cell.imageView.layer.masksToBounds = YES;
    
    cell.imageView.layer.cornerRadius = 24.0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userInteractionEnabled = NO;
    
    UIGraphicsEndImageContext();
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if(indexPath.row == indexRowHighlight) {
        
        cell.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:73.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        
        else {
        
        cell.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    
        }
    }
    
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
