//
//  ZindBaseContainerProtocol.h
//  Zind
//
//  Created by lzackx on 2021/3/12.
//

#ifndef ZindBaseContainerProtocol_h
#define ZindBaseContainerProtocol_h

#import <Flutter/Flutter.h>

@protocol ZindBaseContainerProtocol <NSObject>

@required
- (instancetype _Nonnull)initWithEngine:(FlutterEngine * _Nonnull)engine;

@end

#endif /* ZindBaseContainerProtocol_h */
