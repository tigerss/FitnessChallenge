//
//  MeniuDreapta.h
//  FitnessChallenge
//
//  Created by Cristian on 10/30/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MeniuDreapta : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tv1;
    IBOutlet UIImageView *img;
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    
    IBOutlet UILabel *nu;
    IBOutlet UILabel *esti;
    IBOutlet UILabel *auth;
}

@end
