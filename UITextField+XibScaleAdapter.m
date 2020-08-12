//
//  UITextField+XibScaleAdapter.m
//  FontAdap
//
//  Created by Destiny on 2019/4/2.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "UITextField+XibScaleAdapter.h"
#import <objc/runtime.h>

@implementation UITextField (XibScaleAdapter)

+ (void)load {
    Method swizeeMethod = class_getInstanceMethod([UITextField class], @selector(textField_awakeFromNib));
    Method originalMethod = class_getInstanceMethod([UITextField class], @selector(awakeFromNib));
    
    if (!class_addMethod([UITextField class], @selector(awakeFromNib), method_getImplementation(swizeeMethod), method_getTypeEncoding(swizeeMethod))) {
        
        method_exchangeImplementations(originalMethod,swizeeMethod);
    } else {
        class_replaceMethod(self, @selector(textField_awakeFromNib), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}

- (void)textField_awakeFromNib {
    CGFloat scaleSize = [UIScreen mainScreen].bounds.size.width/375;
    self.font = [UIFont fontWithDescriptor:self.font.fontDescriptor size:self.font.pointSize * scaleSize];
    
    [self textField_awakeFromNib];
}

@end
