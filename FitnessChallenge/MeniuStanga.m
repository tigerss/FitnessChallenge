//
//  MeniuStanga.m
//  SlideMenu
//
//  Created by Kyle Begeman on 1/13/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "MeniuStanga.h"
#import "ECSlidingViewController.h"

@interface MeniuStanga ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section;

@end

@implementation MeniuStanga

@synthesize menu, section;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    self.section = [NSArray arrayWithObjects:@"FitnessChallenge", @"Antrenament", @"Recompense", @"Test", @"Optiuni", nil];
    
    self.menu = [NSArray arrayWithObjects:self.section, nil];
        
    [self.slidingViewController setAnchorRightRevealAmount:260.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        
        return [self.section count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
        
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section objectAtIndex:indexPath.row]];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    if(indexPath.row == 0) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:29];
        
    }
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *newTopViewController;
        
    NSString *identifier = [NSString stringWithFormat:@"%@", [self.section objectAtIndex:indexPath.row]];
        
    newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
        
}

@end
