//
//  ViewController.h
//  cocoapodsdemo
//
//  Created by andrewliu on 16/7/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "WPEditorViewController.h"
#import "AFNetworking.h"
#import "publishedArticleViewModel.h"
#import "WPEditorConfiguration.h"

@interface ViewController : WPEditorViewController <WPEditorViewControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,retain)publishedArticleViewModel *viewModel;

@end

