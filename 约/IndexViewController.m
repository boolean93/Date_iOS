//
//  ViewController.m
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "IndexNormalCell.h"
#import "IndexHeaderCell.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [self fetchInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255 green:239/255 blue:239/255 alpha:0];
    self.title = @"约吗";
    UIColor *redColor = [UIColor colorWithRed:255/255
                                       green:61/255
                                        blue:61/255
                                       alpha:0];
    self.navigationController.navigationBar.barTintColor = redColor;
    [self.tableView registerClass:IndexNormalCell.class forCellReuseIdentifier:@"IndexNormalCellIdentifier"];
    [self.tableView registerClass:IndexHeaderCell.class forHeaderFooterViewReuseIdentifier:@"IndexHeaderCellIdentifier"];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"I Receive some Memory Warning.");
    [super didReceiveMemoryWarning];
}

# pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexNormalCellIdentifier"];
    if(!self.data) return cell;
    
    /**
     *  设置头像
     */
    NSURL *avatarURL = [NSURL URLWithString:[self.data[indexPath.row] objectForKey:@"head"]];
    __weak IndexNormalCell *weakCell = (IndexNormalCell *)cell;
    [cell.avatar setImageWithURLRequest:[NSURLRequest requestWithURL:avatarURL]
                       placeholderImage:[UIImage imageNamed:@"iconfont-qian"]
                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                    [weakCell.avatar setImage:image];
                                    weakCell.avatar.layer.masksToBounds  = YES;
                                    weakCell.avatar.layer.cornerRadius = weakCell.avatar.frame.size.width / 2;
                                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                    NSLog(@"Fetching Image Failed: %@", avatarURL);
                                }];
    
    /**
     *  设置昵称
     */
    cell.nickname.text = [self.data[indexPath.row] objectForKey:@"nickname"];
    
    /**
     *  设置性别
     */
    if ([[self.data[indexPath.row] objectForKey:@"gender"] isEqual:@1]){
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-boy"]];
    }else{
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-girl"]];
    }
    
    /**
     *  设置个人签名
     */
    cell.signature.text = [self.data[indexPath.row] objectForKey:@"signature"];
    
    /**
     *  设置约的标题
     */
    cell.dateTitle.text = [self.data[indexPath.row] objectForKey:@"title"];
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
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
