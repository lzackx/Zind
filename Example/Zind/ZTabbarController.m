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
    // Do any additional setup after loading the view.
}

#pragma mark - Public
- (void)setupControllers {
	
	self.shareVC = (ZindShareViewController*)[ZindContainerFactory createContainerWithContainerClass:NSClassFromString(@"ZindShareViewController")
																					entryPoint:@"shared"
																				  initialRoute:@"/"
																						preRun:YES];
	self.shareVC.view.backgroundColor = [UIColor whiteColor];
	
	ZindShareContainer *shareContainer1 = [[ZindShareContainer alloc] initWithShareVC:self.shareVC url:@"/home"];
	shareContainer1.title = @"shareContainer1";
	ZindShareContainer *shareContainer2 = [[ZindShareContainer alloc] initWithShareVC:self.shareVC url:@"/account"];
	shareContainer2.title = @"shareContainer2";
	
	ZViewController *vc = [[ZViewController alloc] init];
	vc.title = @"vc";
	vc.view.backgroundColor = [UIColor whiteColor];
	
	self.viewControllers = @[
		shareContainer1,
		shareContainer2,
		vc,
	];
}

@end
