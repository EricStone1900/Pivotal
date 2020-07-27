//
//  PTRouterURL.m
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTRouterURL.h"

@interface PTRouterURL() {
    NSString* _urlWithoutParms;
    NSDictionary<NSString *,NSString*>* _params;
}
@end

@implementation PTRouterURL

+ (instancetype)URLWithString:(NSString *)URLString params:(NSDictionary<NSString *,id> * __nullable)params {
    PTRouterURL *url = [PTRouterURL URLWithString:URLString];
    [url initializeWithParam:params];
    return url;
}

- (void)initializeWithParam:(NSDictionary<NSString *,id> * __nullable)params {
    
    if (self.scheme || self.host) {
        NSString *relativePath = [self.host stringByAppendingString:self.relativePath];
        _urlWithoutParms = [[self.scheme stringByAppendingString:@"://"] stringByAppendingString:(relativePath==nil?@"":relativePath)];
    }

    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSArray<NSString*> *arr = [self.query componentsSeparatedByString:@"&"];
    
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *temp =  [obj componentsSeparatedByString:@"="];
        if (temp.count == 2) {
            [dict setObject:temp.lastObject forKey:temp.firstObject];
        }
    }];
    
    _params = [[NSDictionary alloc] initWithDictionary:dict copyItems:NO];
    
    if (params) {
        [_params setValuesForKeysWithDictionary:params];
    }
}


@end
