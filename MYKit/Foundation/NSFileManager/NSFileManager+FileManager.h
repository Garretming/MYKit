//
//  NSFileManager+FileManager.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (FileManager)

#pragma mark - Cache相关
/**
 存储NSData到CLDataCache文件夹
 
 @param data NSData
 @param identifier NSString
 @return BOOL
 */
+ (BOOL)saveDataCacheWithData:(NSData *)data
                      identifier:(NSString *)identifier;

/**
 存储NSData到指定Cache文件夹
 
 @param data NSData
 @param cacheName NSString
 @param identifier NSString
 @return BOOL
 */
+ (BOOL)saveDataCacheWithData:(NSData *)data
                       cacheName:(NSString *)cacheName
                      identifier:(NSString *)identifier;

/**
 获取CLDataCache里的NSData
 
 @param identifier NSString
 @return NSData
 */
+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

/**
 获取指定Cache文件夹里的NSData
 
 @param cacheName NSString
 @param identifier NSString
 @return NSData
 */
+ (NSData *)getDataCacheWithCacheName:(NSString *)cacheName
                              identifier:(NSString *)identifier;

/**
 删除CLDataCache里的数据
 */
+ (BOOL)removeDataWithCache;

/**
 删除指定Cache文件夹里的数据
 
 @param cacheName NSString
 */
+ (BOOL)removeDataWithCacheWithCacheName:(NSString *)cacheName;

#pragma mark - Document
/**
 存储指定fileName文件到Document
 
 @param object id
 @param fileName NSString
 @return BOOL
 */
+ (BOOL)saveDocumentWithObject:(id)object
                         fileName:(NSString *)fileName;

/**
 删除Document里指定的fileName文件
 
 @param fileName NSString
 @return BOOL
 */
+ (BOOL)removeDocumentObjectWithFileName:(NSString *)fileName;

/**
 获取Document里指定的fileName文件
 
 @param fileName NSString
 @return id
 */
+ (id)getDocumentObjectWithFileName:(NSString *)fileName;

/**
 检查路径里的文件是否存在
 
 @param filePath NSString
 @return BOOL
 */
+ (BOOL)checkFileExistWithFilePath:(NSString *)filePath;

@end
