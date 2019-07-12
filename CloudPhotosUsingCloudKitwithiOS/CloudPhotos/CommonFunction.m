//
//  CommonFunction.m
//  littleboss
//
//  Created by linchengjian on 16/9/21.
//  Copyright © 2016年 dgbiz. All rights reserved.
//

#import "CommonFunction.h"

//#import "UIDevice-Hardware.h"
@implementation CommonFunction

+ (NSString *) getCahcekeyByObjectId:(NSString *) objectId forKeyType:(CacheType) type{
    NSString *key;
    switch (type) {
        case CacheTypeUserInfo:
            key = [NSString stringWithFormat:@"userInfo-%@",objectId];
            break;
        case CacheTypeGoodsList:
            key = [NSString stringWithFormat:@"goodsList-%@",objectId];
            break;
        case CacheTypeGoodsDetail:
            key = [NSString stringWithFormat:@"goodsDetail-%@",objectId];
            break;
        case CacheTypeGoodsCategory:
            key = [NSString stringWithFormat:@"goodsCategory-%@",objectId];
            break;
        case CacheTypeOrderList:
            key = [NSString stringWithFormat:@"orderList-%@",objectId];
            break;
        case CacheTypeOrderDetail:
            key = [NSString stringWithFormat:@"orderDetail-%@",objectId];
            break;
        default:
            key = [objectId copy];
            break;
    }
    return key;
}
+ (void)setPersistentValue:(id)value forKey:(NSString *) key{
    
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:key];
    [setting setObject:value forKey:key];
    [setting synchronize];
}
+ (NSString *)getPersistentValueForKey:(NSString *)key
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *value = [settings objectForKey:key];
    return value;
}
+(void) removePersistentValueForKey:(NSString*)key{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:key];
    [setting synchronize];
}

+ (void)setCacheValue:(id)value forKey:(NSString *) key{
    
    NSMutableDictionary *cacheDictionary=[[NSMutableDictionary alloc]initWithContentsOfFile:[[CommonFunction getCacheFolderPath] stringByAppendingPathComponent:@"Cache"]];
    
    if (cacheDictionary==nil) {
        cacheDictionary=[[NSMutableDictionary alloc]init];
    }
    
    if (![key isEqualToString:@""]&&value) {
        [cacheDictionary setObject:value forKey:key];
        [cacheDictionary writeToFile:[[CommonFunction getCacheFolderPath] stringByAppendingPathComponent:@"Cache"] atomically:YES];
    }
    else{
        NSLog(@"error！");
    }
}
+ (id)getCacheValueForKey:(NSString *)key{
    NSMutableDictionary *cacheDictionary=[[NSMutableDictionary alloc]initWithContentsOfFile:[[CommonFunction getCacheFolderPath] stringByAppendingPathComponent:@"Cache"] ];
    if (cacheDictionary==nil) {
        return nil;
    }
    return [cacheDictionary objectForKey:key];
}
+ (NSString *)getDocumentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
+ (NSString *)getCacheFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+(BOOL) delFileWithPath:(NSString*) filePath{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]==NO) {
        return NO;
    }
    BOOL canWrite =[[NSFileManager defaultManager]isWritableFileAtPath: filePath];
    if (! canWrite) {
        // show a UIAlert saying path isn't writable
        //END:code.FilesystemExplorer.handledeleteswipe
        NSLog(@"Cannot delete");
        return NO;
    }
    // try to delete
    //START:code.FilesystemExplorer.deletefile
    NSError *err = nil;
    if (! [[NSFileManager defaultManager] removeItemAtPath: filePath error:&err]) {
        // show a UIAlert saying cannot delete
        //END:code.FilesystemExplorer.deletefile
        NSString *alertMessage = (err == noErr) ?
        [NSString stringWithFormat: @"Cannot delete %@", filePath] :
        [NSString stringWithFormat: @"Cannot delete %@, %@",filePath, [err localizedDescription]];
        NSLog(@"%@",alertMessage);
        return NO;
    }
    return YES;
}
+(void)logNetErrorOfPage:(NSString *)page Function:(NSString *)function ErrorCode:(NSInteger)code Description:(NSString *)description{
    NSString *value=[CommonFunction getPersistentValueForKey:kAppLogError];
    if (value&&[value intValue]==1) {
        NSString *fileName = [[CommonFunction getDocumentFolderPath]  stringByAppendingPathComponent:@"netlog.txt"];
        NSLog(@"page =%@ function=%@ code=%ld description=%@",page,function,(long)code,description);
        if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
        }
        NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:[[CommonFunction getDocumentFolderPath]  stringByAppendingPathComponent:@"netlog.txt"]];
        [file seekToEndOfFile];
//        [file writeData:[[NSString stringWithFormat:@"\n %@ page=%@  function:%@-code=%ld--Description=%@",page,[CommonFunction getLocalDate],function,(long)code,description] dataUsingEncoding:NSUTF8StringEncoding]];
//        [file closeFile];
        
    }
    
    
}
//TODO::正式发布App Store 去掉 记录文件
+(void)logHtmlErrorOfHtmlFile:(NSString *)htmlFile ErrorCode:(NSString *)code Description:(NSString *)description{
    NSString *value=[CommonFunction getPersistentValueForKey:kAppLogError];
    if (value&&[value intValue]==1) {
        NSString *fileName = [[CommonFunction getDocumentFolderPath] stringByAppendingPathComponent:@"htmllog.txt"];
        NSLog(@"htmlFile=%@ code=%@ description=%@",htmlFile,code,description);
        if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
        }
        NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:[[CommonFunction getDocumentFolderPath] stringByAppendingPathComponent:@"htmllog.txt"]];
        [file seekToEndOfFile];
//        [file writeData:[[NSString stringWithFormat:@"\n %@ htmlFile:%@-code=%@--Description=%@",[CommonFunction getLocalDate],htmlFile,code,description] dataUsingEncoding:NSUTF8StringEncoding]];
//        [file closeFile];
    }
}
// 提示消息框(参数为弹出内容)
+(void)showMessge:(NSString*)msg
{
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
 

@end
