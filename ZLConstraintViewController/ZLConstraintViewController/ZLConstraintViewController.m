//
//  ZLConstraintViewController.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/23.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintViewController.h"
#import <MyFrameWork/ZLTool.h>

@implementation ZLConstraintViewController {
    NSMutableArray *_marray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _marray = [NSMutableArray array];
    for (UIView *view in self.view.subviews) {
        //        NSLog(@"view = %@",view);
        [self setSubviewsConstraint:view];
        //        NSLog(@"--------------------------------------------\n\n\n\n");
    }
    for (int  i = 9; i < 99; i ++) {
        NSLog(@"i = %d",i);
        for (int j = 0; i <100; j ++) {
            NSLog(@"j = %d",j);
            if (j == 3) return;
        }
    }
    
    [self.view layoutIfNeeded];
}

- (void)setSubviewsConstraint:(UIView *)view {
    float rate = (float)[UIScreen mainScreen].bounds.size.width / 375.0;
    if (view.superview) {
//        NSLog(@"\n\nview: %@\nsuperView:%@",view,view.superview);
        NSArray *array  = view.superview.constraints;
        NSArray *sizeArray = view.constraints;
//        NSLog(@"super array = %@\nself sizeArray = %@",array,sizeArray);
        
        for (NSLayoutConstraint *constraint in array) {
            if (![_marray containsObject:constraint]) {
                //                NSLog(@"%@",constraint);
                
                constraint.constant *= rate;
                constraint.constant = round(constraint.constant * 10) / 10;
                [_marray addObject:constraint];
            }
        }
        
        if (view.subviews.count > 0) {
            for (UIView *sview in view.subviews) {
                NSLog(@"%@",sview);
                [self setSubviewsConstraint:sview];
            }
        } else {
            for (NSLayoutConstraint *constraint in sizeArray) {
                if (constraint.firstAttribute == NSLayoutAttributeWidth ||
                    constraint.firstAttribute == NSLayoutAttributeHeight) {
//                    NSLog(@"😆sizeContraint = %@",constraint);
                    constraint.constant = constraint.constant * rate;
                    constraint.constant = round(constraint.constant * 10) / 10;
//                    NSLog(@"rate = %f,😆sizeContraint:origin = %lf,new = %lf",rate,constraint.constant / rate,constraint.constant);
                }
            }
        }
    }
}

- (BOOL)isTopConstraint:(NSLayoutConstraint *)constraint
{
    return  [self firstItemMatchesTopConstraint:constraint] ||
    [self secondItemMatchesTopConstraint:constraint];
}

- (BOOL)firstItemMatchesTopConstraint:(NSLayoutConstraint *)constraint
{
    return constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeTop;
}

- (BOOL)secondItemMatchesTopConstraint:(NSLayoutConstraint *)constraint
{
    return constraint.secondItem == self && constraint.secondAttribute == NSLayoutAttributeTop;
}

- (BOOL)firstItemMatchesBottomConstraint:(NSLayoutConstraint *)constraint
{
    return constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeBottom;
}

- (BOOL)secondItemMatchesBottomConstraint:(NSLayoutConstraint *)constraint
{
    return constraint.secondItem == self && constraint.secondAttribute == NSLayoutAttributeBottom;
}

@end
