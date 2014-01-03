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
#import "ChallengeCountdown.h"
#import "NetworkingHelper.h"

@interface Challenges ()

@property (strong, nonatomic) NSMutableArray *section1;
@property (strong, nonatomic) NSMutableArray *section2;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation Challenges

@synthesize section1, section2;
@synthesize searchBar;
@synthesize searchBarController;
@synthesize tableView1;

User* user;
NSMutableArray* challenges;
NSMutableArray* filteredChallenges;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    challenges = [[NSMutableArray alloc]init];
    filteredChallenges = [[NSMutableArray alloc]init];
    filteredSection1 = [[NSMutableArray alloc] init];
    filteredSection2 = [[NSMutableArray alloc] init];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:3];
    self.section1 = [[NSMutableArray alloc]init];
    self.section2 = [[NSMutableArray alloc]init];
    
    [self configureSearchBarView:[self searchBar]];
    
    user = [[DatabaseHelper selectUsers] objectAtIndex:0];
    
    [NetworkingHelper fetchChallenges:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary* response = (NSDictionary*) responseObject;
            NSArray* rows = (NSArray*) [response objectForKey:@"rows"];
            for (NSDictionary* row in rows) {
                NSDictionary* doc = (NSDictionary*) [row objectForKey:@"doc"];
                PublicChallenge* challenge = [PublicChallenge fromDictionary:doc];
                [self.section1 addObject:[challenge exerciseName]];
                [self.section2 addObject:[challenge challengerUsername]];
                [challenges addObject:challenge];
            }
            
            [tableView1 reloadData];
        }
        @catch (NSException *exception) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [exception debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [error debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } includeDocs:YES];
}

- (void)configureSearchBarView:(UIView*)view {
    for (UIView *subview in [view subviews]){
        [self configureSearchBarView:subview];
    }
    if ([view conformsToProtocol:@protocol(UITextInputTraits)]) {
        [(UITextField *)view setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (isSearching) {
        return [filteredChallenges count];
    }
    else {
        return [challenges count];
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (isSearching) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [filteredSection1 objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"created by %@", [filteredSection2 objectAtIndex:indexPath.row]];
        
        if ([indexPath row] < [filteredChallenges count]) {
            PublicChallenge* current = [filteredChallenges objectAtIndex:[indexPath row]];
            if ([current isOpen]) {
                UIImage *image = [UIImage imageNamed:@"open.png"];
                CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
                UIGraphicsBeginImageContext(rect.size);
                [image drawInRect:rect];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                cell.imageView.image = img;
                cell.userInteractionEnabled = YES;
            } else {
                UIImage *image = [UIImage imageNamed:@"taken.png"];
                CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
                UIGraphicsBeginImageContext(rect.size);
                [image drawInRect:rect];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                cell.imageView.image = img;
                cell.userInteractionEnabled = NO;
            }
        }
        
    }
    else {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"created by %@", [self.section2 objectAtIndex:indexPath.row]];
        if ([indexPath row] < [challenges count]) {
            PublicChallenge* current = [challenges objectAtIndex:[indexPath row]];
            if ([current isOpen]) {
                UIImage *image = [UIImage imageNamed:@"open.png"];
                CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
                UIGraphicsBeginImageContext(rect.size);
                [image drawInRect:rect];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                cell.imageView.image = img;
                cell.userInteractionEnabled = YES;
            } else {
                UIImage *image = [UIImage imageNamed:@"taken.png"];
                CGRect rect = CGRectMake(0.0, 0.0, 48, 48);
                UIGraphicsBeginImageContext(rect.size);
                [image drawInRect:rect];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                cell.imageView.image = img;
                cell.userInteractionEnabled = NO;
            }
        }

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
    
    PublicChallenge* selectedChallenge = [challenges objectAtIndex:[indexPath row]];
    
    if(isSearching)
        selectedChallenge = [filteredChallenges objectAtIndex:[indexPath row]];
    
    if ([[selectedChallenge challengerUsername] isEqualToString: [user username]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [selectedChallenge exerciseName] message: @"This is a challenge created by you. Maybe you can invite a friend but, sadly, there is no invite button yet." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    [selectedChallenge setChallengeeUsername: [user username]];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"challengeExerciseName"] != selectedCell.textLabel.text) {
        [standardDefaults setObject:[NSString stringWithFormat:@"%@",selectedCell.textLabel.text] forKey:@"challengeExerciseName"];
        [standardDefaults synchronize];
    }
    
    ChallengeCountdown * view = [[ChallengeCountdown alloc] initWithNibName:@"ChallengeCountdown" bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [view setChallenge:selectedChallenge];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)searchTableList {
    NSString *searchString = searchBar.text;

    [NetworkingHelper fetchChallenges:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary* response = (NSDictionary*) responseObject;
            NSArray* rows = (NSArray*) [response objectForKey:@"rows"];
            for (NSDictionary* row in rows) {
                NSDictionary* doc = (NSDictionary*) [row objectForKey:@"doc"];
                PublicChallenge* challenge = [PublicChallenge fromDictionary:doc];
                NSComparisonResult result = [[challenge challengerUsername] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
                if (result == NSOrderedSame) {
                    [filteredSection1 addObject:[challenge exerciseName]];
                    [filteredSection2 addObject:[challenge challengerUsername]];
                    [filteredChallenges addObject:challenge];
                }
            }
            
            [tableView1 reloadData];
        }
        @catch (NSException *exception) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [exception debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: [error debugDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } includeDocs:YES];

}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    [filteredSection1 removeAllObjects];
    [filteredSection2 removeAllObjects];
    [filteredChallenges removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [tableView1 reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchTableList];
}

- (void)viewDidUnload {
    [self setTableView1:nil];
    [self setSearchBar:nil];
    [self setSearchBarController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
