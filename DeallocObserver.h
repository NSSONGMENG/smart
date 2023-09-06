//
//  DeallocObserver.h
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//
//  原理：对象A唯一被B持有时，则B释放时会release A
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeallocObserver : NSObject

+ (void)observerTarget:(id)target deallocBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
