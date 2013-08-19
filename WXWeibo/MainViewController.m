//
//  MainViewController.m
//  WXWeibo
//
//  Created by Jays owen on 13-7-25.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeButton.h"
#import "UIFactory.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self _initViewCOntroller];
    [self _initTabbarView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_initViewCOntroller
{
        HomeViewController *home = [[HomeViewController alloc] init];
        MessageViewController *message = [[MessageViewController alloc] init];
        ProfileViewController *profile = [[ProfileViewController alloc] init];
        DiscoverViewController *discover = [[DiscoverViewController alloc] init];
        MoreViewController *more = [[MoreViewController alloc] init];
    
        NSArray *views = @[home,message,profile,discover,more];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
        [nav release];
        
        self.viewControllers = viewControllers;
    }
}

-(void)_initTabbarView
{
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49-20, ScreenWidth, 49)];
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    
    [self.view addSubview:_tabbarView];
    
    UIImageView *tabbarBackgroundImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarBackgroundImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarBackgroundImage];
    
    NSArray *background = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *heightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i=0; i<background.count; i++) {
        NSString *backImage = background[i];
        NSString *heightImage = heightBackground[i];
        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImage highlighted:heightImage];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag = i;
//        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];

    }
        _slideView = [[UIFactory createImageView:@"tabbar_slider.png"] retain];
        _slideView.backgroundColor = [UIColor clearColor];
        _slideView.frame = CGRectMake((64-15)/2, 5, 15, 44);
        [_tabbarView addSubview:_slideView];
}

-(void)selectedTab:(UIButton *)button
{
    self.selectedIndex = button.tag;
    
    float x = button.left + (button.width - _slideView.width)/2;
    
    [UIView animateWithDuration:0.2 animations:^{
        _slideView.left = x;
    }];
}

#pragma mark -SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    //保存认证数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    
}

@end
