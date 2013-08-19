//
//  ThemeImageView.m
//  WXWeibo
//
//  Created by Jays owen on 13-7-31.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

- (void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//使用xib创建后，调用的初始化方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
}

- (id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self!=nil) {
        self.imageName = imageName;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        //监听主题切换的通知 
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}

- (void)loadThemeImage
{
    if (self.imageName == nil) {
        return;
    }
    UIImage *uiImage = [[ThemeManager shareInstance] getThemeImage:_imageName];
    uiImage = [uiImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    self.image = uiImage;
}

#pragma mark -NSNotification actions
- (void)themeNotification:(NSNotification*)notification
{
    [self loadThemeImage];
}

@end
