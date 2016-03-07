//
//  ViewController.m
//  WatchSpring
//
//  Created by Brian Olencki on 8/25/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

#define SCREEN ([UIScreen mainScreen].bounds)
#define CENTER (CGPointMake(SCREEN.size.width/2,SCREEN.size.height/2))
@interface UIColor (FlatColor)
typedef enum {
    MidnightBlue =  0x2c3e50,
    EbonyClay =  0x22313F,
    ButterCup =  0xF39C12,
    WhiteSmoke =  0xECECEC,
    OldBrick =  0x96281B,
} Colors;
+ (UIColor *)flat:(Colors) color;
@end
@implementation UIColor (FlatColor)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
+ (UIColor *)flat:(Colors) color {
    return UIColorFromRGB(color);
}
@end

@class ViewController;
void respringDevice() {
    [[[ViewController alloc] init] respring];
}

void rebootDevice() {
    [[[ViewController alloc] init] reboot];
}

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.view.backgroundColor = [UIColor flat:MidnightBlue];
    
    [self registerNotifications];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, 50)];
    lblTitle.font = [UIFont systemFontOfSize:48];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor flat:WhiteSmoke];
    lblTitle.text = @"WatchSpring";
    lblTitle.center = CGPointMake(CENTER.x, 80);
    [self.view addSubview:lblTitle];
    
    UIImageView *imgViewWatch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, 100)];
    imgViewWatch.image = [UIImage imageNamed:@"watch.png"];
    [imgViewWatch sizeToFit];
    imgViewWatch.alpha = 0.5;
    imgViewWatch.center = CGPointMake(CENTER.x, CENTER.y);
    [self.view addSubview:imgViewWatch];
    [self.view sendSubviewToBack:imgViewWatch];
    
    UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 175, 25)];
    lblStatus.textColor = [UIColor flat:OldBrick];
    lblStatus.text = @"Not Connected";
    lblStatus.hidden = YES;
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        [session activateSession];
        if (session.paired) {
            lblStatus.text = @"Connected";
            lblStatus.hidden = NO;
        }
    }
    lblStatus.textAlignment = NSTextAlignmentCenter;
    lblStatus.backgroundColor = [UIColor flat:WhiteSmoke];
    lblStatus.layer.cornerRadius = lblStatus.frame.size.height/2;
    lblStatus.layer.masksToBounds = YES;
    [self.view addSubview:lblStatus];
    lblStatus.center = CGPointMake(CENTER.x, imgViewWatch.frame.origin.y+25);

    lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, 35)];
    lblDescription.font = [UIFont systemFontOfSize:28];
    lblDescription.textAlignment = NSTextAlignmentCenter;
    lblDescription.textColor = [UIColor flat:WhiteSmoke];
    lblDescription.text = @"Respring, Reboot, and More";
    lblDescription.adjustsFontSizeToFitWidth = YES;
    lblDescription.center = CGPointMake(CENTER.x, imgViewWatch.frame.origin.y+imgViewWatch.frame.size.height-75);
    [self.view addSubview:lblDescription];
    
    lblDescription2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, 50)];
    lblDescription2.font = [UIFont systemFontOfSize:18];
    lblDescription2.textAlignment = NSTextAlignmentCenter;
    lblDescription2.textColor = [UIColor flat:WhiteSmoke];
    lblDescription2.text = @"from your wrist";
    [lblDescription2 sizeToFit];
    lblDescription2.center = CGPointMake(CENTER.x, lblDescription.center.y+lblDescription.frame.size.height);
    [self.view addSubview:lblDescription2];
    
    btnRespring = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRespring addTarget:self action:@selector(respring) forControlEvents:UIControlEventTouchUpInside];
    [btnRespring setBackgroundColor:[UIColor flat:ButterCup]];
    [btnRespring setTitle:@"Respring" forState:UIControlStateNormal];
    [btnRespring setTitleColor:[UIColor flat:WhiteSmoke] forState:UIControlStateNormal];
    [btnRespring setFrame:CGRectMake(0, 0, 100, 35)];
    [btnRespring.layer setCornerRadius:btnRespring.frame.size.height/2];
    [btnRespring setCenter:CGPointMake(CENTER.x-btnRespring.frame.size.width, lblDescription.center.y-50)];
    [btnRespring setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:btnRespring];
    
    btnReboot = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReboot addTarget:self action:@selector(reboot) forControlEvents:UIControlEventTouchUpInside];
    [btnReboot setBackgroundColor:[UIColor flat:ButterCup]];
    [btnReboot setTitle:@"Reboot" forState:UIControlStateNormal];
    [btnReboot setTitleColor:[UIColor flat:WhiteSmoke] forState:UIControlStateNormal];
    [btnReboot setFrame:CGRectMake(0, 0, 100, 35)];
    [btnReboot.layer setCornerRadius:btnRespring.frame.size.height/2];
    [btnReboot setCenter:CGPointMake(CENTER.x+btnReboot.frame.size.width, lblDescription.center.y-50)];
    [btnReboot setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:btnReboot];
    
    [self showExtraMenuSwitch:NO];
    
    UILabel *lblCopyright = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, 20)];
    lblCopyright.font = [UIFont systemFontOfSize:12];
    lblCopyright.textAlignment = NSTextAlignmentCenter;
    lblCopyright.textColor = [UIColor flat:WhiteSmoke];
    lblCopyright.text = @"© 2015-2016 bolencki13";
    [lblCopyright sizeToFit];
    lblCopyright.center = CGPointMake(CENTER.x, SCREEN.size.height-20);
    [self.view addSubview:lblCopyright];
}
- (void)showExtraMenuSwitch:(BOOL)arg1 {
    if (arg1 == YES) {
        btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMore addTarget:self action:@selector(moreOptions) forControlEvents:UIControlEventTouchUpInside];
        [btnMore setBackgroundColor:[UIColor flat:ButterCup]];
        [btnMore setTitle:@"+" forState:UIControlStateNormal];
        [btnMore setTitleColor:[UIColor flat:WhiteSmoke] forState:UIControlStateNormal];
        [btnMore setFrame:CGRectMake(0, 0, 35, 35)];
        [btnMore.layer setCornerRadius:btnMore.frame.size.height/2];
        [btnMore setCenter:CGPointMake(CENTER.x, lblDescription.center.y-50)];
        [btnMore setShowsTouchWhenHighlighted:YES];
        [self.view addSubview:btnMore];
    }
}

