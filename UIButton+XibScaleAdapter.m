//
//  UIButton+XibScaleAdapter.m
//  FontAdap
//
//  Created by Destiny on 2019/4/2.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "UIButton+XibScaleAdapter.h"
#import <objc/runtime.h>

@implementation UIButton (XibScaleAdapter)

+ (void)load {
    Method swizeeMethod = class_getInstanceMethod([UIButton class], @selector(button_awakeFromNib));
    Method originalMethod = class_getInstanceMethod([UIButton class], @selector(awakeFromNib));
    
    if (!class_addMethod([UIButton class], @selector(awakeFromNib), method_getImplementation(swizeeMethod), method_getTypeEncoding(swizeeMethod))) {
        
        method_exchangeImplementations(originalMethod,swizeeMethod);
    } else {
        class_replaceMethod(self, @selector(button_awakeFromNib), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}

- (void)button_awakeFromNib {
    CGFloat scaleSize = [UIScreen mainScreen].bounds.size.width/375;
    self.titleLabel.font = [UIFont fontWithDescriptor:self.titleLabel.font.fontDescriptor size:self.titleLabel.font.pointSize * scaleSize];
    
    [self button_awakeFromNib];
}

@end
