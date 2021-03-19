//
//  ZindWeakAssociatedObjectContainer.h
//  Zind
//
//  Created by lzackx on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZindWeakAssociatedObjectContainer : NSObject

@property (nonatomic, readwrite, weak) id object;

@end

NS_ASSUME_NONNULL_END
