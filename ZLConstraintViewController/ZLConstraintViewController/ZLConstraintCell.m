//
//  ZLConstraintCell.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/27.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintCell.h"

@implementation ZLConstraintCell {
    NSMutableArray *_constraintArray;
    BOOL _isChange;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _constraintArray = [NSMutableArray array];
    if (!_isChange) {
        [self setSubViewsConstraints:self];
        _isChange = true;
    }
}

- (void)setSubViewsConstraints:(UIView *)superView {
    for (UIView *view in superView.subviews) {
        [self setSubviewsConstraint:view];
    }
    
    [superView layoutIfNeeded];
}

- (void)setSubviewsConstraint:(UIView *)view {
    float rate = (float)[UIScreen mainScreen].bounds.size.width / 375.0;
    if (view.superview) {
        NSLog(@"\n\nview: %@\nsuperView:%@",view,view.superview);
        NSArray *array  = view.superview.constraints;
        NSArray *sizeArray = view.constraints;

        for (NSLayoutConstraint *constraint in array) {
            if (![_constraintArray containsObject:constraint]) {
                constraint.constant *= rate;
                [_constraintArray addObject:constraint];
            }
        }
        
        if (view.subviews.count > 0 && ![view isKindOfClass:[UIScrollView class]]) {
            for (UIView *sview in view.subviews) {
                [self setSubviewsConstraint:sview];
            }
        } else {
            for (NSLayoutConstraint *constraint in sizeArray) {
                if (constraint.firstAttribute == NSLayoutAttributeWidth ||
                    constraint.firstAttribute == NSLayoutAttributeHeight) {
                    if (![_constraintArray containsObject:constraint]) {
                        constraint.constant = constraint.constant * rate;
                        [_constraintArray addObject:constraint];
                    }
                }
            }
        }
    }
}

@end
