//
//  PTRouter.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTRouterURL.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PTRouterVCProtocol
- (instancetype)initWithParam:(NSDictionary *)param;
@optional
- (BOOL)presentingSelf;
@end

@interface PTRouter : NSObject
+ (void)registerURL:(NSString *)url hander:(void (^)(PTRouterURL* routeURL, void (^callback)(BOOL result)))hander;
+ (void)unRegisterURL:(NSString *)url;
+ (void)openURL:(NSString *)url callback:(void (^)(BOOL result))callback;
+ (BOOL)openURL:(NSString *)url;
+ (void)openURL:(NSString *)url param:(NSDictionary<NSString*,id> * __nullable)param callback:(void (^)(BOOL result))callback;
+ (BOOL)openURL:(NSString *)url param:(NSDictionary<NSString *,id> * __nullable)param;

@end

NS_ASSUME_NONNULL_END
