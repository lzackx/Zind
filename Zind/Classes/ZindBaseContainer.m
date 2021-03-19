//
//  ZindBaseContainer.m
//  Zind
//
//  Created by lzackx on 2021/3/10.
//

#import "ZindBaseContainer.h"
#import <Flutter/FlutterEngine.h>

@interface ZindBaseContainer ()

@end

@implementation ZindBaseContainer

#pragma mark - Life Cycle

- (instancetype _Nonnull)initWithEngine:(FlutterEngine * _Nonnull)engine {
	self = [super initWithEngine:engine nibName:nil bundle:nil];
	ZIND_LIFE_CYCLE_LOGGER
	if (self) {
		_lifeCycle = ZindBaseContainerLifeCycleInitializing;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	ZIND_LIFE_CYCLE_LOGGER
	self.lifeCycle = ZindBaseContainerLifeCycleInitialized;
	if (self.engine != nil) {
		ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:NSStringFromClass([self class])];
		if (engineMember.lifeCycle != ZindEngineMemberLifeCycleRunning) {
			[engineMember runEngine];
		}
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	self.lifeCycle = ZindBaseContainerLifeCycleActive;
	if (self.engine != nil) {
		ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:NSStringFromClass([self class])];
		if (engineMember.lifeCycle != ZindEngineMemberLifeCycleRunning) {
			[engineMember setupLifeCycle:ZindEngineMemberLifeCycleRunning];
		}
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	self.lifeCycle = ZindBaseContainerLifeCycleInactive;
	if (self.engine != nil) {
		ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:NSStringFromClass([self class])];
		[engineMember setupLifeCycle:ZindEngineMemberLifeCycleIdle];
	}
}

- (void)dealloc {
	ZIND_LIFE_CYCLE_LOGGER
	_lifeCycle = ZindBaseContainerLifeCycleTerminated;
	if (self.engine != nil) {
		ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:NSStringFromClass([self class])];
		[engineMember setupLifeCycle:ZindEngineMemberLifeCycleTerminated];
	}
}

#pragma mark - Getter / Setter
- (ZindBaseContainerLifeCycle)getLifeCycle {
	return _lifeCycle;
}

- (void)setLifeCycle:(ZindBaseContainerLifeCycle)lifeCycle {
	_lifeCycle = lifeCycle;
}

#pragma mark - Override Flutter Methods
- (BOOL)loadDefaultSplashScreenView {
	return NO;
}

@end
