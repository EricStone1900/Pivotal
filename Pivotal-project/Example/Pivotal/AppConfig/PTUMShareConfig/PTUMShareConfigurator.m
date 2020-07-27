//
//  PTUMShareConfigurator.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTUMShareConfigurator.h"
#import "PTAppLaunchHelper.h"
#import "PTAppEventBus.h"
#import "PTRouter.h"
#import <UMSocialCore/UMSocialCore.h>
#import "Pivotal-Swift.h"

@interface PTUMShareConfigurator () <AppLaunchProtocol>
@property (nonatomic, strong) NSString *appkey;

@property (nonatomic, strong) NSDictionary *qqConfigDict;
@property (nonatomic, strong) NSDictionary *weChatConfigDict;
@end

@implementation PTUMShareConfigurator

- (void)initializeWhenLaunch {
    NSDictionary *dict = [self dictWithPlist:@"AppConfigurator.plist"];
    [self safeSetValuesForKeys:[dict objectForKey:NSStringFromClass([self class])]];
    
    dispatch_async(PTAppLaunchHelper.shared.launchQueue, ^{
        // 设置友盟key
        NSAssert(self.appkey, @"缺少友盟[Umeng]配置");
        NSAssert(self.qqConfigDict, @"缺少友盟[QQ]配置");
        NSAssert(self.weChatConfigDict, @"缺少友盟[WeChat]配置");
        
        if (!self.appkey) {
            NSLog(@"缺少友盟[Umeng]配置");
            return;
        }
        
#if DEBUG
        /* 打开调试日志 */
        [[UMSocialManager defaultManager] openLog:YES];
#endif
        // 设置友盟appkey
        [[UMSocialManager defaultManager] setUmSocialAppkey:self.appkey];
        
        // 设置可选择的平台
        
        UMSocialPlatformType type;
        
        if (self.qqConfigDict) {
            type = UMSocialPlatformType_QQ;
            [self setSubPlatConfig:self.qqConfigDict type:type];
            
            NSString *qqScheme = [self.qqConfigDict objectForKey:@"scheme"];
            //注册
            [PTRouter registerURL:[qqScheme stringByAppendingString:@"://"] hander:^(PTRouterURL *routeURL, void (^callback)(BOOL result)) {
                BOOL result = [[UMSocialManager defaultManager] handleOpenURL:[NSURL URLWithString:routeURL.urlWithoutParms]];
                callback(result);
                
            }];
        }
        
        if (self.weChatConfigDict) {
            type = UMSocialPlatformType_WechatSession;
            [self setSubPlatConfig:self.weChatConfigDict type:type];
            
            NSString *wechatScheme = [self.weChatConfigDict objectForKey:@"scheme"];
            
            [PTRouter registerURL:wechatScheme hander:^(PTRouterURL *routeURL, void (^callback)(BOOL result)) {
                BOOL result = [[UMSocialManager defaultManager] handleOpenURL:[NSURL URLWithString:routeURL.urlWithoutParms]];
                callback(result);
                
            }];
        }
    });
    
}

- (void)setSubPlatConfig:(NSDictionary *)subPlatDict type:(UMSocialPlatformType)type {
    NSString *appKey = subPlatDict[@"appkey"];
    NSString *secret = subPlatDict[@"appsecret"];
    NSString *redirectUrl = subPlatDict[@"redirectUrl"];
    
    BOOL retVal = [[UMSocialManager defaultManager] setPlaform:type appKey:appKey appSecret:secret redirectURL:redirectUrl];
    if (retVal) {
        NSLog(@"友盟 [%ld]--->初始化成功", (long)type);
    }
}

@end
