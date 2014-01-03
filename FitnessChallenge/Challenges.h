//
//  Challenges.h
//  FitnessChallenge
//
//  Created by Cristian on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface Challenges : UIViewController<RNFrostedSidebarDelegate,UITableViewDelegate, UITableViewDataSource> {

    BOOL isSearching;
    NSMutableArray *filteredSection1;
    NSMutableArray *filteredSection2;
    
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;
@property (strong, nonatomic) IBOutlet UITableView *tableView1;

@end
