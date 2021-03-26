//
//  ZTabbarController.m
//  Zind_Example
//
//  Created by lzackx on 2021/3/15.
//  Copyright © 2021 lzackx. All rights reserved.
//

#import "ZTabbarController.h"
#import <Zind/Zind.h>
#import "ZViewController.h"


@interface ZTabbarController ()

@property (nonatomic, readwrite, strong) ZindShareViewController *shareVC;

@end

@implementation ZTabbarController

#pragma mark - Life Cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupControllers];
}

#pragma mark - Public
- (void)setupControllers {
	
	ZindRouteModel *routeModel = [ZindRouteModel yy_modelWithJSON:ZindDefaultRouteModelString];
	if (routeModel == nil) {
		return;
	}
	
	self.shareVC = (ZindShareViewController*)[ZindContainerFactory createContainerWithContainerClass:NSClassFromString(@"ZindShareViewController")
																						  entryPoint:@"shared"
																						initialRoute:[routeModel yy_modelToJSONString]
																							  preRun:YES];
	self.shareVC.view.backgroundColor = [UIColor whiteColor];
	ZindShareContainer *shareContainer1 = [[ZindShareContainer alloc] initWithShareVC:self.shareVC url:@"/home"];
	shareContainer1.tabBarItem.title = @"shareContainer1";
	shareContainer1.tabBarItem.image = [UIImage imageNamed:@"triangle"];
	
	ZindShareContainer *shareContainer2 = [[ZindShareContainer alloc] initWithShareVC:self.shareVC url:@"/account"];
	shareContainer2.tabBarItem.title = @"shareContainer2";
	shareContainer2.tabBarItem.image = [UIImage imageNamed:@"triangle"];
	
	[self addChildViewController:shareContainer1];
	[self addChildViewController:shareContainer2];
}

@end
