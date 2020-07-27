//
//  AppDelegate.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define APPEDELEGATE       ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define APPWINDOW          [APPEDELEGATE window]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

