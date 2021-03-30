//
//  ZindShareContainer.m
//  Zind
//
//  Created by lzackx on 2021/3/17.
//

#import "ZindShareContainer.h"
#import "ZindShareViewController.h"

@interface ZindShareContainer ()


@end

@implementation ZindShareContainer

#pragma mark - Life Cycle
- (instancetype)initWithShareVC:(ZindShareViewController *)shareVC url:(NSString *)url {
	self = [self init];
	ZIND_LIFE_CYCLE_LOGGER
	if (self) {
		self.shareVC = shareVC;
		self.url = url;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
	[self attachShareVCIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
}

- (void)dealloc {
	ZIND_LIFE_CYCLE_LOGGER
	NSLog(@"url: %@", self.url);
}

#pragma mark - Content
- (BOOL)isVisible {
	return (self.isViewLoaded && self.view.window);
}

- (void)attachShareVCIfNeeded {
//	if (self.shareVC.view.superview == self.view) {
//		return;
//	} else {
		[self.shareVC.view removeFromSuperview];
		self.shareVC.view.frame = self.view.bounds;
//	}
	[self.view addSubview:self.shareVC.view];
	[self.shareVC.engine.engineMember updateRoutePage:[self.url copy]];
}

@end
