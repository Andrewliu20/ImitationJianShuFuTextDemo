//
//  ViewController.m
//  cocoapodsdemo
//
//  Created by andrewliu on 16/7/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "ViewController.h"


@import Photos;
@import AVFoundation;
@import MobileCoreServices;
#import "WPEditorField.h"
#import "WPEditorView.h"
#import "WPImageMetaViewController.h"
#import "imageSelectController.h"
#import "LNNotificationsUI.h"


#define BASEURL  @"http://api.ougohome.com/index.php/"
@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, WPImageMetaViewControllerDelegate>

@property(nonatomic, strong) NSMutableDictionary *mediaAdded;
@property(nonatomic, strong) NSString *selectedMediaID;
@property(nonatomic, strong) NSCache *videoPressCache;
@property(retain,nonatomic)UIPopoverController *popoverController;
//@property(retain,nonatomic)NSTimer * saveTimer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//     [self hideTitle];
    
    WPEditorConfiguration *_WPEditorConfiguration = [WPEditorConfiguration sharedWPEditorConfiguration];
    
    // kLMDefaultLanguage  @"en-US"
    // kLMChinese          @"zh-Hans"
    // kLMChineseTW         @"zh-TW"
    // kLMChineseHK         @"zh-HK"
    // kLMChineseT         @"zh-Hant"
    
    _WPEditorConfiguration.localizable = kLMChinese;
    
    _WPEditorConfiguration.enableImageSelect =   ZSSRichTextEditorImageSelectPhotoLibrary |ZSSRichTextEditorImageSelectTakePhoto|ZSSRichTextEditorImageSelectInsertNetwork;
    
    
    self.delegate = self;
    
//    sel
    
//    self.itemTintColor = [UIColor redColor];
    
    [self initView];
    
    [[LNNotificationCenter defaultCenter] registerApplicationWithIdentifier:@"com.ougohome.softDecorationMaster" name:@"Roc.Tian" icon:nil];
    
    self.mediaAdded = [NSMutableDictionary dictionary];
    self.videoPressCache = [[NSCache alloc] init];
    
    //添加通知标志是否有标题
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showEditorTitleNoti" object:nil];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideEditorTitleNoti" object:nil];
    
    _viewModel = [publishedArticleViewModel new];
    _viewModel.article_id = [[NSUUID UUID] UUIDString];
    _viewModel.userId = [[NSUUID UUID] UUIDString];
    _viewModel.createTime = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    
    self.itemTintColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    
//    self.toolbarView.backgroundColor = [UIColor grayColor];
    
}
-(void)initView{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 2.0, 44.0, 44.0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(13,0, 13, 34)];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"发表"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(publishedAction:)];
    
    
    self.title =  @"发表文章";
    
    
    self.bodyPlaceholderText = @"写点什么吧";
     self.titlePlaceholderText = @"标题";
    
   
  
//    self.titleText = @"test";
    
//    self.titleText  = @"test";
//    
//    NSString *str = @"<h1>bodyText</h1><p id = 'id'></p><img src='http://www.pptbz.com/pptpic/UploadFiles_6909/201204/2012041411433867.jpg'></img>";
//    
//    self.bodyText = @"www.baidu.com";
    
//    [self addTitle: self.titleText];

    
    
    
//    [self.editorView addTitle:@"test"];
    
//    self.titlePlaceholderText = NSLocalizedString(@"pleaseInputTitle",@"请输入标题");
    
    
   
    
}
-(void)backAction:(UIButton *)back{
    
    [self.view endEditing:YES];
    

    
    if(_viewModel.content.length>0){
        
        //        _alartViewController = [[AlartViewController alloc] initTitle:NSLocalizedString(@"sureToSaveDraft", @"是否保留草稿?") positiveButton:NSLocalizedString(@"sure", @"确认") negativeButton:NSLocalizedString(@"cancel", @"取消") showCloseButton:NO];
        //        _alartViewController.expendAbleAlartViewDelegate = self;
        //        _alartViewController.view.tag = 1;
        //        [_alartViewController showView:^(BOOL finished){}];
        return;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:^(){
        
        [self setNil];
        
    }];
    
}

