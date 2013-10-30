//
//  TestViewController.h
//  FitnessChallenge
//
//  Created by Cristian on 10/27/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController {
    
    IBOutlet UILabel *secunde;
    IBOutlet UILabel *flotari;

    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
}
@end
