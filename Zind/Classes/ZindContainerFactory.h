//
//  ZindContainerFactory.h
//  Zind
//
//  Created by lzackx on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import "ZindEngineManager.h"
#import "ZindBaseContainer.h"
#import "ZindBaseContainerProtocol.h"
#import "ZindShareContainer.h"
#import "ZindPopUpViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZindContainerFactory : NSObject

+ (ZindBaseContainer *)createContainerWithContainerClass:(Class)containerClass
											  entryPoint:(nullable NSString *)entryPoint
											initialRoute:(nullable NSString *)initialRoute
												  preRun:(BOOL)preRun;


+ (ZindBaseContainer *)createContainerWithContainerClass:(Class)containerClass
											engineMember:(ZindEngineMember *)engineMember
												  preRun:(BOOL)preRun;

+ (ZindPopUpViewController *)createPopUpViewControllerWithEntryPoint:(NSString *)entryPoint
														initialRoute:(nullable NSString *)initialRoute
																Page:(NSString *)page
															  preRun:(BOOL)preRun;

+ (void)showPopUpViewControllerWithFromViewController:(UIViewController *)fromViewController
										   EntryPoint:(NSString *)entryPoint
										 initialRoute:(nullable NSString *)initialRoute
												 Page:(NSString *)page
										   completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
