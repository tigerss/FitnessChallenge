//
//  MeniuDreapta.m
//  FitnessChallenge
//
//  Created by Cristian on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "MeniuDreapta.h"
#import "ECSlidingViewController.h"

@interface MeniuDreapta ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@end

@implementation MeniuDreapta

@synthesize menu, section1, section2;


- (void) awakeFromNib {
    
    self.section1 = [NSArray arrayWithObjects:@"Informatie 1", @"Informatie 2", @"Informatie 3", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"Utilizator 1", @"Utilizator 2", @"Utilizator 3", nil];
    
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, nil];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.slidingViewController setAnchorLeftRevealAmount:250.0f];
    self.slidingViewController.underRightWidthLayout = ECFixedRevealWidth;
    
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
    if (section == 0)
        
        return [self.section1 count];
    
    else
        
        return [self.section2 count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        
    }
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        
    }
    
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0)
        
        return @"Statistici";
    
    else
        
        return @"Clasament";
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *newTopViewController;
    
    if (indexPath.section == 0) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
        [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
        
    }
}

@end
