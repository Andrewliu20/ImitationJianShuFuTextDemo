//
//  LNNotification.h
//  LNNotificationsUI
//
//  Created by Leo Natan on 9/4/14.
//  Copyright (c) 2014 Leo Natan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LNNotification : NSObject <NSCopying, NSSecureCoding>

+ (instancetype)notificationWithMessage:(NSString*)message;
+ (instancetype)notificationWithTitle:(NSString*)title message:(NSString*)message;
+ (instancetype)notificationWithTitle:(NSString*)title message:(NSString*)message icon:(UIImage*)icon date:(NSDate*)date;

- (instancetype)initWithMessage:(NSString*)message;
- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message;
- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message icon:(UIImage*)icon date:(NSDate*)date NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* message;
@property (nonatomic, strong) UIImage* icon;
@property (nonatomic, copy) NSDate* date;
@property (nonatomic) BOOL displaysWithRelativeDateFormatting;

@property (nonatomic, copy) NSString* alertAction NS_UNAVAILABLE;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
