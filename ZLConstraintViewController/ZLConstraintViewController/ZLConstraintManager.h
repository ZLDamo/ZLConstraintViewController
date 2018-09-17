//
//  ZLConstraintManager.h
//  ZLConstraintViewController
//
//  Created by Damo on 2018/9/17.
//  Copyright © 2018年 Damo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLConstraintManager : NSObject

//UILable的宽高是否适配
@property (nonatomic, getter = isIgnoreLableWH,assign) BOOL ignoreLabelWH;

+ (instancetype)manager;

- (void)setSubViewsConstraint:(UIView *)superView;

- (void)setSubViewsConstraint:(UIView *)superView withIgnorViews:(NSArray <UIView *>*)array;

- (void)setSubViewsConstraint:(UIView *)superView withIgnorViews:(NSArray <UIView *>*)array ignoreLableWH:(BOOL)isIgnore;

@end
