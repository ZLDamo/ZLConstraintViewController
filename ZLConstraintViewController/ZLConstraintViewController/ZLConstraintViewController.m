//
//  ZLConstraintViewController.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/23.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintViewController.h"
#import "ZLConstraintManager.h"
#import "ZLConstraintCell.h"

@interface ZLConstraintViewController() <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ZLConstraintViewController {
    ZLConstraintManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:@"ZLConstraintCell" bundle:nil] forCellReuseIdentifier:@"reuseId"];
    
    _manager = [ZLConstraintManager manager];
    [_manager setSubViewsConstraints:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLConstraintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
