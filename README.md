# ScaleWithScreen
iOS：xib屏幕适配

经过在网上找到许多方法集中处理，终于可以进行XIB屏幕适配了 ， 一下是参考各位大佬的网页链接。
/**
参考  小生不怕  的屏幕缩放适配

第二种：利用IBInspectable关键字和分类

   后来我到了新公司接手了个旧项目，工程里几乎所有的界面都是用xib来写的。惨了，UI设计师同事还跟我说，新写的界面都要等比例缩放，不然就要各种大小不一的屏幕对一下，我累她也累。
   就是因为这种适配的问题，我两年前开始放弃了可视化的布局界面方式，改用纯代码。这次我想保持项目风格的统一，而且也想再次拥抱storyboard和xib,通过查找资料找到利用IBInspectable关键字和分类来实现等比例缩放的功能 （ IBInspectable 就是能够让你的自定义 UIView 的属性出现在 IB 中 Attributes inspector）。具体做法就是：

1.写一个NSLayoutConstraint的分类
2.添加adapterScreen的属性（Bool 值，yes代表需要对屏幕进行等比例适配）

  #import <UIKit/UIKit.h>

  @interface NSLayoutConstraint (BSIBDesignable)

  @property(nonatomic, assign) IBInspectable BOOL adapterScreen;

  @end
  
3.在adapterScreen的set方法里面对NSLayoutConstraint对象的constant值进行换算

  #import "NSLayoutConstraint+BSIBDesignable.h"
  #import <objc/runtime.h>

  // 基准屏幕宽度
  #define kRefereWidth 375.0
  // 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
  #define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)


  @implementation NSLayoutConstraint (BSIBDesignable)

  //定义常量 必须是C语言字符串
  static char *AdapterScreenKey = "AdapterScreenKey";

  - (BOOL)adapterScreen{
      NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
      return number.boolValue;
  }

  - (void)setAdapterScreen:(BOOL)adapterScreen {
    
      NSNumber *number = @(adapterScreen);
      objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
      if (adapterScreen){
          self.constant = AdaptW(self.constant);
      }
  }

  @end

作者：小生不怕
链接：https://www.jianshu.com/p/cf049bebdc6c
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/

因为这种方法出现了控件过多，一个一个去设置又过于麻烦，我就又百度了许多方法，
首先是  春暖花已开 简书地址 https://www.jianshu.com/u/602f43080ed0  
模仿他的代码，使用 method_exchangeImplementations 方法交换 触发self.adapterScreen = YES;

/**

  #import "NSLayoutConstraint+MZExtension.h"

  #import <objc/runtime.h>

  @implementation NSLayoutConstraint (MZExtension)

  + (void)load {
    
      Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
      Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
      method_exchangeImplementations(imp, myImp);
  }

  - (id)myInitWithCoder:(NSCoder *)aDecode {
    
      [self myInitWithCoder:aDecode];
      if (self) {
        
          if (![self.identifier isEqualToString:@"333"]) {
              self.adapterScreen = YES;//触发self.adapterScreen = YES;
          }
      }
      return self;
  }

  @end

*/

最后进行字体和圆角适配

