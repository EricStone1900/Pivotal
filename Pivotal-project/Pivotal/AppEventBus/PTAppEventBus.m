//
//  PTAppEventBus.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTAppEventBus.h"

@interface PTAppEventBus ()
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *notificaitonMap;
@end

NSString * const KDidEnterBackground = @"didEnterBackground";
NSString * const KWillEnterForeground = @"willEnterForeground";
NSString * const KDidFinishLaunch = @"didFinishLaunch";
NSString * const KDidBecomeActive = @"didBecomeActive";
NSString * const KWillResignActive = @"willResignActive";
NSString * const KDidReceiveMemoryWarning = @"didReceiveMemoryWarning";
NSString * const KWillTerminate = @"willTerminate";
NSString * const KSignificantTimeChange = @"significantTimeChange";

@implementation PTAppEventBus

+ (PTAppEventBus *)shared {
    static PTAppEventBus* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PTAppEventBus new];
    });
    
    return instance;
}


+ (NSDictionary *)defaultNotificationMap {
    return @{
             UIApplicationDidEnterBackgroundNotification:KDidEnterBackground,
             UIApplicationDidEnterBackgroundNotification:KWillEnterForeground,
             UIApplicationDidFinishLaunchingNotification:KDidFinishLaunch,
             UIApplicationDidBecomeActiveNotification:KDidBecomeActive,
             UIApplicationWillResignActiveNotification:KWillResignActive,
             UIApplicationDidReceiveMemoryWarningNotification:KDidReceiveMemoryWarning,
             UIApplicationWillTerminateNotification:KWillTerminate,
             UIApplicationSignificantTimeChangeNotification:KSignificantTimeChange,
             };
}


- (void)start {
    [self startWithNotificationMap:[PTAppEventBus defaultNotificationMap]];
}

- (void)startWithNotificationMap:(NSDictionary<NSString *,NSString *> *)map {
    if (!self.isRunning) {
        [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            
            NSNotification *defaultNotification = [[NSNotification alloc] initWithName:key object:nil userInfo:nil];
            defaultNotification.owner = self;
            defaultNotification.keyPath = [map objectForKey:key];
            [self setValue:defaultNotification forKey:[map objectForKey:key]];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEventNotification:) name:key object:nil];
        }];
        
        self.notificaitonMap = map;
    }
    else {
        NSLog(@"TLAppEventBus is running now , please call stop first");
    }
}

- (void)stop {
    if (self.isRunning) {
        NSNotificationCenter * nCenter = [NSNotificationCenter defaultCenter];
        [nCenter removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
        self.isRunning = NO;
    }
}

- (BOOL)isRunning {
    return _isRunning;
}

- (void)appEventNotification:(NSNotification *)notification {
    
    NSString *notifacationName = notification.name;
    notification.owner = self;
    notification.keyPath = [self.notificaitonMap objectForKey:notification.name];
    NSString *propName = [self.notificaitonMap objectForKey:notifacationName];
    if (propName) {
        [self setValue:notification forKey:propName];
    }
}


@end
