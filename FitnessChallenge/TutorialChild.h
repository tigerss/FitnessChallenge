//
//  APPChildViewController.h
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialChild : UIViewController {
    
    IBOutlet UILabel *screenNumber;
    IBOutlet UIImageView *image;
    IBOutlet UILabel *description;
    
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    
}

@property (assign, nonatomic) NSInteger index;

@end
