//
//  UIView+CornerRadii.m
//  LPDCrowdsource
//
//  Created by eMr.Wang on 16/1/29.
//  Copyright © 2016年 elm. All rights reserved.
//

#import "UIView+CornerRadii.h"

@implementation UIView (CornerRadii)

// 指定倒角
- (void)setCornerRadii:(CGFloat)cornerRadii roundingCorners:(UIRectCorner)roundingCorners {
  if (self.layer.mask) {
    self.layer.mask = nil;
  }
  self.layer.masksToBounds = YES;
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:roundingCorners
                                                       cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  maskLayer.frame = self.bounds;
  maskLayer.path = maskPath.CGPath;
  self.layer.mask = maskLayer;
}

- (void)setViewRectCornerType:(MYRectCornerType)type
             viewCornerRadius:(CGFloat)viewCornerRadius {
    [self setViewRectCornerType:type viewCornerRadius:viewCornerRadius borderWidth:0 borderColor:[UIColor whiteColor]];
}

- (void)setViewRectCornerType:(MYRectCornerType)type
             viewCornerRadius:(CGFloat)viewCornerRadius
                  borderWidth:(CGFloat)borderWidth
                  borderColor:(UIColor *)borderColor {
    UIRectCorner corners;
    CGSize cornerRadii = CGSizeMake(viewCornerRadius, viewCornerRadius);
    if (viewCornerRadius == 0) {
        cornerRadii = CGSizeMake(0, 0);
    }
    
    switch (type) {
        case MYRectCornerTypeBottomLeft: {
            corners = UIRectCornerBottomLeft;
        }
            break;
        case MYRectCornerTypeBottomRight: {
            corners = UIRectCornerBottomRight;
        }
            break;
        case MYRectCornerTypeTopLeft: {
            corners = UIRectCornerTopLeft;
        }
            break;
        case MYRectCornerTypeTopRight: {
            corners = UIRectCornerTopRight;
        }
            break;
        case MYRectCornerTypeBottomLeftAndBottomRight: {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        case MYRectCornerTypeTopLeftAndTopRight: {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
        case MYRectCornerTypeBottomLeftAndTopLeft: {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
        case MYRectCornerTypeBottomRightAndTopRight: {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
        case MYRectCornerTypeBottomRightAndTopRightAndTopLeft: {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
        case MYRectCornerTypeBottomRightAndTopRightAndBottomLeft: {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
        case MYRectCornerTypeAllCorners: {
            corners = UIRectCornerAllCorners;
        }
            break;
            
        default:
            break;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:cornerRadii];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = self.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.lineWidth = borderWidth;
    borderLayer.frame = self.bounds;
    
    self.layer.mask = shapeLayer;
    [self.layer addSublayer:borderLayer];
}

@end
