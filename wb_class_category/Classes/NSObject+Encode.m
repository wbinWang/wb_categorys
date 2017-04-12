//
//  NSObject+Encode.m
//  Tools
//
//  Created by wenbin on 2017/3/22.
//  Copyright © 2017年 beautyWang. All rights reserved.
//

#import "NSObject+Encode.h"
#import <objc/runtime.h>
@implementation NSObject (Encode)

// 保存到文件
// 在该方法中说明如何存储自定义对象的属性
// 也就说在该方法中说清楚存储自定义对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    for (NSString *propertyName in [self propertysOfSelf]) {
        //创建指向get方法
        SEL getMethod = NSSelectorFromString(propertyName);
        if ([self respondsToSelector:getMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [aCoder encodeObject:[self performSelector:getMethod] forKey:propertyName];
#pragma clang diagnostic pop
        }
    }
}
// 从文件中读取
// 在该方法中说明如何读取保存在文件中的对象
// 也就是说在该方法中说清楚怎么读取文件中的对象
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init]) {
        for (NSString *propertyName in [self propertysOfSelf]) {
            //创建 set 方法
            NSString *firstChar = [propertyName substringToIndex:1].uppercaseString;
            NSString *setMethodName = [NSString stringWithFormat:@"set%@%@:",firstChar,[propertyName substringFromIndex:1]];
            SEL setMethod = NSSelectorFromString(setMethodName);
            if ([self respondsToSelector:setMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:setMethod withObject:[aDecoder decodeObjectForKey:propertyName]];
#pragma clang diagnostic pop
            }
        }
    }
    return self;
}
#pragma mark - 利用runtime 获取属性名
- (NSArray *)propertysOfSelf
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;i < count; i++) {
        Ivar ivar = ivarList[i];
        //获取属性名字
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //去除下划线
        [array addObject:[name substringFromIndex:1]];
    }
    return array;
}

- (void)save
{
    //数据更改
    //    WBUesrInfoModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:BaseInfoModelFilePath];
    
    //    [userModel setValuesForKeysWithDictionary:receiveData];
    
    //    [NSKeyedArchiver archiveRootObject:userModel toFile:BaseInfoModelFilePath];
}


@end
