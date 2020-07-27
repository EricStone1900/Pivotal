//
//  PTAppLaunchHelper.h
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AppLaunchProtocol
- (void)initializeWhenLaunch;
@end


@protocol IoCObjectProtocol
- (instancetype)initWithParam:(NSDictionary *)param;
@end


NS_ASSUME_NONNULL_BEGIN
/*
AutoInitialize.plist
classes
       item0 classA
       item1  classB
*/
@interface PTAppLaunchHelper : NSObject
@property (nonatomic, strong, readonly) dispatch_queue_t launchQueue;
@property (nonatomic, class, readonly) PTAppLaunchHelper* shared;

//init modules with AutoInitialize
- (void)autoInitModule;
//init url with AutoRegistURL
- (void)autoRegistURL;
@end

NS_ASSUME_NONNULL_END
