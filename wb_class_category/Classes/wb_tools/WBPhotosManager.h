//
//  WBPhotosManager.h
//  happyBear
//
//  Created by wenbin on 2017/2/4.
//  Copyright © 2017年 嗨皮熊. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^saveCompleteBlock)(BOOL saveSeccess);

/**
 *  保存视频保存图片类
 */
@interface WBPhotosManager : NSObject

+ (WBPhotosManager *)shareManager;

/**
 *  保存视频到本地
 *  filePathStr：该视频的沙盒地址
 */
- (void)saveVideoWithFileURLPathString:(NSString *)filePathStr withSaveComplete:(saveCompleteBlock)block;
/**
 *  保存视频到本地
 *  filePath：该视频的沙盒url
 */
- (void)saveVideoWithFileURLPath:(NSURL *)filePath withSaveComplete:(saveCompleteBlock)block;


/**
 *  保存图片到本地 
 *  img：需要保存的图片
 */
- (void)saveImageWithImage:(UIImage *)img withCompleteBlock:(saveCompleteBlock)block;
/**
 *  保存图片到本地 
 *  PathStr：图片的沙盒地址
 */
- (void)saveImageWithFileUrlPathString:(NSString *)PathStr withCompleteBlock:(saveCompleteBlock)block;
/**
 *  保存图片到本地 
 *  Path：该图片的沙盒url
 */
- (void)saveImageWithFileUrlPath:(NSURL *)Path withCompleteBlock:(saveCompleteBlock)block;


@end
