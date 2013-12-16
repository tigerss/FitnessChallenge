//
//  ChallengeSomebody.h
//  FitnessChallenge
//
//  Created by Cristian on 12/16/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ChallengeSomebody : UIViewController <RNFrostedSidebarDelegate,UITableViewDataSource,UITableViewDelegate>
    
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
