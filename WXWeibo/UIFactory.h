//
//  UIFactory.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-31.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface UIFactory : NSObject

+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName;
+ (ThemeImageView *)createImageView:(NSString *)imageName;
+ (ThemeLabel *)createLabel:(NSString *)colorName;

@end
