//
//  Inregistrare.m
//  FitnessChallenge
//
//  Created by Cristian on 10/28/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Inregistrare.h"
#import "ECSlidingViewController.h"
#import "MeniuStanga.h"
#import "MeniuDreapta.h"

@interface Inregistrare ()

@property (strong, nonatomic) NSArray *menu1;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;

@end

@implementation Inregistrare

@synthesize menu1, section1, section2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.section1 = [NSArray arrayWithObjects:@"Utilizator 1", @"Utilizator 2", @"Utilizator 3", @"Rezultatul meu", @"Utilizator 5", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"29", @"25", @"23", @"21", @"12", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeniuStanga class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuStanga"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MeniuDreapta class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MeniuDreapta"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fundal_antrenament.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    tw1.clipsToBounds = YES;
    tw1.layer.cornerRadius = 5.0f;
    
    tv1.clipsToBounds = YES;
    tv1.layer.cornerRadius = 5.0f;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenuLeft:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (IBAction)revealMenuRight:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ flotari", [self.section2 objectAtIndex:indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userInteractionEnabled = NO;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if(indexPath.row == 3) {
        
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
