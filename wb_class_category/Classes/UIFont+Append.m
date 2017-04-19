//
//  UIFont+Append.m
//  Pods
//
//  Created by wenbin on 2017/4/19.
//
//

#import "UIFont+Append.h"
#import "WBToolsConst.h"
@implementation UIFont (Append)

#pragma mark - 遍历系统字体
+ (void) enumerateFonts
{
    for(NSString *familyName in [UIFont familyNames]){
        WBLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]){
            WBLog(@"\t%@",fontName);         //*输出字体族科下字样名字
        }
    }
}

/**细 字体*/
+ (UIFont *)FontNameLightWithSize:(CGFloat)size
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Light" size:size];
    }else
        return [UIFont systemFontOfSize:size];
}
/**正常字体*/
+ (UIFont *)FontNameRegularWithSize:(CGFloat)size
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    }else
        return [UIFont systemFontOfSize:size];
}
/**中粗字体*/
+ (UIFont *)FontNameMediumWithSize:(CGFloat)size
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    }else
        return [UIFont fontWithName:@"STHeitiSC-Medium" size:size];
}
/**粗字体*/
+ (UIFont *)FontNameSemiboldWithSize:(CGFloat)size
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    }else
        return [UIFont fontWithName:@"STHeitiSC-Medium" size:size];
}

@end
