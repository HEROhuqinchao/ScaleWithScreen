//
//  UITextView+XibScaleAdapter.m
//  ZhiJianLanProject
//
//  Created by 胡勤超 on 2020/8/12.
//  Copyright © 2020 胡勤超. All rights reserved.
//

#import "UITextView+XibScaleAdapter.h"
#import <objc/runtime.h>
@implementation UITextView (XibScaleAdapter)
+ (void)load {
    Method swizeeMethod = class_getInstanceMethod([UITextField class], @selector(textView_awakeFromNib));
    Method originalMethod = class_getInstanceMethod([UITextField class], @selector(awakeFromNib));
    
    if (!class_addMethod([UITextField class], @selector(awakeFromNib), method_getImplementation(swizeeMethod), method_getTypeEncoding(swizeeMethod))) {
        
        method_exchangeImplementations(originalMethod,swizeeMethod);
    } else {
        class_replaceMethod(self, @selector(textView_awakeFromNib), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}

- (void)textView_awakeFromNib {
    CGFloat scaleSize = [UIScreen mainScreen].bounds.size.width/375;
    self.font = [UIFont fontWithDescriptor:self.font.fontDescriptor size:self.font.pointSize * scaleSize];
    
    [self textView_awakeFromNib];
}

@end
