//
//  IndexHeaderCell.m
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexHeaderCell.h"
#import "Masonry.h"

@implementation IndexHeaderCell

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if(!self.scroll){
        self.scroll = UIScrollView.new;
    }
    if(!self.page){
        self.page = UIPageControl.new;
    }
    
    [self.contentView addSubview:self.scroll];
    [self.contentView addSubview:self.page];
    
    self.scroll.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.scroll.pagingEnabled = YES;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;

    [self makeConsrtaints];
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.scroll = UIScrollView.new;
//        self.page = UIPageControl.new;
//        
//        [self addSubview:self.scroll];
//        [self addSubview:self.page];
//        
//        self.scroll.backgroundColor = [UIColor redColor];
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(self.scroll.mas_height);
//        }];
//        [self makeConsrtaints];
//    }
//    return self;
//}

- (void)makeConsrtaints{
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        // height : width = 270 : 720
        make.height.equalTo(self.scroll.mas_width).multipliedBy(0.375);
    }];
    
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scroll.mas_bottom).offset(-5);
        make.centerX.equalTo(self.scroll.mas_centerX);
    }];
}
@end
