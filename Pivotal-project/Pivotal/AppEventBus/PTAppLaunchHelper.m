//
//  PTAppLaunchHelper.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTAppLaunchHelper.h"
#import "PTInvocationHelper.h"
#import "PTRouter.h"
NSString *const AutoInitializePlist = @"AutoInitialize.plist";
NSString *const AutoRegistURLPlist = @"AutoRegistURL.plist";

@interface PTAppLaunchHelper () {
    dispatch_queue_t _launchQueue;
    NSDictionary<NSString *,NSString*> *dict;
}
@end


@implementation PTAppLaunchHelper
@synthesize launchQueue = _launchQueue;

+(PTAppLaunchHelper *)shared {
    static PTAppLaunchHelper * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PTAppLaunchHelper new];
    });
    return instance;
}

-(dispatch_queue_t)launchQueue {
    if (!_launchQueue) {
        _launchQueue = dispatch_queue_create("com.appLaunch.quene", DISPATCH_QUEUE_CONCURRENT);
    }
    return _launchQueue;
}

-(void)autoInitModule {
    NSURL *url = [[NSBundle mainBundle] URLForResource:AutoInitializePlist withExtension:nil];
    if (url) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
        NSArray<NSString *> *classArr = [dict objectForKey:@"classes"];
        [classArr enumerateObjectsUsingBlock:^(NSString * _Nonnull className, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([className isKindOfClass:[NSString class]]) {
                [PTInvocationHelper performClass:className selector:@selector(initializeWhenLaunch) params:nil];
            }
            else {
                @throw [NSException exceptionWithName:NSInvalidArgumentException
                                               reason:@"className must be string"
                                             userInfo:nil];
            }
        }];
    }
}

-(void)autoRegistURL {
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:AutoRegistURLPlist withExtension:nil];
    if (fileUrl) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:fileUrl];
        
        [dict.allKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull url, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *urlConfig = [dict objectForKey:url];
            NSString *className = [urlConfig objectForKey:@"controller"];
            NSArray *params = [urlConfig objectForKey:@"params"];
            
            [PTRouter registerURL:url hander:^(PTRouterURL *routeURL, void (^callback)(BOOL result)) {
                BOOL result = NO;
                if ([self array:params isEqualTo:routeURL.params.allKeys]) {
                    id object = [PTInvocationHelper performClass:className selector:@selector(initWithParam:) params:routeURL.params];
                    
                    if ([[NSURL URLWithString:url].scheme isEqualToString:@"InnerJump"] && object) {
                        result = [[PTInvocationHelper performInstance:object selector:@selector(presentingSelf) params:nil] boolValue];
                    }
                    
                    else {
                        result = NO;
                    }
                }
                else {
                    NSAssert([self array:params isEqualTo:routeURL.params.allKeys], @"路由参数不匹配，请参照AutoRegistURL");
                }
                if (callback) {
                    callback(result);
                }
            }];
            
 
        }];
    }
}

- (BOOL)array:(NSArray *)array1 isEqualTo:(NSArray *)array2 {
    if (array1.count != array2.count) {
        return NO;
    }
    for (NSString *str in array1) {
        if (![array2 containsObject:str]) {
            return NO;
        }
    }
    return YES;
}

@end
