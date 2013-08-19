//
//  ThemeButton.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-30.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

//Normal状态下的图片名称
@property(nonatomic,copy)NSString *imageName;
//高亮状态下的图片名称
@property(nonatomic,copy)NSString *highligtImageName;

//Normal状态下的背景图片名称
@property(nonatomic,copy)NSString *backgroundImageName;
//高亮状态下的背景图片名称
@property(nonatomic,copy)NSString *backgroundHighligtImageName;

- (id)initWithImage:(NSString *)imageName highlighted:(NSString *)highligtImageName;

- (id)initWithBackground:(NSString *)backgroundImageName
   highlightedBackground:(NSString *)backgroundHighligtImageName;

@end