-(void)publishedMethod{
    
    
}
- (IBAction)publishedAction:(id)sender {
    
    [self.view endEditing:YES];
    
    NSLog(@"%@",_viewModel.content);
    
    if(_viewModel.title.length == 0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入标题" message:@"请输入标题" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        return;
    }
    
    
    
    if(_viewModel.content.length==0){
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入内容" message:@"请输入内容" delegate:nil cancelButtonTitle: @"确认" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        
        
        
        return;
        
    }
    else{
        
//        _viewModel.cover_image_url = [self.editorView getCoverImage];
//        NSArray *allImage = [self.editorView getAllImage];
//        
//        NSLog(@"Image Count:%ld",allImage.count);
        
    }
    
}

#pragma mark - Navigation Bar

- (void)editTouchedUpInside
{
    if (self.isEditing) {
        [self stopEditing];
    } else {
        [self startEditing];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.editorView saveSelection];
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - IBActions

- (IBAction)exit:(UIStoryboardSegue*)segue
{
}

#pragma mark - WPEditorViewControllerDelegate

- (void)editorDidBeginEditing:(WPEditorViewController *)editorController
{
    NSLog(@"Editor did begin editing.");
}

- (void)editorDidEndEditing:(WPEditorViewController *)editorController
{
    NSLog(@"Editor did end editing.");
}

- (void)editorDidFinishLoadingDOM:(WPEditorViewController *)editorController
{
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
    //    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //      [self setTitleText:@""];
    //    [self setBodyText:htmlParam];
    
    [self startEditing];
}

- (BOOL)editorShouldDisplaySourceView:(WPEditorViewController *)editorController
{
    [self.editorView pauseAllVideos];
    return YES;
}

- (void)editorDidPressMedia:(int)type
{
    NSLog(@"Pressed Media!");
    
    [self selectImageType:type];
    
}

- (void)editorTitleDidChange:(WPEditorViewController *)editorController
{
    NSLog(@"Editor title did change: %@", self.titleText);
    
    
    
    
    _viewModel.title = self.titleText;
    
//    [self initSaveTimer];
}

- (void)editorTextDidChange:(WPEditorViewController *)editorController
{
    NSLog(@"Editor body text changed: %@", self.bodyText);
    
    _viewModel.content =  self.bodyText;
    
    
    NSDictionary *dict = @{@"contentLength":_viewModel.content};
    
    if (_viewModel.content.length==0) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"getContentLengthNoti" object:nil userInfo:dict ];
    }

   
    
//    [self initSaveTimer];
}
//-(void)initSaveTimer{
//    
//    if(!_saveTimer)
//        _saveTimer = [NSTimer scheduledTimerWithTimeInterval:30
//                                                      target:self
//                                                    selector:@selector(autoSaveArticle:)
//                                                    userInfo:nil
//                                                     repeats:YES];
//    
//}
- (void)editorViewController:(WPEditorViewController *)editorViewController fieldCreated:(WPEditorField*)field
{
    NSLog(@"Editor field created: %@", field.nodeId);
}

- (void)editorViewController:(WPEditorViewController*)editorViewController
                 imageTapped:(NSString *)imageId
                         url:(NSURL *)url
                   imageMeta:(WPImageMeta *)imageMeta
{
    if (imageId.length == 0) {
        
        [self showImageDetailsForImageMeta:imageMeta];
    } else {
//        [self showPromptForImageWithID:imageId];
    }
}

