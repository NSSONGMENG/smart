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
@property (nonatomic, copy) dispatch_block_t oriBlock;

@end

@implementation CancelableDelayTask

+ (instancetype)CancelableDelayTask:(void(^)(void))block delay:(CFTimeInterval)interval queue:(dispatch_queue_t)queue {
    CancelableDelayTask *instance = [self new];
    
    instance.oriBlock = block;
    instance.block = dispatch_block_create(0, block);
    dispatch_queue_t  q = queue ?: dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), q, instance.block);
    
    return instance;
}

- (void)cancel {
    if (self.block && (0 == dispatch_block_testcancel(self.block))) {
        // 多次cancel也没啥问题
        dispatch_block_cancel(self.block);
    }
    
    _oriBlock = nil;
}

- (void)doImmediatelyAndCancelDelay {
    [self cancel];

    if (_oriBlock) {
        _oriBlock();
        _oriBlock = nil;
    }
}

- (BOOL)isCanceled {
    return (1 == dispatch_block_testcancel(self.block));
}


@end
