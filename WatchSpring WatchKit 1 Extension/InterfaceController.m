//
//  InterfaceController.m
//  WatchSpring WatchKit 1 Extension
//
//  Created by Brian Olencki on 8/25/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"Context");
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"Visible");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - UIButton Events
- (IBAction)respring {
    NSLog(@"Respring");
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.bolencki13.watchspring-respring"), nil,  nil, YES);
}

- (IBAction)reboot {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.bolencki13.watchspring-reboot"), nil,  nil, YES);
}
@end



