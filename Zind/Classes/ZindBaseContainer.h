//
//  ZindBaseContainer.h
//  Zind
//
//  Created by lzackx on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import <Flutter/FlutterViewController.h>
#import "ZindDefinitions.h"
#import "ZindBaseContainerProtocol.h"
#import <Zind/ZindEngineManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZindBaseContainer : FlutterViewController <ZindBaseContainerProtocol>

@property (nonatomic, readwrite, assign) ZindBaseContainerLifeCycle lifeCycle;

- (instancetype _Nonnull)initWithEngine:(FlutterEngine * _Nonnull)engine;

@end

NS_ASSUME_NONNULL_END
