//
//  ZindEngineManager.h
//  Zind
//
//  Created by lzackx on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "ZindEngineMember.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZindEngineManager : NSObject

+ (instancetype)shared;

- (ZindEngineMember *)createEngineMemberWithType:(NSString *)type
									  entryPoint:(nonnull NSString *)entryPoint
									initialRoute:(nonnull NSString *)initialRoute;

- (ZindEngineMember *)getEngineWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
