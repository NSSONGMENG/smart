//
//  ChainedTask.h
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//
//  使用gcd处理单链式任务依赖
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChainedTask : NSObject

/// 创建对象
/// - Parameters:
///   - task: 第一个任务
///   - queue: 任务执行的队列，默认为主队列
+ (instancetype)instanceWithMainAction:(dispatch_block_t)task queue:(dispatch_queue_t)queue;

/// 添加从属任务
/// - Parameters:
///   - task: 从属任务
///   - queue: 任务执行的队列，默认为主队列
- (void)addAction:(dispatch_block_t)task toQueue:(dispatch_queue_t)queue;

/// 开始执行任务链，该方法可延迟调用。若不调用，第一个任务main action不会执行
- (void)start;

@end

NS_ASSUME_NONNULL_END
