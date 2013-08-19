//
//  ThemeLabel.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-31.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy) NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;

@end
