//
//  AppDelegate.m
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "AppDelegate.h"
#import "PTAppEventBus.h"
#import "PTAppLaunchHelper.h"
#import "PTRouter.h"
#import "PTAppEventBus+registerEvent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [PTAppLaunchHelper.shared autoInitModule];//根据AutoInitialize.plist 自动初始化组件
    [PTAppLaunchHelper.shared autoRegistURL];//根据AutoRegistURL.plist 自动初始化路由
    
    NSMutableDictionary *defaultMap = [NSMutableDictionary dictionaryWithDictionary:[PTAppEventBus defaultNotificationMap]];
    [defaultMap setObject:KDidChangeStatusBarOrientation forKey:UIApplicationWillChangeStatusBarOrientationNotification];
    [PTAppEventBus.shared startWithNotificationMap:defaultMap];//开启EventBus，开启后组件可收到App生命周期事件
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [PTRouter openURL:[url path]]; //路由
}

@end
