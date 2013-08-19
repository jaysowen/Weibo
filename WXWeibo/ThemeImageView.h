//
//  ThemeImageView.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-31.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,assign)int leftCapWidth;
@property (nonatomic,assign)int topCapHeight;

-(id)initWithImageName:(NSString *)imageName;

@end
