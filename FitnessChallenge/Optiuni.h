//
//  Optiuni.h
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface Optiuni : UIViewController<RNFrostedSidebarDelegate> {
    
    IBOutlet UISwitch *toggleMusic;
    IBOutlet UISwitch *toggleSoundAlerts;
    IBOutlet UISwitch *toggleNotifications;
    IBOutlet UILabel *appVersion;
    
}

@end
