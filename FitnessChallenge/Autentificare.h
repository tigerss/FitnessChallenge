//
//  Autentificare.h
//  FitnessChallenge
//
//  Created by Cristian on 11/12/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface Autentificare : UIViewController <RNFrostedSidebarDelegate>{
    
    IBOutlet UIButton *butonAutentificare;
    
    IBOutlet UITextField *email;
    IBOutlet UITextField *pass;
    IBOutlet UILabel *warning;
    
}

@end
