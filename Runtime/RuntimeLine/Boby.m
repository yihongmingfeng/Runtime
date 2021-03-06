//
//  Boby.m
//  Runtime
//
//  Created by 游峰 on 16/4/11.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "Boby.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@implementation Boby
// 1. 我是拒绝的 不动态添加方法， 返回NO 进入2
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}
// 2. 我再次拒绝，不指定备选对象响应aselector，进入3
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}
// 3. 我还是拒绝，给他返回方法选择器， 进入4
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"eating"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
// 4. 算了，答应了，但是不能这么爽快，不然，修改调用对象
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(changeMagic)];
    [anInvocation invokeWithTarget:self];
}
// 如果forwardInvocation没实现，就会调用这个方法
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"消息处长不干了: %@", NSStringFromSelector(aSelector));
}
- (void)changeMagic
{
    NSLog(@"变魔法。。。。");
}


@end


