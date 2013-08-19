//
//  HomeViewController.h
//  WXWeibo
//
//  Created by Jays owen on 13-7-25.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeiboRequest.h"
@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboRequestDelegate>

@property (nonatomic,retain)NSArray *data;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end
