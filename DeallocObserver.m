//
//  DeallocObserver.m
//  ShadowDemo
//
//  Created by song.meng on 2023/9/6.
//  Copyright © 2023 MOMO. All rights reserved.
//

#import "DeallocObserver.h"
#import <objc/runtime.h>

@interface DeallocObserver()

@property (nonatomic, copy) void(^deallocating)(void);

@end

@implementation DeallocObserver

static const char kVChatDeallocObserverKey;

+ (void)observerTarget:(id)target deallocBlock:(void(^)(void))block {
    if (!target) return;
    
    DeallocObserver * instance = [self new];
    instance.deallocating = block;
    
    /// 因一个指针同时只能引用一个对象，故使用set保存所有的observer，避免同一个对象多次监听造成先前设置的observer提前释放的问题
    /// 此处未加锁，应避免多线程给某个对象设置dealloc监听的情况
    NSMutableSet *set = objc_getAssociatedObject(target, &kVChatDeallocObserverKey);
    if (!set) {
        set = [NSMutableSet set];
        objc_setAssociatedObject(target, &kVChatDeallocObserverKey, set, OBJC_ASSOCIATION_RETAIN);
    }
    
    [set addObject:instance];
}

- (void)dealloc {
    if (_deallocating) {
        _deallocating();
    }
}

@end
