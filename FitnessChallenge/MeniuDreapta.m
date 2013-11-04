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
@property (strong, nonatomic) NSArray *section3;

@end

@implementation MeniuDreapta

@synthesize menu, section1, section2, section3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.section1 = [NSArray arrayWithObjects:@"Guest", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"Informatie 1", @"Informatie 2", @"Informatie 3", nil];
    
    self.section3 = [NSArray arrayWithObjects:@"Utilizator 1", @"Utilizator 2", @"Utilizator 3", @"Utilizator 4", @"Utilizator 5", nil];
    
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, self.section3, nil];
    
    [self.slidingViewController setAnchorLeftRevealAmount:260.0f];
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
    
    else if (section == 1)
        
        return [self.section2 count];
    
    else
        
        return [self.section3 count];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 2) {
        
        if(indexPath.row == 2) {
        
            cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.5 alpha:1.0];
        
            cell.textLabel.textColor = [UIColor whiteColor];
            
        }
        
    }
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
        
        cell.imageView.image = [UIImage imageNamed:@"bear.jpg"];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(cell.contentView.frame.size.width/2,10,100,20);
        [btn setTitle:@"Iesire" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
    }
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        
    }
    
    if (indexPath.section == 2) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        
    }

    
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 1)
        
        return @"Statistici";
    
    else if (section == 2)
        
        return @"Clasament";
    
    else
        
        return 0;
    
}

#pragma mark - Table view delegate

- (void)btnPressed:(UIButton *) sender {
    
    UIViewController *newTopViewController;
    
    newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Ecran principal"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
}

@end
