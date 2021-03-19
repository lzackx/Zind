//
//  ZindDefinitions.h
//  Zind
//
//  Created by lzackx on 2021/3/10.
//

#ifndef ZindDefinitions_h
#define ZindDefinitions_h

#ifdef DEBUG
#define ZIND_LIFE_CYCLE_LOGGER		NSLog(@"%s", __func__);
#else
#define ZIND_LIFE_CYCLE_LOGGER		;
#endif

typedef NS_ENUM(NSUInteger, ZindBaseContainerLifeCycle) {
	ZindBaseContainerLifeCycleInitializing = 0,
	ZindBaseContainerLifeCycleInitialized,
	ZindBaseContainerLifeCycleActive,
	ZindBaseContainerLifeCycleInactive,
	ZindBaseContainerLifeCycleTerminated,
};

typedef NS_ENUM(NSUInteger, ZindEngineMemberLifeCycle) {
	ZindEngineMemberLifeCycleInitialized = 0,
	ZindEngineMemberLifeCycleRunning,
	ZindEngineMemberLifeCycleIdle,
	ZindEngineMemberLifeCycleTerminated,
};


#endif /* ZindDefinitions_h */
