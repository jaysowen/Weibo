//
//  MainViewController.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-25.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface MainViewController : UITabBarController <SinaWeiboDelegate>
{
    UIView *_tabbarView;
    UIImageView *_slideView;
}

@end
