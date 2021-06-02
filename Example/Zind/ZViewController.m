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

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ZViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.view.backgroundColor = [UIColor cyanColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	NSString *page = [NSString string];
	static NSUInteger tag = 0;
	if (tag % 2 == 0) {
		page = @"/advertisement";
	} else {
		page = @"/update";
	}
	tag++;
	
	[ZindContainerFactory showPopUpViewControllerWithFromViewController:self
															 EntryPoint:@"popup"
																   Page:page
															 completion:^{
		NSLog(@"Pop Up Shown");
	}];
}

- (IBAction)touchButton:(id)sender {
	
	ZindBaseContainer *container = [ZindContainerFactory createContainerWithContainerClass:[ZindBaseContainer class] entryPoint:@"main" preRun:YES];
	[self.navigationController pushViewController:container animated:YES];
}

@end
