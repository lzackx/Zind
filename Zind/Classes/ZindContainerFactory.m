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

#pragma mark - Base
+ (ZindBaseContainer *)createContainerWithContainerClass:(Class)containerClass
											  entryPoint:(nullable NSString *)entryPoint
												  preRun:(BOOL)preRun {
	
	ZindBaseContainer *container = (ZindBaseContainer *)[containerClass alloc];
	NSString *type = NSStringFromClass(containerClass);
	SEL selector = @selector(initWithEngine:);
	ZindEngineManager *engineManager = [ZindEngineManager shared];
	ZindEngineMember *engineMember = [engineManager getEngineWithType:type];
	if (engineMember == nil) {
		engineMember = [engineManager createEngineMemberWithType:type
													  entryPoint:entryPoint];
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

#pragma mark - PopUp
+ (ZindPopUpViewController *)createPopUpViewControllerWithEntryPoint:(NSString *)entryPoint
																Page:(NSString *)page
															  preRun:(BOOL)preRun {
	NSString *type = @"ZindPopUpViewController";
	ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:type];
	if (engineMember == nil) {
		engineMember = [[ZindEngineManager shared] createEngineMemberWithType:type
																   entryPoint:entryPoint
																 shouldRetain:YES];
	}
	[engineMember.engine runWithEntrypoint:entryPoint];
	ZindPopUpViewController *popUpVC = (ZindPopUpViewController *)[ZindContainerFactory createContainerWithContainerClass:NSClassFromString(@"ZindPopUpViewController")
																											 engineMember:engineMember
																												   preRun:preRun];
	popUpVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
	return popUpVC;
}

+ (void)showPopUpViewControllerWithFromViewController:(UIViewController *)fromViewController
										   EntryPoint:(NSString *)entryPoint
												 Page:(NSString *)page
										   completion:(void (^ __nullable)(void))completion {
	if (fromViewController == nil) {
		return;
	}
	ZindPopUpViewController *popUpVC = [ZindContainerFactory createPopUpViewControllerWithEntryPoint:entryPoint
																								Page:page
																							  preRun:YES];
	[popUpVC.engine.engineMember updateNavigatorPage:page];
	[fromViewController presentViewController:popUpVC animated:NO completion:completion];
}

@end