- (void)editorViewController:(WPEditorViewController*)editorViewController
                 videoTapped:(NSString *)videoId
                         url:(NSURL *)url
{
    [self showPromptForVideoWithID:videoId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController imageReplaced:(NSString *)imageId
{
    [self.mediaAdded removeObjectForKey:imageId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController videoReplaced:(NSString *)videoId
{
    [self.mediaAdded removeObjectForKey:videoId];
}

- (void)editorViewController:(WPEditorViewController *)editorViewController videoPressInfoRequest:(NSString *)videoID
{
    NSDictionary * videoPressInfo = [self.videoPressCache objectForKey:videoID];
    NSString * videoURL = videoPressInfo[@"source"];
    NSString * posterURL = videoPressInfo[@"poster"];
    if (videoURL) {
        [self.editorView setVideoPress:videoID source:videoURL poster:posterURL];
    }
}

- (void)editorViewController:(WPEditorViewController *)editorViewController mediaRemoved:(NSString *)mediaID
{
    NSProgress * progress = self.mediaAdded[mediaID];
    [progress cancel];
}

- (void)editorFormatBarStatusChanged:(WPEditorViewController *)editorController
                             enabled:(BOOL)isEnabled
{
    NSLog(@"Editor format bar status is now %@.", (isEnabled ? @"enabled" : @"disabled"));
}

#pragma mark - Media actions

- (void)showImageDetailsForImageMeta:(WPImageMeta *)imageMeta
{
    WPImageMetaViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WPImageMetaViewController"];
    controller.imageMeta = imageMeta;
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}


- (void)showPromptForVideoWithID:(NSString *)videoId
{
    if (videoId.length == 0){
        return;
    }
    __weak __typeof(self)weakSelf = self;
    UITraitCollection *traits = self.navigationController.traitCollection;
    NSProgress *progress = self.mediaAdded[videoId];
    UIAlertController *alertController;
    if (traits.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alertController = [UIAlertController alertControllerWithTitle:nil
                                                              message:nil
                                                       preferredStyle:UIAlertControllerStyleAlert];
    } else {
        alertController = [UIAlertController alertControllerWithTitle:nil
                                                              message:nil
                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){}];
    [alertController addAction:cancelAction];
    
    if (!progress.cancelled){
        UIAlertAction *stopAction = [UIAlertAction actionWithTitle:@"移除"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction *action){
                                                               [weakSelf.editorView removeVideo:weakSelf.selectedMediaID];
                                                           }];
        [alertController addAction:stopAction];
    } else {
        UIAlertAction *removeAction = [UIAlertAction actionWithTitle:@"Remove Video"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction *action){
                                                                 [weakSelf.editorView removeVideo:weakSelf.selectedMediaID];
                                                             }];
        
        UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Retry Upload"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                NSProgress * progress = [[NSProgress alloc] initWithParent:nil userInfo:@{@"videoID":weakSelf.selectedMediaID}];
                                                                progress.totalUnitCount = 100;
                                                                [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                                                 target:self
                                                                                               selector:@selector(timerFireMethod:)
                                                                                               userInfo:progress
                                                                                                repeats:YES];
                                                                weakSelf.mediaAdded[self.selectedMediaID] = progress;
                                                                [weakSelf.editorView unmarkVideoFailedUpload:weakSelf.selectedMediaID];
                                                            }];
        [alertController addAction:removeAction];
        [alertController addAction:retryAction];
    }
    self.selectedMediaID = videoId;
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)showPhotoPicker
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.navigationBar.translucent = NO;
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)addImageAssetToContent:(PHAsset *)asset
{
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = NO;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    NSString *imageID = [[NSUUID UUID] UUIDString];
    NSString *path = [NSString stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(), imageID];
    [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                      options:options
                                                resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                    [imageData writeToFile:path atomically:YES];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.editorView insertLocalImage:[[NSURL fileURLWithPath:path] absoluteString] uniqueId:imageID];
                                                        
//                                                        [self submitImage:imageData imageID:imageID];
                                                    });
                                                }];
    
}

- (void)addVideoAssetToContent:(PHAsset *)originalAsset
{
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = NO;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    NSString *videoID = [[NSUUID UUID] UUIDString];
    NSString *videoPath = [NSString stringWithFormat:@"%@%@.mov", NSTemporaryDirectory(), videoID];
    [[PHImageManager defaultManager] requestImageForAsset:originalAsset
                                               targetSize:[UIScreen mainScreen].bounds.size
                                              contentMode:PHImageContentModeAspectFit
                                                  options:options
                                            resultHandler:^(UIImage *image, NSDictionary * _Nullable info) {
                                                NSData *data = UIImageJPEGRepresentation(image, 0.7);
                                                NSString *posterImagePath = [NSString stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(), [[NSUUID UUID] UUIDString]];
                                                [data writeToFile:posterImagePath atomically:YES];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.editorView insertInProgressVideoWithID:videoID
                                                                                usingPosterImage:[[NSURL fileURLWithPath:posterImagePath] absoluteString]];
                                                });
                                                PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
                                                videoOptions.networkAccessAllowed = YES;
                                                [[PHImageManager defaultManager] requestExportSessionForVideo:originalAsset
                                                                                                      options:videoOptions
                                                                                                 exportPreset:AVAssetExportPresetPassthrough
                                                                                                resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
                                                                                                    exportSession.outputFileType = (__bridge NSString*)kUTTypeQuickTimeMovie;
                                                                                                    exportSession.shouldOptimizeForNetworkUse = YES;
                                                                                                    exportSession.outputURL = [NSURL fileURLWithPath:videoPath];
                                                                                                    [exportSession exportAsynchronouslyWithCompletionHandler:^{
                                                                                                        if (exportSession.status != AVAssetExportSessionStatusCompleted) {
                                                                                                            return;
                                                                                                        }
                                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                            //                                                                    NSProgress *progress = [[NSProgress alloc] initWithParent:nil
                                                                                                            //                                                                                                                     userInfo:@{@"videoID": videoID, @"url": videoPath, @"poster": posterImagePath }];
                                                                                                            //                                                                    progress.cancellable = YES;
                                                                                                            //                                                                    progress.totalUnitCount = 100;
                                                                                                            //                                                                    [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                                                            //                                                                                                     target:self
                                                                                                            //                                                                                                   selector:@selector(timerFireMethod:)
                                                                                                            //                                                                                                   userInfo:progress
                                                                                                            //                                                                                                    repeats:YES];
                                                                                                            //                                                                    self.mediaAdded[videoID] = progress;
                                                                                                        });
                                                                                                    }];
                                                                                                    
                                                                                                }];
                                            }];
}

