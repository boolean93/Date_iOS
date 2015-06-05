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

- (void)drawRect:(CGRect)rect{
    self.label = UILabel.new;
    self.label.text = @"拉丝机打算几点善良的甲氨蝶呤";
    [self addSubview:self.label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
