//
//  PTRouterURL.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTRouterURL : NSURL
@property (nonatomic, copy, readonly) NSString *urlWithoutParms;
@property (nonatomic, strong, readonly) NSDictionary<NSString *,id> *params;

+ (instancetype)URLWithString:(NSString *)URLString params:(NSDictionary<NSString *,id> * __nullable)params;

@end

NS_ASSUME_NONNULL_END
