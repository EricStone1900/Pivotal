//
//  PTInvocationHelper.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TLInvocationDomain @"com.PTInvocationHelper.performClass"

typedef NS_ENUM(NSInteger,PTInvocationError) {
    PTInvocationError_No_Class,
    PTInvocationError_No_Selector,
    PTInvocationError_Param_Unmatch,
};


NS_ASSUME_NONNULL_BEGIN

@interface PTInvocationHelper : NSObject

//失败时返回NSError，成功时返回nil或value
+ (id _Nullable)performClass:(NSString * _Nonnull)className selector:(nonnull SEL)selector params:(NSDictionary *_Nullable)params;
+ (id _Nullable)performInstance:(id _Nonnull)instance selector:(nonnull SEL)selector params:(NSDictionary *_Nullable)params;

@end

NS_ASSUME_NONNULL_END
