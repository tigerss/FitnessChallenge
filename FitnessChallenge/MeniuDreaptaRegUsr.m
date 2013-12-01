//
//  MeniuDreaptaRegUsr.m
//  FitnessChallenge
//
//  Created by Cristian on 11/25/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreaptaRegUsr.h"

@interface MeniuDreaptaRegUsr ()

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@end

@implementation MeniuDreaptaRegUsr

@synthesize menu1, section1, section2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.section1 = [NSArray arrayWithObjects:@"Abandoned training sessions", @"Completed training sessions", @"Abandoned workouts", @"Completed workouts", @"Hours spent during trainings", @"Hours spent during workouts", @"Determination score", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"5",@"7", @"1", @"4", @"6", @"11", @"64/100", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissThisView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
            UIFont *myFont = [ UIFont fontWithName: @"Helvetica Neue" size: 15.0 ];
    
            cell.textLabel.font  = myFont;
            cell.detailTextLabel.font = myFont;
    
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
    
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            cell.userInteractionEnabled = NO;
    
    return cell;
    
}

@end
