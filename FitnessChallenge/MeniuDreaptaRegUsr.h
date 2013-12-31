//
//  MeniuDreaptaRegUsr.h
//  FitnessChallenge
//
//  Created by Cristian on 11/25/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkingHelper.h"

@interface MeniuDreaptaRegUsr : UIViewController {
    
    IBOutlet UILabel *notEnoughData;
    IBOutlet UISegmentedControl *segmentedControl;
    
}

    @property (nonatomic, strong) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) IBOutlet UIButton *FBconnect;
    @property (strong, nonatomic) IBOutlet UIButton *FBinvite;
    - (IBAction)changeSeg;
    - (IBAction)showFriendsAction:(id)sender;

@end
