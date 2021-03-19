//
//  ZindContainerFactory.m
//  Zind
//
//  Created by lzackx on 2021/3/11.
//

#import "ZindContainerFactory.h"
#import <objc/message.h>
#import "ZindEngineManager.h"

@interface ZindContainerFactory ()

@end

@implementation ZindContainerFactory

+ (ZindBaseContainer *)createContainerWithContainerClass:(Class)containerClass
											  entryPoint:(nullable NSString *)entryPoint
											initialRoute:(nullable NSString *)initialRoute
												  preRun:(BOOL)preRun {

	ZindBaseContainer *container = (ZindBaseContainer *)[containerClass alloc];
	NSString *type = NSStringFromClass(containerClass);
	SEL selector = @selector(initWithEngine:);
	ZindEngineManager *engineManager = [ZindEngineManager shared];
	ZindEngineMember *engineMember = [engineManager getEngineWithType:type];
	if (engineMember == nil) {
		engineMember = [engineManager createEngineMemberWithType:type
													  entryPoint:entryPoint
													initialRoute:initialRoute];
	}
	container = ((id (*)(id, SEL, FlutterEngine*))objc_msgSend)(container, selector, engineMember.engine);
	if (container == nil) {
		return nil;
	}
	if (preRun) {
		[engineMember runEngine];
	}
	return container;
}

+ (ZindBaseContainer *)createContainerWithContainerClass:(Class)containerClass
											engineMember:(ZindEngineMember *)engineMember
												  preRun:(BOOL)preRun {
	ZindBaseContainer *container = (ZindBaseContainer *)[containerClass alloc];
	SEL selector = @selector(initWithEngine:);
	if (engineMember == nil) {
		return nil;
	}
	container = ((id (*)(id, SEL, FlutterEngine*))objc_msgSend)(container, selector, engineMember.engine);
	if (container == nil) {
		return nil;
	}
	if (preRun) {
		[engineMember runEngine];
	}
	return container;
}

@end
