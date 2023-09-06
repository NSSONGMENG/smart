//
//  ChainedTask.m
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//

#import "ChainedTask.h"

@interface ChainedTask()

@property (nonatomic, assign) dispatch_queue_t  mainTaskQueue;
@property (nonatomic, copy) dispatch_block_t    mainBlock;
@property (nonatomic, copy) dispatch_block_t    lastBlock;

@end

@implementation ChainedTask

+ (instancetype)instanceWithMainAction:(dispatch_block_t)task queue:(dispatch_queue_t)queue {
    ChainedTask  *instance = [self new];
    instance.lastBlock = dispatch_block_create(0, task);
    instance.mainBlock = instance.lastBlock;
    instance.mainTaskQueue = queue;
    
    return instance;
}

- (void)addAction:(dispatch_block_t)task toQueue:(dispatch_queue_t)queue {
    dispatch_queue_t q = queue ?: dispatch_get_main_queue();
    task = dispatch_block_create(0, task);
    dispatch_block_notify(_lastBlock, q, task);
    _lastBlock = task;
}

- (void)start {
    dispatch_queue_t q = _mainTaskQueue ?: dispatch_get_main_queue();
    dispatch_async(q, _mainBlock);
}

@end
