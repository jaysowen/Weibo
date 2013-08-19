//
//  AppDelegate.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-25.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (nonatomic,retain) MainViewController *mainCtrl;

@end
