//
//  NSLayoutConstraint+BSIBDesignable.h
//  ZhiJianLanProject
//
//  Created by 胡勤超 on 2020/6/30.
//  Copyright © 2020 胡勤超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (BSIBDesignable)
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;
@end

NS_ASSUME_NONNULL_END
