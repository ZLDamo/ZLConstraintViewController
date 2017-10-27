//
//  ZLConstraintManager.h
//  ZLConstraintViewController
//
//  Created by Damo on 2017/10/27.
//  Copyright © 2017年 Damo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLConstraintManager : NSObject

+ (instancetype)manager;

- (void)setSubViewsConstraints:(UIView *)superView;

@end
