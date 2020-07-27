//
//  NSObject+PTMap.m
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "NSObject+PTMap.h"

@implementation NSObject (PTMap)


- (id)map:(PTMapBlock)block {
    NSParameterAssert(block);
    if (block) {
        id ret = block(self);
        return ret;
    }
    return nil;
}


@end
