//
//  MeniuDreaptaRegUsr.m
//  FitnessChallenge
//
//  Created by Cristian on 11/25/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreaptaRegUsr.h"
#import "Reachability.h"
#import "WSAreaChartView.h"
#import "FitnessChallenge.h"

@interface MeniuDreaptaRegUsr ()

@property (nonatomic, strong) UIView *chartView;

@end

@implementation MeniuDreaptaRegUsr
@synthesize chartView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.chartView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:self.chartView atIndex:0];
    [self createAreaChartForWorkout];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
    } else {
        
        NSLog(@"There IS internet connection");
        
        
    }
    
    if (!(FBSession.activeSession.isOpen)) {
        [_FBconnect setHidden:NO];
    }
    else
        [_FBinvite setHidden:NO];
    
//    [NetworkingHelper fetchLeaderBoard:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary* response = (NSDictionary*) responseObject;
//        NSMutableArray* leaderboardRows = [response objectForKey:@"rows"];
//        NSMutableArray* names = [[NSMutableArray alloc] init];
//        NSMutableArray* scores = [[NSMutableArray alloc] init];
//        for (NSDictionary* row in leaderboardRows) {
//            NSString* name = [row objectForKey:@"value"];
//            if ([name length] > 20 ) {
//                name = [name substringToIndex:20];
//            }
//            NSString* score = [row objectForKey:@"key"];
//            if (nil != name && nil != score) {
//                [names addObject:name];
//                [scores addObject:score];
//            }
//        }
//        self.section1 = names;
//        self.section2 = scores;
//        self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
//        
//        [self.tableView reloadData];
//    } failure:
//     ^(AFHTTPRequestOperation* operation, NSError* error) {
//         NSLog(@"%@", [error debugDescription]);
//     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)conWithFacebook
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info",@"email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
             
             FitnessChallenge * view = [[FitnessChallenge alloc] initWithNibName:@"FitnessChallenge" bundle:nil];
             view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
             [self presentViewController:view animated:YES completion:nil];
             
         }];
    }
}

- (IBAction)showFriendsAction:(id)sender {
    // Initialize the friend picker
    FBFriendPickerViewController *friendPickerController = [[FBFriendPickerViewController alloc] init];
    
    // Configure the picker ...
    friendPickerController.title = @"Invite Friends";
    // Set this view controller as the friend picker delegate
    friendPickerController.delegate = self;
    // Allow only a single friend to be selected
    friendPickerController.allowsMultipleSelection = NO;
    
    // Fetch the data
    [friendPickerController loadData];
    
    // Present view controller modally.e the deprecated
    if ([self
         respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        // iOS 5+
        [self presentViewController:friendPickerController animated:YES completion:nil];
    } else {
        [self presentModalViewController:friendPickerController animated:YES];
    }
}

- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    
    FBFriendPickerViewController *fpc = (FBFriendPickerViewController *)sender;
    
    NSString *selectedUserID, *selectedUserName;
    
    for (id<FBGraphUser> user in fpc.selection) {
        selectedUserID = [NSString stringWithFormat:@"%@",user.id];
        selectedUserName = [NSString stringWithFormat:@"%@",user.first_name];
    }
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     [NSString stringWithFormat:@"Hi there, %@",selectedUserName], @"name",
     @"Join FitnessChallenge now!", @"description",
     @"http://blog.evernote.com/wp-content/uploads/2012/06/fitness_challenge.png", @"picture",
     [NSString stringWithFormat:@"%@",selectedUserID], @"to", nil];

    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {}
     ];
    
    //Close the friend picker.
//    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)changeSeg{
	if(segmentedControl.selectedSegmentIndex == 0){
        [notEnoughData setHidden:NO];
        [self createAreaChartForTest];
	}
	if(segmentedControl.selectedSegmentIndex == 1){
        [notEnoughData setHidden:NO];
        [self createAreaChartForWorkout];
	}
}

- (void)createAreaChartForWorkout
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    WSAreaChartView *areaChart  = [[WSAreaChartView alloc] initWithFrame:CGRectMake(0.0, 40.0, screenRect.size.width, screenRect.size.height-80)];
    NSMutableArray *arr = [self createDataForWorkout:5];
    NSDictionary *colorDict = [self createColorDictWorkout];
    areaChart.rowWidth = 60.0;
    areaChart.title = @"";
    [areaChart drawChart:arr withColor:colorDict];
    areaChart.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    [self.chartView addSubview:areaChart];
}

- (void)createAreaChartForTest
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    WSAreaChartView *areaChart  = [[WSAreaChartView alloc] initWithFrame:CGRectMake(0.0, 40.0, screenRect.size.width, screenRect.size.height-80)];
    NSMutableArray *arr = [self createDataForTest:5];
    NSDictionary *colorDict = [self createColorDictTest];
    areaChart.rowWidth = 60.0;
    areaChart.title = @"";
    [areaChart drawChart:arr withColor:colorDict];
    areaChart.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    [self.chartView addSubview:areaChart];
}

