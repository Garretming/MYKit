//
//  NSObject+Swizzle.h
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

/*
 * To swizzle two selector for self class.
 * @param srcSel source selector
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(SEL)srcSel tarSel:(SEL)tarSel;

/*
 * To swizzle two selector from self class to target class.
 * @param srcSel source selector
 * @param tarClassName target class name string
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel;

/*
 * To swizzle two selector from self class to target class.
 * @param srcClass source class
 * @param srcSel source selector
 * @param tarClass target class
 * @param tarSel target selector
 */
+(void)safe_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;

@end
