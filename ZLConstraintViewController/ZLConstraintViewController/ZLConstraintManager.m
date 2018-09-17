//
//  ZLConstraintManager.m
//  ZLConstraintViewController
//
//  Created by Damo on 2018/9/17.
//  Copyright © 2018年 Damo. All rights reserved.
//

#import "ZLConstraintManager.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface ZLConstraintManager()

@property (nonatomic, strong) NSMutableArray *constraintArray;

@end

@implementation ZLConstraintManager {
    BOOL _isChange;  //是否改变了约束
    NSArray *_ignorViews;
}

+ (instancetype)manager {
    ZLConstraintManager *manager = [[ZLConstraintManager alloc] init];
    manager.constraintArray = [NSMutableArray array];
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _ignorViews = [NSArray array];
    
    }
    return self;
}

- (void)setSubViewsConstraint:(UIView *)superView {
    [self setSubViewsConstraint:superView withIgnorViews:nil];
}

- (void)setSubViewsConstraint:(UIView *)superView withIgnorViews:(NSArray <UIView *>*)array {
    if (_isChange) {
        return;
    }
    
    if (superView.subviews.count == 0) return;
    
    if (_constraintArray == nil) {
        _constraintArray = [NSMutableArray array];
    }
    
    _isChange = true;
    if (array) {
        _ignorViews = [NSArray arrayWithArray:array.copy];
    }
    for (UIView *view in superView.subviews) {
        [self setSubviewsConstraint:view ignoreLableWH:_ignoreLabelWH];
    }
    [superView layoutIfNeeded];
}

- (void)setSubviewsConstraint:(UIView *)view {
    [self setSubviewsConstraint:view ignoreLableWH:NO];
}


- (void)setSubviewsConstraint:(UIView *)view ignoreLableWH:(BOOL)isIgnore {
    float rate = (float)[UIScreen mainScreen].bounds.size.width / 375.0;
    if (view.superview) {
        NSArray *array  = view.superview.constraints;
        NSArray *sizeArray = view.constraints;
        
        for (NSLayoutConstraint *constraint in array) {
            if (![_constraintArray containsObject:constraint]) {
                constraint.constant *= rate;
                constraint.constant = round(constraint.constant * 10) / 10;
                [_constraintArray addObject:constraint];
            }
        }
        
        if (view.subviews.count > 0 && ![view isKindOfClass:[UIScrollView class]]) {
            for (UIView *sview in view.subviews) {
                [self setSubviewsConstraint:sview ignoreLableWH:isIgnore];
            }
        } else {
            for (NSLayoutConstraint *constraint in sizeArray) {
                if (constraint.firstAttribute == NSLayoutAttributeWidth ||
                    constraint.firstAttribute == NSLayoutAttributeHeight) {
                    if (![_constraintArray containsObject:constraint] &&
                        ![_ignorViews containsObject:view] &&
                        !(isIgnore && [view isKindOfClass:[UILabel class]])) {
                        constraint.constant *= rate;
                        constraint.constant = round(constraint.constant * 10) / 10;
                        [_constraintArray addObject:constraint];
                    }
                }
                
            }
        }
    }
}

- (void)setSubViewsConstraint:(UIView *)superView withIgnorViews:(NSArray <UIView *>*)array ignoreLableWH:(BOOL)isIgnore {
    if (_isChange) {
        return;
    }
    
    if (superView.subviews.count == 0) return;
    
    if (_constraintArray == nil) {
        _constraintArray = [NSMutableArray array];
    }
    
    _isChange = true;
    if (array) {
        _ignorViews = [NSArray arrayWithArray:array.copy];
    }
    for (UIView *view in superView.subviews) {
        [self setSubviewsConstraint:view ignoreLableWH:isIgnore];
    }
    [superView layoutIfNeeded];
}

- (void)dealloc {
    _ignorViews = nil;
    [_constraintArray removeAllObjects];
}

@end
