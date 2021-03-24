//
//  ZindPopupViewController.m
//  Zind
//
//  Created by lzackx on 2021/3/16.
//

#import "ZindPopUpViewController.h"

@interface ZindPopUpViewController ()

@end

@implementation ZindPopUpViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.viewOpaque = NO;
}

- (void)dealloc {
	ZIND_LIFE_CYCLE_LOGGER
	self.lifeCycle = ZindBaseContainerLifeCycleTerminated;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self dismissViewControllerAnimated:NO completion:^{
			
	}];
}

@end
