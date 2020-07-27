//
//  NSObject+PTMap.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef id _Nullable(^PTMapBlock)(id _Nullable value);
@interface NSObject (PTMap)
- (_Nullable id)map:(PTMapBlock)block;
@end

NS_ASSUME_NONNULL_END
