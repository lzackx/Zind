//
//  ZindShareContainer.h
//  Zind
//
//  Created by lzackx on 2021/3/17.
//

#import <UIKit/UIKit.h>


@class ZindShareViewController;
NS_ASSUME_NONNULL_BEGIN

@interface ZindShareContainer : UIViewController

@property (nonatomic, readwrite, copy) NSString *url;
@property (nonatomic, readwrite, weak) ZindShareViewController *shareVC;

- (instancetype)initWithShareVC:(ZindShareViewController *)shareVC url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
