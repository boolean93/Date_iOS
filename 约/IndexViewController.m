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
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [self fetchInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"约吗";
    UIColor *redColor = [UIColor colorWithRed:255/255.0
                                        green:61/255.0
                                         blue:61/255.0
                                        alpha:1];
    self.navigationController.navigationBar.barTintColor = redColor;
    [self.tableView registerClass:IndexNormalCell.class forCellReuseIdentifier:@"IndexNormalCellIdentifier"];
    [self.tableView registerClass:IndexHeaderCell.class forHeaderFooterViewReuseIdentifier:@"IndexHeaderCellIdentifier"];
    
    // 悬浮的Button
    self.button = UIButton.new;
    [self.navigationController.view addSubview:self.button];
    
    [self.button setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@70);
        make.bottom.equalTo(self.navigationController.view.mas_bottom).offset(-25);
        make.right.equalTo(self.navigationController.view.mas_right).offset(-25);
    }];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"I Receive some Memory Warning.");
    [super didReceiveMemoryWarning];
}

# pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexNormalCellIdentifier"];
    if(!self.data) return cell;
    
    NSInteger row = indexPath.row;
    
    /**
     *  设置头像
     */
    NSURL *avatarURL = [NSURL URLWithString:[self.data[row] objectForKey:@"head"]];
    __weak IndexNormalCell *weakCell = (IndexNormalCell *)cell;
    [cell.avatar setImageWithURLRequest:[NSURLRequest requestWithURL:avatarURL]
                       placeholderImage:[UIImage imageNamed:@"iconfont-qian"]
                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                    [weakCell.avatar setImage:image];
                                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
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
 *  图片轮播哟~
 *
 *  @param tableView 当前的tableView
 *  @param section section喽
 *
 *  @return 轮播cell
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IndexHeaderCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IndexHeaderCellIdentifier"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)fetchInfo{
    [self getDateListWithUid:@1 token:@"nasdfnldssdaf"];
}

/**
 *
 获取约会列表
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


# pragma mark UITableViewDelegate

@end
