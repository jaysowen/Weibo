//
//  ThemeManager.m
//  WXWeibo
//
//  Created by Jays owen on 13-7-29.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *singleton = nil;

@implementation ThemeManager

+(ThemeManager *)shareInstance
{
    if (singleton==nil) {
        @synchronized(self){
        singleton = [[ThemeManager alloc] init];
        }
    }
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themePlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        //默认为空
        self.themeName = nil;
    }
    return self;
}

//切换主题时调用方法，设置主题名称
- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName copy];
    }
    NSString *themeDir = [self getThemePath];
    NSString *filePath = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

-(NSString *)getThemePath
{
    if (self.themeName == nil) {
        NSString *resPath = [[NSBundle mainBundle] resourcePath];
        return resPath;
    }
    //取得主题路径
    NSString *themePath = [self.themePlist objectForKey:_themeName];
    //程序包的根路径
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    //完整的主题包路径
    NSString *path = [resPath stringByAppendingPathComponent:themePath];
    
    return path;
}

//返回当前主题下，图片名对应的图片
- (UIImage *)getThemeImage:(NSString*)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    //获取主题目录
    NSString *themePath = [self getThemePath];
    //image在当前主题的路径
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image =[UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

- (UIColor *)getColorWithName:(NSString *) name
{
    if (name.length == 0) {
        return nil;
    }
    //返回三色值，如：255，255，255
    NSString *rgb = [_fontColorPlist objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count == 3) {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        
        UIColor *color = Color(r, g, b, 1);
        return color;
    }
    return nil;
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (singleton == nil) {
            singleton = [super allocWithZone:zone];
        }
    }
    return singleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount { 
    return UINT_MAX;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

@end
