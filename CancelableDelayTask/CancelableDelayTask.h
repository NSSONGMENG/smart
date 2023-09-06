//
//  CancelableDelayTask.h
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//
//  利用gcd相关api封装方便取消的任务，解决传统认知里dispatch_after不能cancel的问题
//
//  知识点：
//  使用dispatch_block_create()创建的block对象，如果被cancel，则无论after或async多少次都不会再被执行，因为该对象已经被标记为“canceled”
//
//  CancelableDelayTask更符合常规的block定义习惯，事务与对象绑定，更符合日常编码习惯，调用过cancel的CancelableDelayTask对象任务不会再执行。
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CancelableDelayTask : NSObject

/// 创建一个延时任务
/// - Parameters:
///   - block: 任务块，内部会使用dispatch_block_create()创建一个基于block新对象，因此cancel只影响新创建的block而不影响参数提供的block对象
///   - interval: 延时
///   - queue: 任务执行队列，默认为main
+ (instancetype)CancelableDelayTask:(dispatch_block_t)block delay:(CFTimeInterval)interval queue:(dispatch_queue_t)queue;

/// 取消执行
- (void)cancel;

/// 立即执行并取消delay
- (void)doImmediatelyAndCancelDelay;

- (BOOL)isCanceled;

@end

NS_ASSUME_NONNULL_END
