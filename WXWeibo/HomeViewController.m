//
//  HomeViewController.m
//  WXWeibo
//
//  Created by Jays owen on 13-7-25.
//  Copyright (c) 2013年 Jays owen. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "WeiboView.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微博";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //绑定按钮
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    //注销按钮
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [bindItem autorelease];
    self.navigationItem.rightBarButtonItem = [logoutItem autorelease];
    
    
    //判断是否认证
    if (self.sinaWeibo.isAuthValid) {
        //加载微博列表数据
        [self loadWeiboData];
    }
}


#pragma mark - load Data
-(void)loadWeiboData
{
    NSMutableDictionary *prgrams = [NSMutableDictionary dictionaryWithObject:@"50" forKey:@"count"];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                            params:prgrams
                        httpMethod:@"GET"
                          delegate:self];
}

#pragma mark - SinaWeiboRequest delegate
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"加载数据失败:%@",error);
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{ 
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    
    for (NSDictionary *statuesDic in statues ) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        [weibos addObject:weibo];
        [weibo release];
    }

    self.data = weibos;
    
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"WeiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    cell.weiboModel = weibo;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    float height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    height += 50;

    return height;
}

#pragma mark - actions
-(void)bindAction:(UIBarButtonItem *)buttonItem
{
    [self.sinaWeibo logIn];
}

-(void)logoutAction:(UIBarButtonItem *)buttonItem
{
    [self.sinaWeibo logOut];
}

#pragma mark - memory manager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    
}
@end
