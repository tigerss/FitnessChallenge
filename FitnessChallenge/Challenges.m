//
//  Challenges.m
//  FitnessChallenge
//
//  Created by Cristian on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Challenges.h"
#import "Test.h"
#import "Antrenament.h"
#import "Recompense.h"
#import "Optiuni.h"
#import "MeniuDreapta.h"
#import "DatabaseHelper.h"
#import "DatabaseTables.h"
#import "FitnessChallenge.h"
#import "MeniuDreaptaRegUsr.h"
#import "ChallengePushUps.h"

@interface Challenges ()

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation Challenges

@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:3];
    
    self.section1 = [NSArray arrayWithObjects:@"Push-Ups",
                     @"Jumping Jacks",
                     @"Mountain Climbers",
                     @"Planks (With Rotation)",
                     @"Triceps Dips",
                     @"Burpees",
                     @"Bodyweight Squats",
                     @"High Knee Drills",
                     @"Double Crunches",
                     @"Triceps Dips", nil];

    NSInteger randomNumber0 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber1 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber2 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber3 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber4 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber5 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber6 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber7 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber8 = (arc4random() % 90000000) + 10000000;
    NSInteger randomNumber9 = (arc4random() % 90000000) + 10000000;
    
    self.section2 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"created by guest%i",randomNumber0],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber1],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber2],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber3],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber4],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber5],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber6],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber7],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber8],
                     [NSString stringWithFormat:@"created by guest%i",randomNumber9],
                     nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
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
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
    
    if(indexPath.row %3==0) {
        UIImage *image = [UIImage imageNamed:@"open.png"];
        CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
        UIGraphicsBeginImageContext(rect.size);
        [image drawInRect:rect];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        cell.imageView.image = img;
        cell.userInteractionEnabled = YES;
    }
    else {
        UIImage *image = [UIImage imageNamed:@"taken.png"];
        CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
        UIGraphicsBeginImageContext(rect.size);
        [image drawInRect:rect];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        cell.imageView.image = img;
        cell.userInteractionEnabled = NO;
    }
    
    cell.imageView.layer.masksToBounds = YES;
    
    cell.imageView.layer.cornerRadius = 24.0;
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
    [cell setSelectedBackgroundView:bgColorView];
    
    UIGraphicsEndImageContext();
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row %2==0)
        cell.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:62.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    else
        cell.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:73.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
        
    if([selectedCell.textLabel.text isEqualToString:@"Push-Ups"]) {
        
        ChallengePushUps * view = [[ChallengePushUps alloc] initWithNibName:@"ChallengePushUps" bundle:nil];
        view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:view animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
