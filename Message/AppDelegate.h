//
//  AppDelegate.h
//  Message
//
//  Created by RAJESH BLAZE on Jan,31.
//
//

#import <UIKit/UIKit.h>
@class MailViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navigation;
@property (strong,nonatomic) MailViewController *mailVC;

@end
