//
//  NSObject+PTKVO.h
//  Pivotal
//
//  Created by song on 2020/7/20.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PTKVO)
typedef void(^PTObservingBlock)(id newValue);

- (void)observeWithBlock:(PTObservingBlock)block;
- (void)removeObserve;

- (void)addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(PTObservingBlock)block;
- (void)removeBlockObserver:(NSObject *)observer forKey:(NSString *)key;
 
@property (nonatomic, weak) id owner;
@property (nonatomic, strong) NSString* keyPath;

@end

NS_ASSUME_NONNULL_END
