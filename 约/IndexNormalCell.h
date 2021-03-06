//
//  IndexNormalCellViewTableViewCell.h
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexNormalCell : UITableViewCell
@property (strong, nonatomic) NSString* avatarURL;
@property (strong, nonatomic) UIImageView* avatar;
@property (strong, nonatomic) UIImageView* gender;
@property (strong, nonatomic) UILabel* nickname;
@property (strong, nonatomic) UILabel* signature;
@property (strong, nonatomic) UILabel* dateTitle;
@property (strong, nonatomic) UIImageView* addressIcon;
@property (strong, nonatomic) UIImageView* timeIcon;
@property (strong, nonatomic) UIImageView* moneyIcon;
@property (strong, nonatomic) UILabel* address;
@property (strong, nonatomic) UILabel* time;
@property (strong, nonatomic) UILabel* money;
@property (strong, nonatomic) UILabel* submitTime;
@property (strong, nonatomic) UILabel* cellSeparator;


-(NSString *)dateTransfer:(NSString *)timestamp;
@end
