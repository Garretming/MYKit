//
//  UIView+FunctionExtension.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "UIView+Style.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "MessageTrash.h"

#pragma - mark
#pragma - mark StyleFormat

@implementation UIView (StyleFormat)

- (void)setShareStyle:(void (^)(id))shareStyle {
    if (shareStyle != nil) {
        shareStyle(self);
    }
    objc_setAssociatedObject(self, @selector(shareStyle), shareStyle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))shareStyle {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)shareStyle:(void(^)(id sourceView))share uniqueStyle:(void(^)(id sourceView))unique {
    self.shareStyle  = share;
    if (unique) {
        unique(self);
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [MessageTrash new];
}

@end






