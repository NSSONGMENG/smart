//
//  CancelableDelayTask.m
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//

#import "CancelableDelayTask.h"

@interface CancelableDelayTask()

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation CancelableDelayTask

/// 创建一个延时任务
/// - Parameters:
///   - block: 任务块
///   - interval: 延时
///   - queue: 任务执行队列，默认为main
+ (instancetype)CancelableDelayTask:(void(^)(void))block delay:(CFTimeInterval)interval queue:(dispatch_queue_t)queue {
    CancelableDelayTask *instance = [self new];
    
    instance.block = dispatch_block_create(0, block);
    dispatch_queue_t  q = queue ?: dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), q, instance.block);
    
    return instance;
}

/// 取消执行
- (void)cancel {
    if (self.block && (0 == dispatch_block_testcancel(self.block))) {
        // 多次cancel也没啥问题
        dispatch_block_cancel(self.block);
    }
}

@end
