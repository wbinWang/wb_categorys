//
//  WBToolsConst.h
//  Pods
//
//  Created by wenbin on 2017/4/19.
//
//

#ifndef WBToolsConst_h
#define WBToolsConst_h

//获取设备屏幕宽高
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
//基于6的适配
#define kCURRENT_WIDTH(width)  (width)*(kWIDTH/375.0)
#define kCURRENT_HEIGHT(height) (height)*(kHEIGHT/667.0)
//横屏基于6的适配
#define kCURRENT_WIDTH_Landscape(width) (width)*(kWIDTH/667.0)
//检测为6p
#define kIS_IPHONE_6P (kHEIGHT == 736.0)

//小头像尺寸
#define kLITTLE_AVATAR_W 40
//默认头像图片
#define kAVATAR_PLACE_IMG [UIImage imageNamed:@"zhangweitu_600.png"]

//主题颜色
#define kThemeColor [UIColor colorWithRed:0.16f green:0.17f blue:0.43f alpha:1.00f]

//自定义Log
#ifdef DEBUG
#define WBLog(...) NSLog(__VA_ARGS__)
#else
#define WBLog(...)
#endif

//iOS系统版本
#define kiOS_VERSION ([[UIDevice currentDevice].systemVersion doubleValue])

//缓存地址
#define kCaches [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//SDWebImage图片缓存地址
#define kCachesSDImagePath [kCaches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"]

#pragma mark ---------------------- 数据持久化
#define kUSER_DEfAULTS [NSUserDefaults standardUserDefaults]
//存储用户信息的plist
#define kUSER_INFO_PLIST @"selfUserInfo.plist"
//用户ID guid
#define kACCOUNT_ID @"Account_Guid"

//分享
#define kWeixinShare @"kWeixinShare"
#define kWeixinFriendShare @"kWeixinFriendShare"
#define kWeiboShare @"kWeiboShare"
#define kQQShare @"kQQShare"

//本地开屏幕图片地址
#define kADImageUrl @"kADImageUrl"

#pragma mark ---------------------- 通知
#define kNOTI_DEFAULT [NSNotificationCenter defaultCenter]

//获得RGB颜色
#define kCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kCOLOR2(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/100.0]

//随机色
#ifdef DEBUG
#define kRANDOM_COlOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1]
#else
#define kRANDOM_COlOR [UIColor clearColor]
#endif

#pragma mark -------------------------枚举
//分享枚举
typedef NS_ENUM(NSUInteger , WBShareType) {
    WBShareNone = 0,
    WBShareWeixin ,
    WBShareWXFriend ,
    WBShareWeibo ,
    WBShareQQ
};
#endif /* WBToolsConst_h */
