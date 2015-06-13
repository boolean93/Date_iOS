//
//  IndexNormalCellViewTableViewCell.m
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexNormalCell.h"
#import "Masonry.h"

@implementation IndexNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    [self initializeViews];
    [self makeConstraints];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return self;
}

- (void)initializeViews{
    
    // 缩略图
    self.avatar = UIImageView.new;
    self.avatar.layer.masksToBounds  = YES;
    self.avatar.layer.borderColor = [[UIColor colorWithRed:221/255 green:221/255 blue:221/255 alpha:0.2] CGColor];
    self.avatar.layer.borderWidth = 1;
    self.avatar.layer.cornerRadius = 35;
    
    // 用户昵称
    self.nickname = UILabel.new;
    self.nickname.font = [UIFont fontWithName:self.nickname.font.fontName size:20];
    
    // 性别icon
    self.gender = UIImageView.new;
    
    // 个性签名
    self.signature = UILabel.new;
    self.signature.font = [UIFont fontWithName:self.signature.font.fontName size:16];
    self.signature.textColor = [UIColor darkGrayColor];
    
    // 时间Label
    self.dateTitle = UILabel.new;
    
    // 时间icon
    self.timeIcon = UIImageView.new;
    [self.timeIcon setImage:[UIImage imageNamed:@"iconfont-shijian" ]];
    
    // 地点icon
    self.addressIcon = UIImageView.new;
    [self.addressIcon setImage:[UIImage imageNamed:@"iconfont-jikediancanicon28"]];
    
    
    // 花费icon
    self.moneyIcon = UIImageView.new;
    [self.moneyIcon setImage:[UIImage imageNamed:@"iconfont-qian"]];
    
    // 时间Label
    self.time = UILabel.new;
    self.time.text = @"时间:";
    self.time.font = [UIFont fontWithName:self.time.font.fontName size:16];
    self.time.textColor = [UIColor darkGrayColor];
    
    // 地点Label
    self.address = UILabel.new;
    self.address.text = @"地点:";
    self.address.font = [UIFont fontWithName:self.address.font.fontName size:16];
    self.address.textColor = [UIColor darkGrayColor];
    
    // 花费Label
    self.money = UILabel.new;
    self.money.text = @"花费:";
    self.money.font = [UIFont fontWithName:self.money.font.fontName size:16];
    self.money.textColor = [UIColor darkGrayColor];
    
    // 发表时间Label
    self.submitTime = UILabel.new;
    self.submitTime.font = [UIFont fontWithName:self.submitTime.font.fontName size:16];
    self.submitTime.textColor = [UIColor darkGrayColor];
    
    // 模拟的CellSaparator
    self.cellSeparator = UILabel.new;
    self.cellSeparator.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
}

- (void)makeConstraints{
    
    // 头像
    [self.contentView addSubview: self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@75);
        make.height.equalTo(@75);
        make.left.equalTo(self.mas_leading).offset(25);
        make.top.equalTo(self.mas_top).offset(25);
    }];
    
    // 昵称
    [self.contentView addSubview: self.nickname];
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(22.5);
        make.top.equalTo(self.mas_top).offset(35);
        make.height.equalTo(@25);
        make.width.greaterThanOrEqualTo(@5);
    }];
    
    // 性别
    [self.contentView addSubview: self.gender];
    [self.gender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(35);
        make.width.and.height.equalTo(@20);
    }];
    
    // 签名
    [self.contentView addSubview: self.signature];
    [self.signature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(22.5);
        make.top.equalTo(self.nickname.mas_bottom).offset(12.5);
        make.height.equalTo(@25);
    }];
    
    // 约的标题
    [self.contentView addSubview: self.dateTitle];
    [self.dateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_left);
        make.top.equalTo(self.avatar.mas_bottom).offset(17.5);
    }];
    
    // 地点图标
    [self.contentView addSubview:self.addressIcon];
    [self.addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateTitle.mas_bottom).offset(19);
        make.left.equalTo(self.contentView).offset(25);
        make.width.and.height.equalTo(@19);
    }];
    
    // 时间图标
    [self.contentView addSubview:self.timeIcon];
    [self.timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressIcon.mas_bottom).offset(11);
        make.left.equalTo(self.addressIcon.mas_left);
        make.width.and.height.equalTo(@19);
    }];
    
    // 钱的图标
    [self.contentView addSubview:self.moneyIcon];
    [self.moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressIcon.mas_bottom).offset(41);
        make.left.equalTo(self.addressIcon.mas_left);
        make.width.and.height.equalTo(@19);
    }];
    
    // 地点Label
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressIcon.mas_top);
        make.left.equalTo(self.addressIcon.mas_right).offset(6);
    }];
    
    // 时间Label
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeIcon.mas_top);
        make.left.equalTo(self.address.mas_left);
    }];
    
    // 花费Label
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyIcon.mas_top);
        make.left.equalTo(self.time.mas_left);
    }];
    
    // 发布时间
    [self.contentView addSubview:self.submitTime];
    [self.submitTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-32);
        make.right.equalTo(self.contentView.mas_right).offset(-25);
    }];
    
    
    // 分割线
    [self.contentView addSubview:self.cellSeparator];
    [self.cellSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(@10);
        make.width.equalTo(self.contentView.mas_width);
    }];
}

-(NSString *)dateTransfer:(NSString *)timestamp{
    NSInteger now = (NSInteger)[[NSDate date]timeIntervalSince1970];
    NSInteger temp = now - [timestamp integerValue];
    if (temp >= 0) {
        if (temp < 60) {
            return @"刚刚";
        }
        if (temp < 3600) {
            return [NSString stringWithFormat:@"%ld分钟前", temp / 60];
        }
        if (temp < 3600 * 24) {
            return [NSString stringWithFormat:@"%ld小时前", temp / 3600];
        }
        if (temp < 3600 * 24 * 2) {
            return @"昨天";
        }
        if (temp < 3600 * 24 * 3) {
            return @"前天";
        }
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *formatter = NSDateFormatter.new;
    [formatter setDateFormat:@"MM月dd号 HH点"];
    return [formatter stringFromDate:date];
}

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end