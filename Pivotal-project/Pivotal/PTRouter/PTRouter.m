//
//  PTRouter.m
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTRouter.h"

@interface PTRouter ()
@property (nonatomic, class, readonly) PTRouter * shared;
@property (nonatomic, strong) dispatch_queue_t syncQueue;
@property (nonatomic, strong) NSMutableDictionary<NSString *,void (^)(PTRouterURL* routeURL, void (^)(BOOL result))> *routeMap;
@end

@implementation PTRouter

+ (PTRouter *)shared {
    static PTRouter * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PTRouter new];
        instance.syncQueue = dispatch_queue_create("com.tlrouter.syncqueue", nil);
        instance.routeMap = [NSMutableDictionary new];
    });
    return instance;
}

+ (void)registerURL:(NSString *)url hander:(void (^)(PTRouterURL* routeURL, void (^callback)(BOOL result)))hander {
    PTRouterURL *tlUrl = [PTRouterURL URLWithString:url params:nil];
    NSAssert(tlUrl.urlWithoutParms!=nil, @"URL不合法");
    if (tlUrl.urlWithoutParms) {
        dispatch_async(PTRouter.shared.syncQueue, ^{
            [PTRouter.shared.routeMap setObject:hander forKey:tlUrl.urlWithoutParms];
        });
    }
}

+ (void)unRegisterURL:(NSString *)url {
    PTRouterURL *tlUrl = [PTRouterURL URLWithString:url params:nil];
    NSAssert(tlUrl.urlWithoutParms!=nil, @"URL不合法");
    if (tlUrl.urlWithoutParms) {
        dispatch_async(PTRouter.shared.syncQueue, ^{
            [PTRouter.shared.routeMap removeObjectForKey:tlUrl.urlWithoutParms];
        });
    }
}

+ (void)openURL:(NSString *)url callback:(void (^)(BOOL result))callback {
    [PTRouter openURL:url param:nil callback:callback];
}

+ (BOOL )openURL:(NSString *)url{
    BOOL reslut = [PTRouter openURL:url param:nil];
    return reslut;
}

+ (void)openURL:(NSString *)url param:(NSDictionary<NSString*,id> * __nullable)param callback:(void (^)(BOOL result))callback {
    PTRouterURL *tlUrl = [PTRouterURL URLWithString:url params:param];
    void (^block)(PTRouterURL* routeURL, void (^)(BOOL result)) = [PTRouter.shared.routeMap objectForKey:tlUrl.urlWithoutParms];
    if (block) {
        block(tlUrl,callback);
    }
    else {
        callback(false);
    }
}

+ (BOOL )openURL:(NSString *)url param:(NSDictionary<NSString *,id> * __nullable)param {
    PTRouterURL *tlUrl = [PTRouterURL URLWithString:url params:param];
    void (^block)(PTRouterURL* routeURL, void (^)(BOOL result)) = [PTRouter.shared.routeMap objectForKey:tlUrl.urlWithoutParms];
    __block BOOL reslut = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    void (^callback)(BOOL value) = ^(BOOL value) {
        reslut = value;
        dispatch_semaphore_signal(semaphore);
    };
    
    if (block) {
        block(tlUrl,callback);
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
    }
    
    return reslut;
}
@end
