//
//  PTAppEventBus+registerEvent.h
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTAppEventBus.h"
//默认八种通知无法满足可以再这里自行添加新的东西
//不过最好有专人维护 PTAppEventBus 组件，这里只是一个参考
extern NSString * _Nonnull const KDidChangeStatusBarOrientation;
NS_ASSUME_NONNULL_BEGIN

@interface PTAppEventBus (registerEvent)
@property (nonatomic, strong) NSNotification * didChangeStatusBarOrientation;

@end

NS_ASSUME_NONNULL_END
