//
//  Challenges.m
//  FitnessChallenge
//
//  Created by Cristian on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Challenges.h"

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
    
    self.section1 = [NSArray arrayWithObjects:@"User 1", @"User 2", @"User 3", @"User 4", @"User 5",  @"User 6", @"User 7", @"User 8", @"User 9", @"User 10", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"pending", @"completed", @"canceled", @"pending", @"completed", @"canceled", @"canceled", @"completed", @"pending", @"completed", nil];
    
    self.menu1 = [NSArray arrayWithObjects:self.section1, nil];
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        NSLog(@"received challenges");
    }
    else{
        //toggle the correct view to be visible
        NSLog(@"sent challenges");
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
    return 58;
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

    
    UIImage *image = [UIImage imageNamed:@"guest.jpg"];
    
    CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.imageView.image = img;
    
    cell.imageView.layer.masksToBounds = YES;
    
    cell.imageView.layer.cornerRadius = 24.0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userInteractionEnabled = NO;
    
    UIGraphicsEndImageContext();
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
            cell.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:73.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
    if([[self.section2 objectAtIndex:indexPath.row] isEqual:@"completed"])
            cell.detailTextLabel.textColor = [UIColor colorWithRed:243.0f/255.0f green:156.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
    if([[self.section2 objectAtIndex:indexPath.row] isEqual:@"pending"])
        cell.detailTextLabel.textColor = [UIColor colorWithRed:211.0f/255.0f green:84.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    if([[self.section2 objectAtIndex:indexPath.row] isEqual:@"canceled"])
        cell.detailTextLabel.textColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(challengeThisUser)
	 forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"accept" forState:UIControlStateNormal];
	button.frame = CGRectMake(195.0f, 15.0f, 55.0f, 30.0f);
    button.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
    [button setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    button.layer.cornerRadius = 5.0f;
	[cell addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button1 addTarget:self
			   action:@selector(challengeThisUser)
	 forControlEvents:UIControlEventTouchDown];
	[button1 setTitle:@"cancel" forState:UIControlStateNormal];
	button1.frame = CGRectMake(255.0f, 15.0f, 55.0f, 30.0f);
    button1.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
    [button1 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    button1.layer.cornerRadius = 5.0f;
	[cell addSubview:button1];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
