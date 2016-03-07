//
//  InterfaceController.h
//  WatchSpring WatchKit 1 Extension
//
//  Created by Brian Olencki on 8/25/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
- (IBAction)respring;
- (IBAction)reboot;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnReboot;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnRespring;
@end
