//
//  UIView+ModifyDefault.m
//  ZhiJianLanProject
//
//  Created by 胡勤超 on 2020/8/11.
//  Copyright © 2020 胡勤超. All rights reserved.
//

#import "UIView+ModifyDefault.h"
#import <objc/runtime.h>
@implementation UIView (ModifyDefault)
+(void)load{
    Method swizeeMethod = class_getInstanceMethod([UILabel class], @selector(view_awakeFromNib));
    Method originalMethod = class_getInstanceMethod([UILabel class], @selector(awakeFromNib));
    
    if (!class_addMethod([UILabel class], @selector(awakeFromNib), method_getImplementation(swizeeMethod), method_getTypeEncoding(swizeeMethod))) {
        
        method_exchangeImplementations(originalMethod,swizeeMethod);
    } else {
        class_replaceMethod(self, @selector(view_awakeFromNib), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}
- (void)view_awakeFromNib {
    self.adaptCornerRadius =YES;
    
    [self view_awakeFromNib];
}
@end
