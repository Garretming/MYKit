//
//  MYKit.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MYKit_h
#define MYKit_h

#if __has_include(<MYKit/MYKit.h>)

#import <MYKit/UINavigationBar+Translation.h>

#import <MYKit/UIViewController+PageViewLevel.h>
#import <MYKit/UIViewController+PreviousController.h>
#import <MYKit/UIViewController+TopViewController.h>

#import <MYKit/UIScreen+Accessor.h>

#import <MYKit/UIActionSheet+Block.h>
#import <MYKit/UIActionSheet+Addition.h>

#import <MYKit/UIDevice+Extension.h>

#import <MYKit/UIApplication+NetworkActivityIndicator.h>
#import <MYKit/UIApplication+Extension.h>
#import <MYKit/UIApplication+Authority.h>

#import <MYKit/UIBarButtonItem+Badge.h>
#import <MYKit/UIBarButtonItem+Extension.h>

#import <MYKit/UINavigationController+StackManager.h>
#import <MYKit/UINavigationController+Transitions.h>

#import <MYKit/UIScrollView+Extension.h>
#import <MYKit/UIScrollView+Accessor.h>

#import <MYKit/UITableView+Extension.h>

#import <MYKit/UITextField+Select.h>
#import <MYKit/UITextField+Shake.h>
#import <MYKit/UITextField+InputLimit.h>

#import <MYKit/UITextView+InputLimit.h>
#import <MYKit/UITextView+PlaceHolder.h>
#import <MYKit/UITextView+InputLengthCalculate.h>
#import <MYKit/UITextView+Select.h>

#import <MYKit/UIWebView+Block.h>
#import <MYKit/UIWebView+Load.h>

#import <MYKit/UIWindow+Hierarchy.h>

#import <MYKit/UILabel+CountDown.h>
#import <MYKit/UILabel+FitLines.h>
#import <MYKit/UILabel+AutomaticWriting.h>

#import <MYKit/UIButton+CountDown.h>
#import <MYKit/UIButton+Badge.h>
#import <MYKit/UIButton+ImagePosition.h>
#import <MYKit/UIButton+Indicator.h>
#import <MYKit/UIButton+Submitting.h>
#import <MYKit/UIButton+TouchAreaInsets.h>
#import <MYKit/UIButton+ImageTitleStyle.h>

#import <MYKit/UIResponder+Router.h>
#import <MYKit/UIResponder+Chain.h>

#import <MYKit/UINavigationItem+Loading.h>
#import <MYKit/UINavigationItem+Margin.h>
#import <MYKit/UINavigationItem+Target.h>
#import <MYKit/UINavigationItem+Addition.h>

#import <MYKit/UIColor+Random.h>
#import <MYKit/UIColor+Hex.h>
#import <MYKit/UIColor+Gradient.h>

#import <MYKit/UIImage+Extension.h>
#import <MYKit/UIImage+Color.h>
#import <MYKit/UIImage+Screenshot.h>
#import <MYKit/UIImage+CornerRadius.h>
#import <MYKit/UIImage+ImageEffects.h>
#import <MYKit/UIImage+RoundedAvatar.h>

#import <MYKit/UIView+CornerRadii.h>
#import <MYKit/UIView+RedDot.h>
#import <MYKit/UIView+Badge.h>
#import <MYKit/UIView+Position.h>
#import <MYKit/UIView+Gesture.h>
#import <MYKit/UIView+SuperController.h>
#import <MYKit/UIView+Screenshot.h>
#import <MYKit/UIView+Visuals.h>
#import <MYKit/UIView+CustomBorder.h>
#import <MYKit/UIView+Line.h>
#import <MYKit/UIView+FindSubView.h>
#import <MYKit/UIView+GradientBackgroundColor.h>

#import <MYKit/UIAlertView+Block.h>
#import <MYKit/UIAlertView+Addition.h>

#import <MYKit/UIImageView+Fillet.h>
#import <MYKit/UIImageView+CornerRadius.h>
#import <MYKit/UIImageView+RoundedAvatar.h>
#import <MYKit/UIImageView+Reflect.h>
#import <MYKit/UIImageView+FaceAwareFill.h>
#import <MYKit/UIImageView+Letters.h>
#import <MYKit/UIImageView+BetterFace.h>

#import <MYKit/NSArray+SafeAccess.h>
#import <MYKit/NSArray+Extension.h>
#import <MYKit/NSArray+Collection.h>
#import <MYKit/NSArray+Safe.h>

