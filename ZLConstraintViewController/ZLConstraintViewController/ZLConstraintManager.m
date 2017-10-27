//
//  ZLConstraintManager.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/27.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintManager.h"

@interface ZLConstraintManager()

@property (nonatomic, strong)NSMutableArray *constraintArray;

@end

@implementation ZLConstraintManager {
    BOOL _isChangeConstriant;
}

+ (instancetype)manager {
    ZLConstraintManager *manager= [[ZLConstraintManager alloc] init];
    manager.constraintArray = [NSMutableArray array];
    return manager;
}

- (void)setSubViewsConstraints:(UIView *)superView {
    if (_isChangeConstriant) {
        return;
    }
    
    if (superView.subviews.count == 0) return;
    
    if (_constraintArray == nil) {
        _constraintArray = [NSMutableArray array];
    }
    
    for (UIView *view in superView.subviews) {
        //        NSLog(@"view = %@",view);
        [self setSubviewsConstraint:view];
        //        NSLog(@"--------------------------------------------\n\n\n\n");
    }
    
    [superView layoutIfNeeded];
    _isChangeConstriant = true;
}

- (void)setSubviewsConstraint:(UIView *)view {
    float rate = (float)[UIScreen mainScreen].bounds.size.width / 375.0;
    if (view.superview) {
//        NSLog(@"\n\nview: %@\nsuperView:%@",view,view.superview);
        NSArray *array  = view.superview.constraints;
        NSArray *sizeArray = view.constraints;
//        NSLog(@"super array = %@\nself sizeArray = %@",array,sizeArray);
        
        for (NSLayoutConstraint *constraint in array) {
            if (![_constraintArray containsObject:constraint]) {
                NSLog(@"change:%@",constraint);
                
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
                    NSLog(@"😆sizeContraint = %@",constraint);
                    constraint.constant = constraint.constant * rate;
                    NSLog(@"rate = %f,😆sizeContraint:origin = %lf,new = %lf",rate,constraint.constant / rate,constraint.constant);
                }
            }
        }
    }
}

@end
