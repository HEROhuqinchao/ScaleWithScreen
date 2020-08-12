//
//  NSLayoutConstraint+ModifyDefault.m
//  ZhiJianLanProject
//
//  Created by 胡勤超 on 2020/8/11.
//  Copyright © 2020 胡勤超. All rights reserved.
//

#import "NSLayoutConstraint+ModifyDefault.h"
#import <objc/runtime.h>
@implementation NSLayoutConstraint (ModifyDefault)

+(void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}
- (id)myInitWithCoder:(NSCoder *)aDecode {
    
    [self myInitWithCoder:aDecode];
    if (self) {
        
        if (![self.identifier isEqualToString:@"333"]) {
            self.adapterScreen = YES;
        }
    }
    return self;
}
@end