- (void)addAssetToContent:(NSURL *)assetURL
{
    PHFetchResult *assets = [PHAsset fetchAssetsWithALAssetURLs:@[assetURL] options:nil];
    if (assets.count < 1) {
        return;
    }
    PHAsset *asset = [assets firstObject];
    
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        [self addVideoAssetToContent:asset];
    } if (asset.mediaType == PHAssetMediaTypeImage) {
        [self addImageAssetToContent:asset];
    }
    
    
}



//- (void)timerFireMethod:(NSTimer *)timer
//{
//    NSProgress *progress = (NSProgress *)timer.userInfo;
//    progress.completedUnitCount++;
//    NSString *imageID = progress.userInfo[@"imageID"];
//    if (imageID) {
//        [self.editorView setProgress:progress.fractionCompleted onImage:imageID];
//        // Uncomment this code if you need to test a failed image upload
//        //    if (progress.fractionCompleted >= 0.15){
//        //        [progress cancel];
//        //        [self.editorView markImage:imageID failedUploadWithMessage:@"Failed"];
//        //        [timer invalidate];
//        //    }
//        if (progress.fractionCompleted >= 1) {
//            [self.editorView replaceLocalImageWithRemoteImage:[[NSURL fileURLWithPath:progress.userInfo[@"url"]] absoluteString] uniqueId:imageID];
//            [timer invalidate];
//        }
//        return;
//    }
//
//    NSString *videoID = progress.userInfo[@"videoID"];
//    if (videoID) {
//        [self.editorView setProgress:progress.fractionCompleted onVideo:videoID];
//        // Uncomment this code if you need to test a failed video upload
////        if (progress.fractionCompleted >= 0.15) {
////            [progress cancel];
////            [self.editorView markVideo:videoID failedUploadWithMessage:@"Failed"];
////            [timer invalidate];
////        }
//        if (progress.fractionCompleted >= 1) {
//            NSString * videoURL = [[NSURL fileURLWithPath:progress.userInfo[@"url"]] absoluteString];
//            NSString * posterURL = [[NSURL fileURLWithPath:progress.userInfo[@"poster"]] absoluteString];
//            [self.editorView replaceLocalVideoWithID:videoID
//                                      forRemoteVideo:videoURL
//                                        remotePoster:posterURL
//                                          videoPress:videoID];
//            [self.videoPressCache setObject:@ {@"source":videoURL, @"poster":posterURL} forKey:videoID];
//            [timer invalidate];
//        }
//        return;
//    }
//}

#pragma mark - UIImagePickerControllerDelegate methods

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
//        [self addAssetToContent:assetURL];
//    }];
//
//}

#pragma mark - WPImageMetaViewControllerDelegate

- (void)imageMetaViewController:(WPImageMetaViewController *)controller didFinishEditingImageMeta:(WPImageMeta *)imageMeta
{
    [self.editorView updateCurrentImageMeta:imageMeta];
}


