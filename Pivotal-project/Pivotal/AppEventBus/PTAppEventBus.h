//
//  PTAppEventBus.h
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+PTKVO.h"

#define AppEventBus PTAppEventBus.shared

extern NSString * _Nonnull const KDidEnterBackground;
extern NSString * _Nonnull const KWillEnterForeground;
extern NSString * _Nonnull const KDidFinishLaunch;
extern NSString * _Nonnull const KDidBecomeActive;
extern NSString * _Nonnull const KWillResignActive;
extern NSString * _Nonnull const KDidReceiveMemoryWarning;
extern NSString * _Nonnull const KWillTerminate;
extern NSString * _Nonnull const KSignificantTimeChange;


NS_ASSUME_NONNULL_BEGIN

@interface PTAppEventBus : NSObject
@property (atomic, class ,readonly) PTAppEventBus* shared;
+ (NSDictionary *)defaultNotificationMap;
- (void)start;
- (void)startWithNotificationMap:(NSDictionary<NSString *,NSString *> *)map;
- (void)stop;
- (BOOL)isRunning;

@property (nonatomic, strong) NSNotification * didEnterBackground;
@property (nonatomic, strong) NSNotification * willEnterForeground;
@property (nonatomic, strong) NSNotification * didFinishLaunch;
@property (nonatomic, strong) NSNotification * didBecomeActive;
@property (nonatomic, strong) NSNotification * willResignActive;
@property (nonatomic, strong) NSNotification * didReceiveMemoryWarning;
@property (nonatomic, strong) NSNotification * willTerminate;
@property (nonatomic, strong) NSNotification * significantTimeChange;

@end

NS_ASSUME_NONNULL_END
