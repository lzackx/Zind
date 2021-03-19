//
//  FlutterEngine+Zind.m
//  Zind
//
//  Created by lzackx on 2021/3/17.
//

#import "FlutterEngine+Zind.h"
#import <objc/runtime.h>
#import "ZindWeakAssociatedObjectContainer.h"
#import "ZindEngineMember.h"

@implementation FlutterEngine (Zind)

- (void)setEngineMember:(ZindEngineMember *)engineMember {
	ZindWeakAssociatedObjectContainer *container = [ZindWeakAssociatedObjectContainer new];
	container.object = engineMember;
	objc_setAssociatedObject(self, @selector(engineMember), container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZindEngineMember *)engineMember {
	ZindWeakAssociatedObjectContainer *container = objc_getAssociatedObject(self, _cmd);
	return container.object;
}

@end
