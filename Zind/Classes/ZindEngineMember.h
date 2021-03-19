//
//  ZindEngineMember.h
//  Zind
//
//  Created by lzackx on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "ZindDefinitions.h"
#import "FlutterEngine+Zind.h"

@class ZindBaseContainer;

NS_ASSUME_NONNULL_BEGIN

@interface ZindEngineMember : NSObject

@property (nonatomic, readwrite, assign) ZindEngineMemberLifeCycle lifeCycle;
@property (nonatomic, readonly, strong) FlutterEngine *engine;
@property (nonatomic, readwrite, copy) NSString *type;
@property (nonatomic, readonly, copy) NSString *entryPoint;
@property (nonatomic, readonly, copy) NSString *initialRoute;
@property (nonatomic, readwrite, weak) ZindBaseContainer *occupiedVC;

- (instancetype)initWithEngine:(FlutterEngine *)engine
					entryPoint:(NSString *)entryPoint
				  initialRoute:(NSString *)initialRoute;

- (void)setupLifeCycle:(ZindEngineMemberLifeCycle)lifeCycle;
- (void)runEngine;
- (void)cleanEngine;

#pragma mark - Plugins
- (void)registerPlugins;

#pragma mark - Page
- (void)pushPage:(NSString *)page;
- (void)popPage:(NSString *)page;
- (void)updatePage:(NSString *)page;


@end

NS_ASSUME_NONNULL_END
