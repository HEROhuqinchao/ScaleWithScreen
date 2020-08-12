//
//  UILabel+XibScaleAdapter.m
//  FontAdap
//
//  Created by Destiny on 2019/4/2.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "UILabel+XibScaleAdapter.h"
#import <objc/runtime.h>

@implementation UILabel (XibScaleAdapter)

+ (void)load {
    Method swizeeMethod = class_getInstanceMethod([UILabel class], @selector(d_awakeFromNib));
    Method originalMethod = class_getInstanceMethod([UILabel class], @selector(awakeFromNib));
    
    if (!class_addMethod([UILabel class], @selector(awakeFromNib), method_getImplementation(swizeeMethod), method_getTypeEncoding(swizeeMethod))) {
        
        method_exchangeImplementations(originalMethod,swizeeMethod);
    } else {
        class_replaceMethod(self, @selector(d_awakeFromNib), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
}

- (void)d_awakeFromNib {
    CGFloat scaleSize = [UIScreen mainScreen].bounds.size.width/375;
    self.font = [UIFont fontWithDescriptor:self.font.fontDescriptor size:self.font.pointSize * scaleSize];
    
    [self d_awakeFromNib];
}

@end
