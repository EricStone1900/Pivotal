//
//  PTAppEventBus+registerEvent.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Objc/runtime.h>
#import "PTAppEventBus+registerEvent.h"

NSString * const KDidChangeStatusBarOrientation = @"didChangeStatusBarOrientation";
@implementation PTAppEventBus (registerEvent)

- (void)setDidChangeStatusBarOrientation:(NSNotification *)didChangeStatusBarOrientation {
    objc_setAssociatedObject(self, (__bridge const void *)KDidChangeStatusBarOrientation , didChangeStatusBarOrientation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNotification *)didChangeStatusBarOrientation {
    return objc_getAssociatedObject(self, (__bridge const void *)KDidBecomeActive);
}

@end
