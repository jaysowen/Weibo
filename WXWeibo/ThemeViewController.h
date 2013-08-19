//
//  ThemeViewController.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-30.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *themes;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
