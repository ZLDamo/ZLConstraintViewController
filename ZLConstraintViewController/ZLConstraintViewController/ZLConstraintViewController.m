//
//  ZLConstraintViewController.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/23.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintViewController.h"
#import "ZLConstraintManager.h"

@implementation ZLConstraintViewController {
    ZLConstraintManager *_manger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manger = [ZLConstraintManager manager];
    [_manger setSubViewsConstraint:self.view];
}



@end
