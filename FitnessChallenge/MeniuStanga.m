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


- (void) awakeFromNib {
    
    self.section = [NSArray arrayWithObjects:@"Ecran principal", @"Contul meu", @"Optiuni", @"Recompense", @"Test", nil];
    
    self.menu = [NSArray arrayWithObjects:self.section, nil];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
    [self.slidingViewController setAnchorRightRevealAmount:250.0f];
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
    
    return cell;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        
        return @"Navigatie";

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
