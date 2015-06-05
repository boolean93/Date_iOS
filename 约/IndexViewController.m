//
//  ViewController.m
//  约
//
//  Created by BooleanMac on 15/6/5.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexNormalCell.h"
#import "IndexHeaderCell.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:IndexNormalCell.class forCellReuseIdentifier:@"IndexNormalCellIdentifier"];
    [self.tableView registerClass:IndexHeaderCell.class forHeaderFooterViewReuseIdentifier:@"IndexHeaderCellIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexNormalCellIdentifier"];
    NSLog(@"%@", cell.label.text);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

# pragma mark UITableViewDelegate

@end
