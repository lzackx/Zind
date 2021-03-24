//
//  FlutterEngine+Zind.h
//  Zind
//
//  Created by lzackx on 2021/3/17.
//

#import <Flutter/Flutter.h>

@class ZindEngineMember;
NS_ASSUME_NONNULL_BEGIN

@interface FlutterEngine (Zind)

@property (nonatomic, readwrite, weak) ZindEngineMember *engineMember;

@end

NS_ASSUME_NONNULL_END
