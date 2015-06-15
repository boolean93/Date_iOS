//
//  ViewController.m
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"
#import "IndexNormalCell.h"
#import "IndexHeaderCell.h"

@interface IndexViewController ()
@property(strong, nonatomic) UIButton *button;
@property(strong, nonatomic) NSNumber *headerHeight;
@property(weak, nonatomic) UIPageControl *control;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [self fetchInfo];
    
    // 非透明的背景消耗的性能要少一些
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 隐藏自带的Separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 看着还算舒服的背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    // NavigationBar上面字体的颜色改成白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"约吗";
    
    // NavigationBar背景色, 这个值得收藏, 找了很久才找到的办法.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:61/255.0 blue:61/255.0 alpha:1];
    
    // 注册IndexNormalCell
    [self.tableView registerClass:IndexNormalCell.class forCellReuseIdentifier:@"IndexNormalCellIdentifier"];
    [self.tableView registerClass:IndexHeaderCell.class forCellReuseIdentifier:@"IndexHeaderCellIdentifier"];
    
    // 悬浮的Button
    self.button = UIButton.new;
    [self.navigationController.view addSubview:self.button];
    [self.button setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@60);
        make.bottom.equalTo(self.navigationController.view.mas_bottom).offset(-25);
        make.right.equalTo(self.navigationController.view.mas_right).offset(-25);
    }];
    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"I Receive some Memory Warning.");
    [super didReceiveMemoryWarning];
}

# pragma mark -
# pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && [self.headerHeight floatValue] > 0) {
        return [self.headerHeight floatValue];
    }
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        IndexHeaderCell *cell = [self getIndexHeaderCellWithTableView:tableView];
        self.headerHeight = [NSNumber numberWithFloat: cell.scroll.frame.size.height];
        return cell;
    }
    
    IndexNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexNormalCellIdentifier"];
    if(!self.data) return cell;
    
    NSInteger row = indexPath.row - 1;
    
    /**
     *  设置头像
     */
    NSURL *avatarURL = [NSURL URLWithString:[self.data[row] objectForKey:@"head"]];
    __weak IndexNormalCell *weakCell = (IndexNormalCell *)cell;
    [cell.avatar setImageWithURLRequest:[NSURLRequest requestWithURL:avatarURL]
                       placeholderImage:[UIImage imageNamed:@"iconfont-qian"]
                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                    [weakCell.avatar setImage:image];
                                }
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                    NSLog(@"Fetching Image Failed: %@", avatarURL);
                                }];
    /**
     *  设置昵称
     */
    cell.nickname.text = [self.data[row] objectForKey:@"nickname"];
    /**
     *  设置性别
     */
    if ([[self.data[row] objectForKey:@"gender"] isEqual:@"1"]){
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-boy"]];
    }else{
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-girl"]];
    }
    /**
     *  设置个人签名
     */
    cell.signature.text = [self.data[row] objectForKey:@"signature"];
    
    /**
     *  设置约的标题
     */
    cell.dateTitle.text = [self.data[row] objectForKey:@"title"];
    /**
     *  设置地点
     */
    NSString *address = [self.data[row] objectForKey:@"place"];
    cell.address.text = [NSString stringWithFormat:@"地点：%@", address];
    /**
     *  设置时间
     */
    NSString *time = [self.data[row] objectForKey:@"date_at"];
    cell.time.text = [NSString stringWithFormat:@"时间：%@", [cell dateTransfer:time] ];
    /**
     *  设置花费
     */
    NSString *cost = [self.data[row] objectForKey:@"cost_model"];
    switch ([cost integerValue]) {
        case 1:
            cell.money.text = @"花费：AA制";
            break;
        case 2:
            cell.money.text = @"花费：我请客";
            break;
        case 3:
            cell.money.text = @"花费：求请客";
            break;
        default:
            cell.money.text = @"花费：未知";
            break;
    }
    
    /**
     *  设置发布时间
     */
    NSString *submitTime = [self.data[row] objectForKey:@"created_at"];
    cell.submitTime.text = [cell dateTransfer:submitTime];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

/**
 *  整个UITableView的头部, 用于存放图片轮播和列表内容分类.
 *
 *  @return IndexHeaderCell
 */
- (IndexHeaderCell *)getIndexHeaderCellWithTableView:(UITableView *)tableView{
    IndexHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexHeaderCellIdentifier"];

    NSInteger i = 0;
    for (NSDictionary *obj in self.imageURL) {
        UIImageView *image = UIImageView.new;
        [image setFrame:CGRectMake(cell.scroll.frame.size.width * i, 0, cell.scroll.frame.size.width, cell.scroll.frame.size.height)];
        [cell.scroll addSubview:image];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[obj objectForKey:@"src"]]];
        __weak UIImageView *weakImage = image;
        [image setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"iconfont-shijian" ]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  weakImage.image = image;
                                  NSLog(@"~~ Loading Image Succeed. :)");
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  NSLog(@"!! Fetching Image Error: %@", error);
                              }];
        i++;
    }
    [cell.scroll setContentSize:CGSizeMake(cell.scroll.frame.size.width * i, cell.scroll.frame.size.height)];
    cell.scroll.delegate = self;
    [cell.page setNumberOfPages:i];
    self.control = cell.page;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 *
 *  获取约会列表
 *
 *  @param uid   用户id
 *  @param token token
 */
-(void)getDateListWithUid:(NSNumber *)uid token:(NSString *)token{
    NSString *url = @"http://106.184.7.12:8002/index.php/api/date/datelist";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid": uid,
                                 @"token": token,
                                 @"date_type": @0,
                                 @"page": @1,
                                 @"size": @10,
                                 @"order": @1
                                 };
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if(![[responseObject objectForKey:@"status"]  isEqual: @200]){
                  NSLog(@"Error: %@", [responseObject objectForKey:@"info"]);
              }else{
                  self.data = [responseObject objectForKey:@"data"];
                  [self.tableView reloadData];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

/**
 *  获取图片地址
 */
- (void)getImageURLs{
    NSString *url = @"http://106.184.7.12:8002/index.php/api/public/banner";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(![[responseObject objectForKey:@"status"]  isEqual: @200]){
            NSLog(@"Error: %@", [responseObject objectForKey:@"info"]);
        }else{
            self.imageURL = [responseObject objectForKey:@"data"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"!! Get Image URLs Error: %@", error);
    }];
}


/**
 *  获取用户信息的类, 还没做登陆, 所以先这样代替登陆界面喽
 */
- (void)fetchInfo{
    [self getDateListWithUid:@1 token:@"nasdfnldssdaf"];
    [self getImageURLs];
}

# pragma mark -
# pragma mark UITableViewDelegate

# pragma mark -
# pragma mark UIScrollViewDelegate for HeaderCell.scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 判断是否是图片轮播的滑动
    if(scrollView.frame.size.height == [self.headerHeight floatValue]){
        self.control.currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    }
}

@end
