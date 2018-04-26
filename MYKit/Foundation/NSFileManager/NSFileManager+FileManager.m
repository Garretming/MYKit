//
//  NSFileManager+FileManager.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSFileManager+FileManager.h"
#import "NSFileManager+Paths.h"
#import "NSString+YYAdd.h"

@implementation NSFileManager (FileManager)

#pragma mark - 获取Cache Path
+ (NSString *)checkCachePathWithCacheName:(NSString *)cacheName {
    
    NSString *cachePath = [[[NSFileManager cachesURL] absoluteString] stringByAppendingPathComponent:cacheName];
    
    if (![[self defaultManager] fileExistsAtPath:cachePath]) {
        [[self defaultManager] createDirectoryAtPath:cachePath
                         withIntermediateDirectories:YES
                                          attributes:nil
                                               error:nil];
    }
    
    return cachePath;
}

#pragma mark - 保存数据到Cache
+ (BOOL)saveDataCacheWithData:(NSData *)data
                   identifier:(NSString *)identifier {
    
    return [self saveDataCacheWithData:data
                             cacheName:@"MYDataCache"
                            identifier:identifier];
}

+ (BOOL)saveDataCacheWithData:(NSData *)data
                    cacheName:(NSString *)cacheName
                   identifier:(NSString *)identifier {
    
    NSString *cachePath = [self checkCachePathWithCacheName:cacheName];
    
    NSString *path = [cachePath stringByAppendingPathComponent:identifier.md5String];
    return [data writeToFile:path
                  atomically:YES];
}

#pragma mark - 获取Cache的数据
+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier {
    
    return [self getDataCacheWithCacheName:@"MYDataCache"
                                identifier:identifier];
}

+ (NSData *)getDataCacheWithCacheName:(NSString *)cacheName
                           identifier:(NSString *)identifier {
    
    NSString *cachePath     = [self checkCachePathWithCacheName:cacheName];
    NSString *identifierMD5 = identifier.md5String;
    NSString *dataPath      = [cachePath stringByAppendingPathComponent:identifierMD5];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    [self appendFilePath:cacheName];
    
    return data;
}

#pragma mark - 删除Cache里的数据
+ (BOOL)removeDataWithCache {
    
    return [self removeDataWithCacheWithCacheName:@"MYDataCache"];
}

+ (BOOL)removeDataWithCacheWithCacheName:(NSString *)cacheName {
    
    NSString *cachePath = [self checkCachePathWithCacheName:cacheName];
    
    return [[self defaultManager] removeItemAtPath:cachePath
                                             error:nil];
}

#pragma mark - Document
+ (NSString *)appendFilePath:(NSString *)fileName {
    
    NSString *documentsPath = [NSFileManager documentsURL].absoluteString;
    return [NSString stringWithFormat:@"%@/%@.archiver", documentsPath,fileName];;
}

+ (BOOL)saveDocumentWithObject:(id)object
                      fileName:(NSString *)fileName {
    
    NSString *documentsPath = [self appendFilePath:fileName];
    
    return [NSKeyedArchiver archiveRootObject:object
                                       toFile:documentsPath];
}

+ (id)getDocumentObjectWithFileName:(NSString *)fileName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self appendFilePath:fileName]];
}

+ (BOOL)removeDocumentObjectWithFileName:(NSString *)fileName {
    return [[self defaultManager] removeItemAtPath:[self appendFilePath:fileName]
                                             error:nil];
}

+ (BOOL)checkFileExistWithFilePath:(NSString *)filePath {
    
    BOOL isDirectory;
    
    return [[self defaultManager] fileExistsAtPath:filePath
                                       isDirectory:&isDirectory];
}


@end
