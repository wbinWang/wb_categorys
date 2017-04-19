//
//  WBPhotosManager.m
//  happyBear
//
//  Created by wenbin on 2017/2/4.
//  Copyright © 2017年 嗨皮熊. All rights reserved.
//

#import "WBPhotosManager.h"
#import <Photos/Photos.h>
@interface WBPhotosManager()
{
    NSString *_folderName;
    BOOL _isExistFolder;
}
@property (nonatomic , copy)saveCompleteBlock completeBlock;

/**
 *  图片的文件地址
 */
@property (nonatomic , strong)NSURL *imageFilePath;
/**
 *  图片
 */
@property (nonatomic , weak)UIImage *needSaveImg;
/**
 *  视频的文件地址
 */
@property (nonatomic , strong)NSURL *videoFilePath;

@end
@implementation WBPhotosManager

#pragma mark - 初始化
+ (WBPhotosManager *)shareManager
{
    static WBPhotosManager *manager;
    if (!manager) {
        manager = [[WBPhotosManager alloc]init];
    }
    return manager;
}
- (instancetype)init
{
    if (self = [super init]) {
        _folderName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
//        _folderName = @"憨太星球";
        if (![self isExistSelfFolder]) {
            [self createSelfFolder];
        }
    }
    return self;
}
//判断是否存在该文件夹
- (BOOL)isExistSelfFolder
{
    //首先获取用户手动创建相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    __block BOOL isExisted = NO;
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        //folderName是我们写入照片的相册
        if ([assetCollection.localizedTitle isEqualToString:_folderName])  {
            isExisted = YES;
        }
    }];
    _isExistFolder = isExisted;
    return isExisted;
}
//创建相册文件夹
- (void)createSelfFolder
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //添加文件夹
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:_folderName];
            
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            XXLog(@"创建相册文件夹成功!");
            _isExistFolder = YES;
            
            //再次保存~
            if (self.videoFilePath) {
                [self saveVideoWithFileURLPath:self.videoFilePath withSaveComplete:self.completeBlock];
            }else if (self.needSaveImg) {
                [self saveImageWithImage:self.needSaveImg withCompleteBlock:self.completeBlock];
            }else if (self.imageFilePath) {
                [self saveImageWithFileUrlPath:self.imageFilePath withCompleteBlock:self.completeBlock];
            }
            
        } else {
            XXLog(@"创建相册文件夹失败:%@", error);
        }
    }];
}
#pragma mark - 保存视频~
/**
 *  保存视频到本地 沙盒地址
 */
- (void)saveVideoWithFileURLPathString:(NSString *)filePathStr withSaveComplete:(saveCompleteBlock)block
{
    [self saveVideoWithFileURLPath:[NSURL fileURLWithPath:filePathStr] withSaveComplete:block];
}
/**
 *  保存视频到本地 沙盒url
 */
- (void)saveVideoWithFileURLPath:(NSURL *)filePath withSaveComplete:(saveCompleteBlock)block
{
    self.videoFilePath = filePath;
    self.completeBlock = block;
    
    if (!_isExistFolder) {
        return;
    }
    //标识保存到系统相册中的标识
    __block NSString *localIdentifier;
    
    //首先获取相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        
        //folderName是我们写入照片的相册
        XXLog(@"相册文件夹名字%@",assetCollection.localizedTitle);
        if ([assetCollection.localizedTitle isEqualToString:_folderName])  {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                //请求创建一个Asset
                PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:filePath];
                //请求编辑相册
                PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                //为Asset创建一个占位符，放到相册编辑请求中
                PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
                
                //相册中添加视频
                [collectonRequest addAssets:@[placeHolder]];
                
                localIdentifier = placeHolder.localIdentifier;
                
            } completionHandler:^(BOOL success, NSError *error) {
                
                if (self.completeBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.completeBlock(success);
                    });
                }
                if (success) {
                    
                    XXLog(@"保存视频成功!");
                    self.videoFilePath = nil;
                    
                } else {
                    XXLog(@"保存视频失败:%@", error);
                    //转存到系统相册
                }
                self.completeBlock = nil;
            }];
        }
    }];
}
#pragma mark - 保存本地
/**
 *  保存图片到本地 视频沙盒地址
 */
- (void)saveImageWithFileUrlPathString:(NSString *)PathStr withCompleteBlock:(saveCompleteBlock)block
{
    [self saveImageWithFileUrlPath:[NSURL fileURLWithPath:PathStr] withCompleteBlock:block];
}
/**
 *  保存图片到本地 视频沙盒url
 */
- (void)saveImageWithFileUrlPath:(NSURL *)Path withCompleteBlock:(saveCompleteBlock)block
{
    self.imageFilePath = Path;
    [self saveImageWithImage:nil orFilePathUrl:Path withCompleteBlock:block];
}
/**
 *  保存图片到本地 1
 */
- (void)saveImageWithImage:(UIImage *)img withCompleteBlock:(saveCompleteBlock)block
{
    self.needSaveImg = img;
    [self saveImageWithImage:img orFilePathUrl:nil withCompleteBlock:block];
}
/**
 *  保存图片到本地
 */
- (void)saveImageWithImage:(UIImage *)img orFilePathUrl:(NSURL *)pathUrl withCompleteBlock:(saveCompleteBlock)block
{
    self.completeBlock = block;
    
    if (!_isExistFolder) {
        return;
    }

    //首先获取相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        //Camera Roll是我们写入照片的相册
        if ([assetCollection.localizedTitle isEqualToString:_folderName])  {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *assetRequest;
                if (img) {
                    assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
                }else {
                    assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:pathUrl];
                }
                //请求编辑相册
                PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                //为Asset创建一个占位符，放到相册编辑请求中
                PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
                //相册中添加照片
                [collectonRequest addAssets:@[placeHolder]];
                
            } completionHandler:^(BOOL success, NSError *error) {
                
                if (self.completeBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.completeBlock(success);
                    });
                }
                if (success) {
                    XXLog(@"保存图片成功!");
                } else {
                    XXLog(@"保存图片失败:%@", error);
                }
                self.needSaveImg = nil;
                self.imageFilePath = nil;
                self.completeBlock = nil;
            }];
        }
    }];
}
@end
