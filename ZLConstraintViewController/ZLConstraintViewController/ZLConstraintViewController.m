//
//  ZLConstraintViewController.m
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/23.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import "ZLConstraintViewController.h"

@implementation ZLConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView *view in self.view.subviews) {
        //        NSLog(@"view = %@",view);
        [self setSubviewsConstraint:view];
        //        NSLog(@"--------------------------------------------\n\n\n\n");
    }
    
    [self.view layoutIfNeeded];
}


- (void)setSubviewsConstraint:(UIView *)view {
    float rate = (float)[UIScreen mainScreen].bounds.size.width / 375.0;
    if (view.superview) {
        NSLog(@"\n\nview: %@\nsuperView:%@",view,view.superview);
        NSArray *array  = view.superview.constraints;
        NSArray *sizeArray = view.constraints;
        
        for (NSLayoutConstraint *constraint in array) {
            if (constraint.firstItem == view ||
                constraint.secondItem == view) {
                NSLog(@"😎first = %@",constraint);
                float temp =  rate;
                
                if (view.superview == constraint.firstItem ||
                    view.superview == constraint.secondItem ) {
                    constraint.constant *= temp;
                } else {
                    if (@available(iOS 9.0, *)) {
                        if ([constraint.firstItem isMemberOfClass:[UILayoutGuide class]] ||[constraint.secondItem isMemberOfClass:[UILayoutGuide class]]) {
                            constraint.constant *= temp;
                            NSLog(@"system: %@",constraint);
                        } else {
                            constraint.constant *= sqrt(temp);
                            temp = sqrt(temp);
                        }
                       
                    } else {
                        //非父子关系,约束是相互的
                        constraint.constant *= sqrt(temp);
                        temp = sqrt(temp);
                    }
                }
                    
                NSLog(@"rate = %f,😎first:origin = %lf,new = %lf",temp,constraint.constant / temp,constraint.constant);
            }
        }
        
        for (NSLayoutConstraint *constraint in sizeArray) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth ||
                constraint.firstAttribute == NSLayoutAttributeHeight) {
                NSLog(@"😆sizeContraint = %@",constraint);
                constraint.constant = constraint.constant * rate;
                NSLog(@"rate = %f,😆sizeContraint:origin = %lf,new = %lf",rate,constraint.constant / rate,constraint.constant);
            }
        }
        
        if (view.subviews.count > 0) {
            for (UIView *sview in view.subviews) {
                NSLog(@"%@",sview);
                [self setSubviewsConstraint:sview];
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