#pragma mark - Notification Setup
- (void)registerNotifications {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)respringDevice, CFSTR("com.bolencki13.watchspring-respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)rebootDevice, CFSTR("com.bolencki13.watchspring-reboot"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

#pragma mark - UIButton Events
- (void)respring {
    system("killall backboardd");
}
- (void)reboot {
    system("reboot");
}
- (void)shutDown {
    NSLog(@"Not Yet Implemented");
}
- (void)toggleSound {
    NSLog(@"Not Yet Implemented");
}
- (void)moreOptions {
    UIVisualEffectView *blurBackground = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurBackground.frame = SCREEN;
    blurBackground.alpha = 0.0;
    [self.view addSubview:blurBackground];
    
    viewMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width-100, SCREEN.size.width-50)];
    viewMenu.layer.cornerRadius = 20;
    viewMenu.layer.borderColor = [UIColor whiteColor].CGColor;
    viewMenu.layer.borderWidth = 1.0;
    viewMenu.layer.masksToBounds = YES;
    viewMenu.backgroundColor = [UIColor flat:OldBrick];
    viewMenu.center = CGPointMake(CENTER.x-SCREEN.size.width, CENTER.y);
    [self.view addSubview:viewMenu];
    
    btnShutDown = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShutDown addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [btnShutDown setBackgroundColor:[UIColor clearColor]];
    [btnShutDown.layer setBorderColor:[[UIColor flat:WhiteSmoke] CGColor]];
    [btnShutDown.layer setBorderWidth:1.0];
    [btnShutDown setTitle:@"Shut Down" forState:UIControlStateNormal];
    [btnShutDown setTitleColor:[UIColor flat:WhiteSmoke] forState:UIControlStateNormal];
    [btnShutDown setFrame:CGRectMake(0, 0, viewMenu.frame.size.width/2+0.5, 60)];
    [btnShutDown setShowsTouchWhenHighlighted:YES];
    btnShutDown.titleLabel.adjustsFontSizeToFitWidth = YES;
    [viewMenu addSubview:btnShutDown];
    
    btnToggleSound = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToggleSound addTarget:self action:@selector(toggleSound) forControlEvents:UIControlEventTouchUpInside];
    [btnToggleSound setBackgroundColor:[UIColor clearColor]];
    [btnToggleSound.layer setBorderColor:[[UIColor flat:WhiteSmoke] CGColor]];
    [btnToggleSound.layer setBorderWidth:1.0];
    [btnToggleSound setTitle:@"Toggle Sound" forState:UIControlStateNormal];
    [btnToggleSound setTitleColor:[UIColor flat:WhiteSmoke] forState:UIControlStateNormal];
    [btnToggleSound setFrame:CGRectMake(viewMenu.frame.size.width/2-0.5, 0, viewMenu.frame.size.width/2+0.5, 60)];
    [btnToggleSound setShowsTouchWhenHighlighted:YES];
    btnToggleSound.titleLabel.adjustsFontSizeToFitWidth = YES;
    [viewMenu addSubview:btnToggleSound];
    
    UITapGestureRecognizer *tgrDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTriggered:)];
    [blurBackground addGestureRecognizer:tgrDismiss];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:viewMenu snapToPoint:CENTER];
    snapBehavior.damping = 1.0;
    [dynamicAnimator addBehavior:snapBehavior];
    
    [UIView animateWithDuration:0.75 animations:^{
        blurBackground.alpha = 1.0;
    } completion:^(BOOL finished) {
        [dynamicAnimator removeAllBehaviors];
    }];
    
}

#pragma mark - Gesture Events
- (void)tapGestureTriggered:(UITapGestureRecognizer*)recognizer {
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:viewMenu snapToPoint:CGPointMake(CENTER.x+SCREEN.size.width, CENTER.y)];
    snapBehavior.damping = 1.0;
    [dynamicAnimator addBehavior:snapBehavior];
    
    [UIView animateWithDuration:0.5 animations:^{
        recognizer.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [recognizer.view removeFromSuperview];
        [viewMenu removeFromSuperview];
        [dynamicAnimator removeAllBehaviors];
    }];
}
@end
