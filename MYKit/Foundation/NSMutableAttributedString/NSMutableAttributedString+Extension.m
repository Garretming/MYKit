//
//  NSMutableAttributedString+Extension.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+ (NSMutableAttributedString *)attributeStringWithSubffixString:(NSString *)subffixString
                                                   subffixImage:(UIImage *)subffixImage {
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
    
    backAttachment.image = subffixImage;
    backAttachment.bounds = CGRectMake(0, -2, subffixImage.size.width, subffixImage.size.height);
    
    NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:subffixString];
    
    [mutableAttributedString appendAttributedString:backString];
    [mutableAttributedString appendAttributedString:attributedString];
    
    return mutableAttributedString;
}

+ (NSMutableAttributedString *)attributeStringWithSubffixString:(NSString *)subffixString
                                                  subffixImages:(NSArray<UIImage *> *)subffixImages {
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    [subffixImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
        
        backAttachment.image = obj;
        backAttachment.bounds = CGRectMake(0, -2, obj.size.width, obj.size.height);
        
        NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
        
        [mutableAttributedString appendAttributedString:backString];
    }];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:subffixString];
    
    [mutableAttributedString appendAttributedString:attributedString];
    
    return mutableAttributedString;
}

+ (NSMutableAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                                   prefixImage:(UIImage *)prefixImage {
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:prefixString];
    
    NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
    
    backAttachment.image = prefixImage;
    backAttachment.bounds = CGRectMake(0, -2, prefixImage.size.width, prefixImage.size.height);
    
    NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
    
    [mutableAttributedString appendAttributedString:backString];
    
    return mutableAttributedString;
}

+ (NSMutableAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                                  prefixImages:(NSArray<UIImage *> *)prefixImages {
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:prefixString];
    
    [prefixImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSTextAttachment *backAttachment = [[NSTextAttachment alloc] init];
        
        backAttachment.image = obj;
        backAttachment.bounds = CGRectMake(0, -2, obj.size.width, obj.size.height);
        
        NSAttributedString *backString = [NSAttributedString attributedStringWithAttachment:backAttachment];
        
        [mutableAttributedString appendAttributedString:backString];
    }];
    
    return mutableAttributedString;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
                                              lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [string length])];
    
    return attributedString;
}

+ (NSMutableAttributedString *)attributedStringWithAttributedString:(NSAttributedString *)attributedString
                                                        lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [mutableAttributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [attributedString length])];
    
    return mutableAttributedString;
}

@end
