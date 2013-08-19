//
//  ThemeManager.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-29.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

#define kThemeDidChangeNofication @"kThemeDidChangeNofication"

//当前使用的主题名称
@property (nonatomic,retain) NSString *themeName;
@property (nonatomic,retain) NSDictionary *themePlist;
@property (nonatomic,retain) NSDictionary *fontColorPlist;
+ (ThemeManager *)shareInstance;

//返回当前主题下，图片名对应的图片
- (UIImage *)getThemeImage:(NSString*) imageName;

- (UIColor *)getColorWithName:(NSString *) name;

@end
