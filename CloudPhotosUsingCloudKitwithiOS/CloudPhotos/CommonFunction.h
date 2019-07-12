//
//  CommonFunction.h
//  littleboss
//
//  Created by linchengjian on 16/9/21.
//  Copyright © 2016年 dgbiz. All rights reserved.
//

//#import "BaseViewController.h"
#define kAppLogError @"zfx_logError"
#define kAppRegionLastTime @"zfx_regiontime"
#define kAppPhoneid @"zfx_phoneid"
typedef enum {
    CacheTypeUserInfo = 0,
    CacheTypeGoodsDetail = 1,
    CacheTypeGoodsCategory = 2,
    CacheTypeGoodsList = 3,
    CacheTypeOrderDetail = 4,
    CacheTypeOrderList = 5
    
} CacheType;

@interface CommonFunction : NSObject
+ (NSString *) getCahcekeyByObjectId:(NSString *) objectId forKeyType:(CacheType) type;
+ (void) setPersistentValue:(id)value forKey:(NSString *) key;
+ (NSString *)getPersistentValueForKey:(NSString *)key;
+ (void) removePersistentValueForKey:(NSString*)key;
+ (void)setCacheValue:(id)value forKey:(NSString *) key;
+ (id) getCacheValueForKey:(NSString *)key;
//+ (void)removeCacheValues;
+ (NSString *)getDocumentFolderPath;
+ (NSString *)getCacheFolderPath;
+ (BOOL)delFileWithPath:(NSString *)filePath;
+(void)logNetErrorOfPage:(NSString *)page Function:(NSString *)function ErrorCode:(NSInteger)code Description:(NSString *)description;
+(void)logHtmlErrorOfHtmlFile:(NSString *) htmlFile ErrorCode:(NSString *)code Description:(NSString *)description;
+(void)showMessge:(NSString *)msg;
#pragma mark- 验证
@end
