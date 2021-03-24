//
//  ZindEngineManager.m
//  Zind
//
//  Created by lzackx on 2021/3/10.
//

#import "ZindEngineManager.h"
#import <Flutter/Flutter.h>

@interface ZindEngineManager ()

@property (nonatomic, readwrite, strong) FlutterEngineGroup *engineGroup;
@property (nonatomic, readwrite, strong) NSMutableDictionary<NSString *, ZindEngineMember *> *engineMembers;
@property (nonatomic, readwrite, strong) NSLock *emLock;

@end

@implementation ZindEngineManager

#pragma mark - Singleton
+ (instancetype)shared {
	ZIND_LIFE_CYCLE_LOGGER
	static dispatch_once_t once = 0;
	static ZindEngineManager *_sharedInstance = nil;
	dispatch_once(&once, ^{
		_sharedInstance = [[self alloc] init];
	});
	return _sharedInstance;
}

- (instancetype)init {
	ZIND_LIFE_CYCLE_LOGGER
	self = [super init];
	if (self) {
		_engineGroup = [[FlutterEngineGroup alloc] initWithName:@"com.zind.engine.group" project:nil];
		_engineMembers = [NSMutableDictionary<NSString *, ZindEngineMember *> dictionary];
		_emLock = [[NSLock alloc] init];
	}
	return self;
}

#pragma mark - Engin Members
- (ZindEngineMember *)createEngineMemberWithType:(NSString *)type
									  entryPoint:(nonnull NSString *)entryPoint
									initialRoute:(nonnull NSString *)initialRoute {
	return [self createEngineMemberWithType:type entryPoint:entryPoint initialRoute:initialRoute shouldRetain:NO];
}

- (ZindEngineMember *)createEngineMemberWithType:(NSString *)type
									  entryPoint:(nonnull NSString *)entryPoint
									initialRoute:(nonnull NSString *)initialRoute
									shouldRetain:(BOOL)shouldRetain {
	ZIND_LIFE_CYCLE_LOGGER
	FlutterEngine *engine = [self.engineGroup makeEngineWithEntrypoint:entryPoint libraryURI:nil];
	ZindEngineMember *engineMember = [[ZindEngineMember alloc] initWithEngine:engine
																   entryPoint:entryPoint
																 initialRoute:initialRoute];
	engineMember.type = type;
	engineMember.shouldRetained = shouldRetain;
	[self.emLock lock];
	[self.engineMembers setObject:engineMember forKey:type];
	[self.emLock unlock];
	[engineMember addObserver:self
				   forKeyPath:@"lifeCycle"
					  options:NSKeyValueObservingOptionNew
					  context:nil];
	return engineMember;
}

- (ZindEngineMember *)getEngineWithType:(NSString *)type {
	ZIND_LIFE_CYCLE_LOGGER
	if ([self.engineMembers.allKeys containsObject:type] == NO) {
		return nil;
	}
	[self.emLock lock];
	ZindEngineMember *engineMember = [self.engineMembers objectForKey:type];
	[self.emLock unlock];
	return engineMember;;
}

- (void)releaseEngineMemberWithType:(NSString *)type {
	ZIND_LIFE_CYCLE_LOGGER
	if ([self.engineMembers.allKeys containsObject:type] == NO) {
		return;
	}
	ZindEngineMember *engineMember = [self.engineMembers objectForKey:type];
	if (engineMember.shouldRetained) {
		return;
	}
	[engineMember removeObserver:self forKeyPath:@"lifeCycle"];
	[self.emLock lock];
	[self.engineMembers removeObjectForKey:type];
	[self.emLock unlock];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	ZIND_LIFE_CYCLE_LOGGER
	if ([keyPath isEqualToString:@"lifeCycle"]) {
		ZindEngineMemberLifeCycle lifeCycle = [[change objectForKey:NSKeyValueChangeNewKey] unsignedIntegerValue];
		NSLog(@"lifeCycle: %lu", lifeCycle);
		ZindEngineMember *engineMember = (ZindEngineMember *)object;
		switch (lifeCycle) {
			case ZindEngineMemberLifeCycleInitialized:
				break;
			case ZindEngineMemberLifeCycleRunning:
				break;
			case ZindEngineMemberLifeCycleIdle:
				break;
			case ZindEngineMemberLifeCycleTerminated:
				[engineMember cleanEngine];
				[self releaseEngineMemberWithType:engineMember.type];
				break;
		}
	}
}

#pragma mark - Plugins

@end
