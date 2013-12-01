//
//  InregistrareCont.h
//  FitnessChallenge
//
//  Created by Cristian on 11/19/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface InregistrareCont : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UITextField *email;
    IBOutlet UITextField *pass;
    IBOutlet UITextField *prenume;
    IBOutlet UITextField *nume;
    IBOutlet UILabel *warning;
    
}

@end