#import <MYKit/NSMutableArray+SafeAccess.h>
#import <MYKit/NSMutableArray+Sort.h>
#import <MYKit/NSMutableArray+Stack.h>
#import <MYKit/NSMutableArray+Queue.h>
#import <MYKit/NSMutableArray+Extension.h>

#import <MYKit/NSString+Contains.h>
#import <MYKit/NSString+Emoji.h>
#import <MYKit/NSString+Trims.h>
#import <MYKit/NSString+UUID.h>
#import <MYKit/NSString+XML.h>
#import <MYKit/NSString+Size.h>
#import <MYKit/NSString+Collection.h>
#import <MYKit/NSString+Attributed.h>
#import <MYKit/NSString+Regular.h>
#import <MYKit/NSString+Extension.h>
#import <MYKit/NSString+FitLines.h>

#import <MYKit/NSAttributedString+Extension.h>

#import <MYKit/NSMutableAttributedString+ChainProgramming.h>
#import <MYKit/NSMutableAttributedString+Extension.h>

#import <MYKit/NSCharacterSet+Addition.h>

#import <MYKit/NSData+Addition.h>
#import <MYKit/NSData+Base64.h>
#import <MYKit/NSData+DataCache.h>
#import <MYKit/NSData+Hash.h>
#import <MYKit/NSData+Encrypt.h>
#import <MYKit/NSData+Encode.h>
#import <MYKit/NSData+ImageContentType.h>
#import <MYKit/NSData+AES256.h>

#import <MYKit/NSNull+NSNullSafe.h>

#import <MYKit/NSDictionary+SafeAccess.h>
#import <MYKit/NSDictionary+JSONString.h>
#import <MYKit/NSDictionary+Plist.h>
#import <MYKit/NSDictionary+Key.h>
#import <MYKit/NSDictionary+NilSafe.h>
#import <MYKit/NSDictionary+Collection.h>
#import <MYKit/NSDictionary+StringAscending.h>

#import <MYKit/NSMutableDictionary+ChainProgramming.h>
#import <MYKit/NSMutableDictionary+NilSafe.h>

#import <MYKit/NSNumber+Round.h>
#import <MYKit/NSNumber+Addition.h>

#import <MYKit/NSObject+AssociatedObject.h>
#import <MYKit/NSObject+Swizzling.h>
#import <MYKit/NSObject+KVO.h>
#import <MYKit/NSObject+Dictionary.h>

#import <MYKit/NSTimer+Addition.h>

#import <MYKit/NSURL+Param.h>
#import <MYKit/NSURL+URLQuery.h>

#import <MYKit/NSUserDefaults+SafeAccess.h>

#import <MYKit/NSFileManager+Paths.h>
#import <MYKit/NSFileManager+FileManager.h>

#import <MYKit/NSFileHandle+ReadLine.h>

#import <MYKit/NSDateFormatter+Extension.h>

#import <MYKit/NSBundle+AppIcon.h>

#import <MYKit/NSDate+YYAdd.h>
#import <MYKit/NSDate+NSDateRFC1123.h>
#import <MYKit/NSDate+Addition.h>
#import <MYKit/NSDate+YYAdd.h>
#import <MYKit/NSDate+Extension.h>

#else

#import "NSArray+SafeAccess.h"
#import "NSArray+Extension.h"
#import "NSArray+Collection.h"
#import "NSArray+Safe.h"

#import "NSMutableArray+SafeAccess.h"
#import "NSMutableArray+Stack.h"
#import "NSMutableArray+Sort.h"
#import "NSMutableArray+Queue.h"
#import "NSMutableArray+Extension.h"

#import "NSString+Contains.h"
#import "NSString+Emoji.h"
#import "NSString+Trims.h"
#import "NSString+UUID.h"
#import "NSString+XML.h"
#import "NSString+Size.h"
#import "NSString+Collection.h"
#import "NSString+Attributed.h"
#import "NSString+Regular.h"
#import "NSString+Extension.h"
#import "NSString+FitLines.h"

#import "NSAttributedString+Extension.h"

#import "NSMutableAttributedString+ChainProgramming.h"
#import "NSMutableAttributedString+Extension.h"

#import "NSCharacterSet+Addition.h"

#import "NSData+Encode.h"
#import "NSData+Encrypt.h"
#import "NSData+Hash.h"
#import "NSData+DataCache.h"
#import "NSData+Base64.h"
#import "NSData+Addition.h"
#import "NSData+ImageContentType.h"
#import "NSData+AES256.h"

