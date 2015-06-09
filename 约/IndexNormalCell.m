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
    self.avatar = UIImageView.new;
    self.nickname = UILabel.new;
    self.gender = UIImageView.new;
    self.signature = UILabel.new;
    self.dateTitle = UILabel.new;
    
    [self makeConstraints];
    
    self.avatar.layer.cornerRadius = 35;
    
    self.nickname.font = [UIFont fontWithName:self.nickname.font.fontName
                                         size:20];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSLog(@"init :%@", reuseIdentifier);
    
    return self;
}

- (void)makeConstraints{
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.greaterThanOrEqualTo(@529);
//    }];
    
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
        make.height.equalTo(@25);
        make.width.equalTo(@25);
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
}

//- (void)drawRect:(CGRect)rect{
//    [self makeConstraints];
//    [super drawRect:rect];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end