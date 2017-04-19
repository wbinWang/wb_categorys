//
//  UIFont+Append.h
//  Pods
//
//  Created by wenbin on 2017/4/19.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (Append)

/**遍历字体*/
+ (void)enumerateFonts;

/**细 字体*/
+ (UIFont *)FontNameLightWithSize:(CGFloat)size;
/**正常字体*/
+ (UIFont *)FontNameRegularWithSize:(CGFloat)size;
/**中粗字体*/
+ (UIFont *)FontNameMediumWithSize:(CGFloat)size;
/**粗字体*/
+ (UIFont *)FontNameSemiboldWithSize:(CGFloat)size;

@end
