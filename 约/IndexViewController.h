//
//  ViewController.h
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *imageURL;
@end

