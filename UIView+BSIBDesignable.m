//
//  UIView+BSIBDesignable.m
//  ZhiJianLanProject
//
//  Created by 胡勤超 on 2020/8/11.
//  Copyright © 2020 胡勤超. All rights reserved.
//

#import "UIView+BSIBDesignable.h"
#import <objc/runtime.h>

// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)
@implementation UIView (BSIBDesignable)

//定义常量 必须是C语言字符串
static char *AdaptCornerRadiusKey = "AdaptCornerRadiusKey";

- (BOOL)adaptCornerRadius{
    NSNumber *number = objc_getAssociatedObject(self, AdaptCornerRadiusKey);
    return number.boolValue;
}

- (void)setAdaptCornerRadius:(BOOL)adaptCornerRadius {
    NSNumber *number = @(adaptCornerRadius);
    objc_setAssociatedObject(self, AdaptCornerRadiusKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (adaptCornerRadius){
        self.layer.cornerRadius = AdaptW(self.layer.cornerRadius);
    }
}
@end
