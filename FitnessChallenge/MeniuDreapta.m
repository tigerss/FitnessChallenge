//
//  Antrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreapta.h"
#import "ECSlidingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "FitnessChallenge.h"

@interface MeniuDreapta () <FBLoginViewDelegate>

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *nume;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation MeniuDreapta

@synthesize nume = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;
@synthesize profilePic = _profilePic;
@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, 80, 400);
    
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
    [self.slidingViewController setAnchorLeftRevealAmount:260.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
    
    self.section1 = [NSArray arrayWithObjects:@"Top 5 utilizatori", @"Utilizator 1", @"Utilizator 2", @"Utilizator 3", @"Utilizator 4", @"Utilizator 5", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"",@"290", @"275", @"247", @"200", @"190", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_user.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    tv1.clipsToBounds = YES;
    tv1.layer.cornerRadius = 5.0f;
    
    _profilePic.clipsToBounds = YES;
    _profilePic.layer.cornerRadius = 50.0f;
    
    _labelFirstName.layer.shadowRadius = 2.0;
    _labelFirstName.layer.shadowOpacity = 0.8;
    _labelFirstName.layer.masksToBounds = NO;
    
}

- (void)viewDidUnload {
    self.nume = nil;
    self.loggedInUser = nil;
    self.profilePic = nil;
    [super viewDidUnload];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.nume.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.id;
    self.loggedInUser = user;
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FitnessChallenge"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];

    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {

    self.profilePic.profileID = nil;
    self.nume.text = @"Guest User";
    self.loggedInUser = nil;
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FitnessChallenge"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];

    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
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
    
    if (indexPath.section == 0) {
        
        if(indexPath.row == 0) {
    
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        }
        else {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ puncte", [self.section2 objectAtIndex:indexPath.row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    
    cell.userInteractionEnabled = NO;
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            cell.backgroundColor = [UIColor brownColor];
            cell.backgroundView.backgroundColor = [UIColor brownColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            
        }
        
        else {
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.backgroundView.backgroundColor = [UIColor whiteColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            
        }
    }
    
}

@end
