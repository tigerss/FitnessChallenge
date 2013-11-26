//
//  Antrenament.m
//  FitnessChallenge
//
//  Created by Cristian on 11/4/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreapta.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "FitnessChallenge.h"
#import "Autentificare.h"
#import "InregistrareCont.h"
#import "NetworkingHelper.h"

@interface MeniuDreapta () <FBLoginViewDelegate>

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *nume;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation MeniuDreapta

static int const FB_LOGIN_VIEW_TAG = 1;

@synthesize nume = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;
@synthesize profilePic = _profilePic;
@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.tag = FB_LOGIN_VIEW_TAG;
    loginview.frame = CGRectOffset(loginview.frame, 50, 375);
    
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
    
    if (!(FBSession.activeSession.isOpen)) {
        
        [tv1 setHidden:YES];
        
    }
    
    else {
        
        [tv1 setHidden:NO];
        [img setHidden:YES];
        [btn1 setHidden:YES];
        [btn2 setHidden:YES];
        
    }
    
    self.section1 = [NSArray arrayWithObjects:@"Top 5 utilizatori", @"Utilizator 1", @"Utilizator 2", @"Utilizator 3", @"Utilizator 4", @"Utilizator 5", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"",@"290", @"275", @"247", @"200", @"190", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
    
    _profilePic.clipsToBounds = YES;
    _profilePic.layer.cornerRadius = 50.0f;
    
    img.clipsToBounds = YES;
    img.layer.cornerRadius = 50.0f;
    
    [NetworkingHelper fetchLeaderBoard:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* response = (NSDictionary*) responseObject;
        NSMutableArray* leaderboardRows = [response objectForKey:@"rows"];
        NSMutableArray* names = [[NSMutableArray alloc] init];
        NSMutableArray* scores = [[NSMutableArray alloc] init];
        for (NSDictionary* row in leaderboardRows) {
            NSString* name = [row objectForKey:@"value"];
            NSString* score = [row objectForKey:@"key"];
            if (nil != name && nil != score) {
                [names addObject:name];
                [scores addObject:score];
            }
        }
        self.section1 = names;
        self.section2 = scores;
        self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
        [tv1 reloadData];
        
        [tv1 setHidden:NO];
        [img setHidden:YES];
        [btn1 setHidden:YES];
        [btn2 setHidden:YES];
        [nu setHidden:YES];
        [esti setHidden:YES];
        [auth setHidden:YES];
        FBLoginView *fbLoginView = (FBLoginView*)[self.view viewWithTag:FB_LOGIN_VIEW_TAG];
        [fbLoginView setHidden:YES];
    } failure:
     ^(AFHTTPRequestOperation* operation, NSError* error) {
         NSLog(@"%@", [error debugDescription]);
     }];
}

- (void)viewDidUnload {
    self.nume = nil;
    self.loggedInUser = nil;
    self.profilePic = nil;
    [super viewDidUnload];
}

- (IBAction)auth {
    

    
        Autentificare * view = [[Autentificare alloc] initWithNibName:@"Autentificare" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
            

    
}

- (IBAction)inregCont {
    

    
        InregistrareCont * view = [[InregistrareCont alloc] initWithNibName:@"InregistrareCont" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        

    
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
    
    [tv1 setHidden:NO];
    [img setHidden:YES];
    [btn1 setHidden:YES];
    [btn2 setHidden:YES];
    
    [nu setHidden:YES];
    [esti setHidden:YES];
    [auth setHidden:YES];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {

    self.profilePic.profileID = nil;
    self.nume.text = @"Guest User";
    self.loggedInUser = nil;
    
    [tv1 setHidden:YES];
    [img setHidden:NO];
    [btn1 setHidden:NO];
    [btn2 setHidden:NO];
    
    [nu setHidden:NO];
    [esti setHidden:NO];
    [auth setHidden:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

- (IBAction)dismissThisView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    tableView.separatorColor = [UIColor clearColor];
    
    if (indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            cell.backgroundColor = [UIColor blackColor];
            cell.backgroundView.backgroundColor = [UIColor blackColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            
        }
        
        else {
            
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            
        }
    }
    
}

@end
