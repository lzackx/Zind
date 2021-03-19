//
//  ZAppDelegate.h
//  Zind
//
//  Created by lzackx on 03/10/2021.
//  Copyright (c) 2021 lzackx. All rights reserved.
//

@import UIKit;
#import "ZTabbarController.h"


@interface ZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readwrite, strong) ZTabbarController *tabbarController;

@end