-(void)submitImage:(NSData *)imageData imageID:(NSString *)imageID{
    
    [self submitImageMethod:imageData imageID:imageID];
}
-(void)submitImageMethod:(NSData *)imageData imageID:(NSString *)imageID{
    
    NSData *data = [_viewModel.content dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Text:%@",goodValue);
    
    
    NSDictionary *params = @{@"publishDesc":goodValue,@"mod":@"1",@"act":@"57"};
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[BASEURL stringByAppendingString:@"api/main"] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
        [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic%d",1] fileName:[NSString stringWithFormat:@"publish%d.jpg",1] mimeType:@"image/jpg"];
        
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress;
    
    
    NSURLSessionUploadTask *uploadTask;
    //    uploadTask = [manager
    //                  uploadTaskWithStreamedRequest:request
    //                  progress:&progress
    //                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //
    //                      //                      dispatch_async(dispatch_get_main_queue(), ^{
    //                      //                         [progress removeObserver:self forKeyPath:@"fractionCompleted"];
    //                      //
    //                      //                      });
    //
    //
    //                      if (error) {
    //                          NSLog(@"Error: %@", error);
    //
    //
    //                      } else {
    //                          NSLog(@"%@ %@", response, responseObject);
    //
    //                            [self.editorView replaceLocalImageWithRemoteImage:@"http://pic19.nipic.com/20120310/8061225_093309101000_2.jpg" uniqueId:imageID];
    //
    //                          NSString *path = [NSString stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(), imageID];
    //
    //                          //    NSLog(@"url:%@",path);
    //
    //                          NSFileManager* fileManager = [NSFileManager defaultManager];
    //
    //                          if ([fileManager fileExistsAtPath:path])
    //                          {
    //                              [fileManager removeItemAtPath:path error:nil];
    //                          }
    //
    //
    //                          return;
    //                      }
    //                  }];
    //
    //    [uploadTask resume];
    
    [progress setUserInfoObject:imageID forKey:@"imageID"];
    
    
    // 3. 监听NSProgress对象
    [progress addObserver:self
               forKeyPath:@"fractionCompleted"
                  options:NSKeyValueObservingOptionNew context:nil];
    
    self.mediaAdded[imageID] = progress;
}
// 监听处理方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSProgress *progress = nil;
    if ([object isKindOfClass:[NSProgress class]]) {
        progress = (NSProgress *)object;
    }
    if (progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"已经完成：%f", progress.fractionCompleted);
            NSString *imageID = progress.userInfo[@"imageID"];
            if (imageID) {
                
                [self.editorView setProgress:progress.fractionCompleted onImage:imageID];
                
            }
            
            [self dismissKeyboard];
        });
    }
}

-(void)selectImageType:(int)buttonIndex{
    
    
    if (buttonIndex == 1) {
        //判断当前的设备照相是否可以用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            return ;
            
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            [self.popoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            
            
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
            
        }
        
    }else if (buttonIndex == 0) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            [self.popoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            
            
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
            
        }
        
    }else if(buttonIndex == 2) {
        
        [self showInsertImageAlternatePicker];
        
        
    }
    
}
-(void)showInsertImageAlternatePicker{
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        
        NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
        
       
        [self addAssetToContent:assetURL];
        
        
    }];
    
    
    
    //    [picker dismissViewControllerAnimated:YES completion:^{
    //        
    //    }];
    
}
-(void)addImageFromCamera:(UIImage *)image{
    
    NSString *imageID = [[NSUUID UUID] UUIDString];
    NSString *path = [NSString stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(), imageID];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    [imageData writeToFile:path atomically:YES];
    
    [self submitImage:imageData imageID:imageID];
    [self.editorView insertLocalImage:[[NSURL fileURLWithPath:path] absoluteString] uniqueId:imageID];
    
}
//-(void)autoSaveArticle:(id)args{
//    
//    if(_viewModel.content.length>0 || _viewModel.title.length>0){
//        
//        
//        NSDate *dateTime = [NSDate new];
//        
//        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"HH:mm:ss"];
//        
//        LNNotification* notification = [LNNotification notificationWithMessage:@"Welcome to LNNotificationsUI!"];
//        notification.title = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:dateTime],NSLocalizedString(@"savedToDraftBox", @"已保存至草稿箱")];
//        
//        [[LNNotificationCenter defaultCenter] presentNotification:notification forApplicationIdentifier:@"com.ougohome.softDecorationMaster"];
//        
//    }
//    
//    
//}

-(void)dealloc{
    
    [self setNil];
    
}
-(void)setNil{
    
    self.delegate = nil;
    [self setBodyText:@""];
    [self setTitle:@""];
    
    _popoverController.delegate = nil;
    
    _popoverController = nil;
    
//    if(_saveTimer){
//        
//        [_saveTimer invalidate];
//        _saveTimer = nil;
//        
//    }
    
}

@end