#import "NSNull+NSNullSafe.h"

#import "NSDictionary+Key.h"
#import "NSDictionary+Plist.h"
#import "NSDictionary+NilSafe.h"
#import "NSDictionary+JSONString.h"
#import "NSDictionary+SafeAccess.h"
#import "NSDictionary+Collection.h"
#import "NSDictionary+StringAscending.h"

#import "NSMutableDictionary+ChainProgramming.h"
#import "NSMutableDictionary+NilSafe.h"

#import "NSNumber+Round.h"
#import "NSNumber+Addition.h"

#import "NSObject+Swizzling.h"
#import "NSObject+AssociatedObject.h"
#import "NSObject+KVO.h"
#import "NSObject+Dictionary.h"

#import "NSTimer+Addition.h"

#import "NSURL+URLQuery.h"
#import "NSURL+Param.h"

#import "NSUserDefaults+SafeAccess.h"

#import "NSFileManager+Paths.h"
#import "NSFileManager+FileManager.h"

#import "NSFileHandle+ReadLine.h"

#import "NSDateFormatter+Extension.h"

#import "NSDate+YYAdd.h"
#import "NSDate+NSDateRFC1123.h"
#import "NSDate+Addition.h"
#import "NSDate+Extension.h"

#import "NSBundle+AppIcon.h"

#import "UINavigationBar+Translation.h"

#import "UIViewController+PageViewLevel.h"
#import "UIViewController+PreviousController.h"
#import "UIViewController+TopViewController.h"

#import "UIScreen+Accessor.h"

#import "UIActionSheet+Block.h"
#import "UIActionSheet+Addition.h"

#import "UIDevice+Extension.h"

#import "UIApplication+NetworkActivityIndicator.h"
#import "UIApplication+Extension.h"
#import "UIApplication+Authority.h"

#import "UIBarButtonItem+Badge.h"
#import "UIBarButtonItem+Extension.h"

#import "UINavigationController+StackManager.h"
#import "UINavigationController+Transitions.h"

#import "UIScrollView+Extension.h"
#import "UIScrollView+Accessor.h"

#import "UITableView+Extension.h"

#import "UITextField+Select.h"
#import "UITextField+Shake.h"
#import "UITextField+InputLimit.h"

#import "UITextView+InputLimit.h"
#import "UITextView+PlaceHolder.h"
#import "UITextView+InputLengthCalculate.h"
#import "UITextView+Select.h"

#import "UIWebView+Block.h"
#import "UIWebView+Load.h"

#import "UIWindow+Hierarchy.h"

#import "UILabel+CountDown.h"
#import "UILabel+FitLines.h"
#import "UILabel+AutomaticWriting.h"

#import "UIButton+CountDown.h"
#import "UIButton+Badge.h"
#import "UIButton+ImagePosition.h"
#import "UIButton+Indicator.h"
#import "UIButton+Submitting.h"
#import "UIButton+TouchAreaInsets.h"
#import "UIButton+ImageTitleStyle.h"

#import "UIResponder+Router.h"
#import "UIResponder+Chain.h"

#import "UINavigationItem+Loading.h"
#import "UINavigationItem+Margin.h"
#import "UINavigationItem+Target.h"
#import "UINavigationItem+Addition.h"

#import "UIColor+Random.h"
#import "UIColor+Hex.h"
#import "UIColor+Gradient.h"

#import "UIImage+Extension.h"
#import "UIImage+Color.h"
#import "UIImage+Screenshot.h"
#import "UIImage+CornerRadius.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+RoundedAvatar.h"

#import "UIView+CornerRadii.h"
#import "UIView+RedDot.h"
#import "UIView+Position.h"
#import "UIView+Gesture.h"
#import "UIView+SuperController.h"
#import "UIView+Screenshot.h"
#import "UIView+Visuals.h"
#import "UIView+CustomBorder.h"
#import "UIView+Badge.h"
#import "UIView+Line.h"
#import "UIView+FindSubView.h"
#import "UIView+GradientBackgroundColor.h"

#import "UIImageView+BetterFace.h"
#import "UIImageView+Letters.h"
#import "UIImageView+FaceAwareFill.h"
#import "UIImageView+Reflect.h"
#import "UIImageView+CornerRadius.h"
#import "UIImageView+RoundedAvatar.h"
#import "UIImageView+Addition.h"
#import "UIImageView+Fillet.h"

#import "UIAlertView+Block.h"
#import "UIAlertView+Addition.h"

#endif 

#endif /* MYKit_h */
