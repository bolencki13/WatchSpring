//
//  ViewController.h
//  WatchSpring
//
//  Created by Brian Olencki on 8/25/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UILabel *lblDescription;
    UILabel *lblDescription2;
    
    UIButton *btnRespring;
    UIButton *btnReboot;
    UIButton *btnMore;
    
    UIView *viewMenu;
    
    UIButton *btnShutDown;
    UIButton *btnToggleSound;
    
    UIDynamicAnimator *dynamicAnimator;
}
- (void)showExtraMenuSwitch:(BOOL)arg1;
- (void)registerNotifications;
- (void)respring;
- (void)reboot;
- (void)shutDown;
- (void)toggleSound;
@end

