//
//  ZindEngineMember.m
//  Zind
//
//  Created by lzackx on 2021/3/11.
//

#import "ZindEngineMember.h"
#import "ZindBaseContainer.h"
#import "ZindRouteModel.h"

@interface ZindEngineMember ()

@property (nonatomic, readonly, strong) NSLock *lifeCycleLock;
@property (nonatomic, readwrite, strong) FlutterMethodChannel *memberChannel;

@end

@implementation ZindEngineMember

#pragma mark - Life Cycle
- (instancetype)initWithEngine:(FlutterEngine *)engine
					entryPoint:(NSString *)entryPoint {
	self = [super init];
	ZIND_LIFE_CYCLE_LOGGER
	if (self) {
		_engine = engine;
		_engine.engineMember = self;
		_entryPoint = entryPoint;
		_lifeCycleLock = [[NSLock alloc] init];
		_shouldRetained = NO;
		[self registerPlugins];
		_lifeCycle = ZindEngineMemberLifeCycleInitialized;
	}
	return self;
}

- (void)setupLifeCycle:(ZindEngineMemberLifeCycle)lifeCycle {
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"ZindEngineMemberLifeCycle: %lu", lifeCycle);
	[self.lifeCycleLock lock];
	self.lifeCycle = lifeCycle;
	[self.lifeCycleLock unlock];
}

- (void)runEngine {
	ZIND_LIFE_CYCLE_LOGGER
	[self.engine ensureSemanticsEnabled];
	[self.engine runWithEntrypoint:self.entryPoint];
	[self setupLifeCycle:ZindEngineMemberLifeCycleRunning];
}

- (void)cleanEngine {
	ZIND_LIFE_CYCLE_LOGGER
	self.engine.viewController = nil;
	if (self.shouldRetained == NO) {
		[self.engine destroyContext];
	}
}

#pragma mark - Getter / Setter
- (FlutterMethodChannel *)memberChannel {
	if (_memberChannel == nil) {
		FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"com.zind.engine.channel"
																	binaryMessenger:self.engine.binaryMessenger];
		_memberChannel = channel;
	}
	return _memberChannel;
}

#pragma mark - Plugins
- (void)registerPlugins {
	ZIND_LIFE_CYCLE_LOGGER
#pragma GCC diagnostic ignored "-Wundeclared-selector"
	if ([NSClassFromString(@"GeneratedPluginRegistrant") respondsToSelector:@selector(registerWithRegistry:)]) {
		[NSClassFromString(@"GeneratedPluginRegistrant") performSelector:@selector(registerWithRegistry:) withObject:self.engine];
	}
	[self.engine ensureSemanticsEnabled];
}

#pragma mark - Occupied VC
- (NSString *)serializeArguments:(NSDictionary *)arguments {
	NSError *error;
	NSData *argumentsData = [NSJSONSerialization dataWithJSONObject:arguments
															options:NSJSONWritingFragmentsAllowed
															  error:&error];
	if (argumentsData == nil) {
		NSLog(@"error: %@", error);
		return nil;
	}
	NSString *argumentsJSON = [[NSString alloc] initWithData:argumentsData encoding:NSUTF8StringEncoding];
	return argumentsJSON;
}

- (void)pushPage:(NSString *)page {
	ZIND_LIFE_CYCLE_LOGGER
//	NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
//	[arguments setObject:page forKey:@"url"];
//	[arguments setObject:@{@"public":@{}, @"private":@{}} forKey:@"parameters"];
//	NSString *argumentsJSON = [self serializeArguments:arguments];
//	if (argumentsJSON == nil) {
//		return;
//	}
//	[self.memberChannel invokeMethod:@"pushPage"
//						   arguments:argumentsJSON
//							  result:^(id  _Nullable result) {
//		NSLog(@"invokeMethod pushPage");
//		NSLog(@"result: %@", result);
//	}];
}

- (void)popPage:(NSString *)page {
	ZIND_LIFE_CYCLE_LOGGER
//	NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
//	[arguments setObject:page forKey:@"url"];
//	[arguments setObject:@{@"public":@{}, @"private":@{}} forKey:@"parameters"];
//	NSString *argumentsJSON = [self serializeArguments:arguments];
//	if (argumentsJSON == nil) {
//		return;
//	}
//	[self.memberChannel invokeMethod:@"popPage"
//						   arguments:argumentsJSON
//							  result:^(id  _Nullable result) {
//		NSLog(@"invokeMethod popPage");
//		NSLog(@"result: %@", result);
//	}];
}

- (void)updateRoutePage:(NSString *)page {
	ZIND_LIFE_CYCLE_LOGGER
	ZindRouteModel *routeModel = [ZindRouteModel yy_modelWithJSON:ZindDefaultRouteModelString];
	routeModel.url = page;
	routeModel.parameters.public.routerType = [NSNumber numberWithUnsignedInteger:ZindRouteModelRouterTypeShared];
	if (routeModel == nil) {
		return;
	}
	[self.memberChannel invokeMethod:@"updateRoutePage"
						   arguments:[routeModel yy_modelToJSONString]
							  result:^(id  _Nullable result) {
		NSLog(@"invokeMethod updateRoutePage");
		NSLog(@"result: %@", result);
	}];
}

- (void)updateNavigatorPage:(NSString *)page {
	ZIND_LIFE_CYCLE_LOGGER
	ZindRouteModel *routeModel = [ZindRouteModel yy_modelWithJSON:ZindDefaultRouteModelString];
	routeModel.url = page;
	routeModel.parameters.public.routerType = [NSNumber numberWithUnsignedInteger:ZindRouteModelRouterTypePopUp];
	if (routeModel == nil) {
		return;
	}
	[self.memberChannel invokeMethod:@"updateNavigatorPage"
						   arguments:[routeModel yy_modelToJSONString]
							  result:^(id  _Nullable result) {
		NSLog(@"invokeMethod updateNavigatorPage");
		NSLog(@"result: %@", result);
	}];
}

@end
