//
//  ZViewController.m
//  Zind
//
//  Created by lzackx on 03/10/2021.
//  Copyright (c) 2021 lzackx. All rights reserved.
//

#import "ZViewController.h"
#import <Zind/Zind.h>

@interface ZViewController ()

@end

@implementation ZViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// preload
	ZindEngineMember *engineMember = [[ZindEngineManager shared] getEngineWithType:@"ZindShareViewController"];
	if (engineMember == nil) {
		engineMember = [[ZindEngineManager shared] createEngineMemberWithType:@"ZindShareViewController"
																   entryPoint:@"shared"
																 initialRoute:@"/"];
		[engineMember runEngine];
	}
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	ZindBaseContainer *container = [ZindContainerFactory createContainerWithContainerClass:NSClassFromString(@"ZindShareViewController")
																				entryPoint:@"shared"
																			  initialRoute:@"/"
																					preRun:YES];
	[self.navigationController pushViewController:container animated:YES];
}

@end