- (NSMutableArray*)createDataForWorkout:(int)count
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *workouts = [DatabaseHelper selectWorkouts];
    NSArray *workoutExercices = [DatabaseHelper selectWorkoutExercises];
    int reps=0, daysNo=7;
    NSString *lastDateShown=@"";
    NSDate *currDate;
    
    //generate data for tests
    for(Workout *w in workouts)
    {
        for(WorkoutExercise *we in workoutExercices)
        {
            NSInteger workID = [w._id integerValue];
            int workExID = we.workoutId;
            if(workID==workExID)
            {
                reps=reps+we.numberOfReps;
            }
            else if(workID>workExID)
                continue;
            else
                break;
        }
        if(!([[w.startTime substringToIndex:10] isEqual:lastDateShown])) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:DATE_FORMAT];
            NSDate *thisDate = [dateFormat dateFromString:[w.startTime substringToIndex:10]];
            currDate = [NSDate date];
            NSTimeInterval distanceBetweenDates = [currDate timeIntervalSinceDate:thisDate];
            int distanceDates = (distanceBetweenDates / 3600) / 24;
            [dateFormat setDateFormat:@"d MMM"];
            if(distanceDates>=daysNo) {
                if(w.esteTest==0)
                {
                    WSChartObject *workouts = [[WSChartObject alloc] init];
                    workouts.name = @"Workout";
                    workouts.xValue = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:thisDate]];
                    workouts.yValue = [NSNumber numberWithInt:reps];
                    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:workouts,@"Workout", nil];
                    [arr addObject:data];
                    count--;
                    daysNo = daysNo+7;
                }
            }
            lastDateShown = [w.startTime substringToIndex:10];
            reps=0;
        }
        if(count==0)
        {
            [notEnoughData setHidden:YES];
            break;
        }
        else
            continue;
    }
    
    return arr;
}

- (NSMutableArray*)createDataForTest:(int)count
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *workouts = [DatabaseHelper selectWorkouts];
    NSArray *workoutExercices = [DatabaseHelper selectWorkoutExercises];
    int reps=0, daysNo=7;
    NSString *lastDateShown=@"";
    NSDate *currDate;
    
    //generate data for tests
    for(Workout *w in workouts)
    {
        for(WorkoutExercise *we in workoutExercices)
        {
            NSInteger workID = [w._id integerValue];
            int workExID = we.workoutId;
            if(workID==workExID)
            {
                reps=reps+we.numberOfReps;
            }
            else if(workID>workExID)
                continue;
            else
                break;
        }
        if(!([[w.startTime substringToIndex:10] isEqual:lastDateShown])) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:DATE_FORMAT];
            NSDate *thisDate = [dateFormat dateFromString:[w.startTime substringToIndex:10]];
            currDate = [NSDate date];
            NSTimeInterval distanceBetweenDates = [currDate timeIntervalSinceDate:thisDate];
            int distanceDates = (distanceBetweenDates / 3600) / 24;
            [dateFormat setDateFormat:@"d MMM"];
            if(distanceDates>=daysNo) {
                if(w.esteTest==1)
                {
                    WSChartObject *tests = [[WSChartObject alloc] init];
                    tests.name = @"Test";
                    tests.xValue = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:thisDate]];
                    tests.yValue = [NSNumber numberWithInt:reps];
                    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:tests,@"Test", nil];
                    [arr addObject:data];
                    count--;
                    daysNo = daysNo+7;
                }
            }
            lastDateShown = [w.startTime substringToIndex:10];
            reps=0;
        }
        if(count==0)
        {
            [notEnoughData setHidden:YES];
            break;
        }
        else
            continue;
    }
    
    return arr;
}

- (NSDictionary*)createColorDictTest
{
    NSDictionary *colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               [UIColor colorWithRed:39.0f/255.0f green:174.0f/255.0f blue:96.0f/255.0f alpha:1.0f],@"Test",  nil];
    return colorDict;
}

- (NSDictionary*)createColorDictWorkout
{
    NSDictionary *colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               [UIColor colorWithRed:39.0f/255.0f green:174.0f/255.0f blue:96.0f/255.0f alpha:1.0f],@"Workout",  nil];
    return colorDict;
}

- (IBAction)dismissThisView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return [self.menu1 count];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    
//    return [self.section1 count];
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *cellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//    }
//    
//            UIFont *myFont = [ UIFont fontWithName: @"Helvetica Neue" size: 17.0 ];
//    
//            cell.textLabel.font  = myFont;
//            cell.detailTextLabel.font = myFont;
//    
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
//            
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
//    
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//            cell.userInteractionEnabled = NO;
//    
//    return cell;
//    
//}

@end
