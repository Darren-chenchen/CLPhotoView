//
//  ViewController.m
//  高仿发微博
//
//  Created by darren on 16/6/24.
//  Copyright © 2016年 shanku. All rights reserved.
//

#import "ViewController.h"
#import "CLTextView.h"
#import "CLPhotosVIew.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TZImagePickerController.h"
@interface ViewController ()<UITextViewDelegate>
/***/
@property (nonatomic,weak) CLPhotosVIew *phontView;
@property (nonatomic,strong) NSMutableArray *imgArr;

@end

@implementation ViewController
/*懒加载**/
- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLTextView *textView = [[CLTextView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    textView.placehoder = @"请输入要评论的内容...";
    [self.view addSubview:textView];
    
    CLPhotosVIew *photosView = [[CLPhotosVIew alloc] initWithFrame:CGRectMake(10, 50, textView.frame.size.width-20, 250)];
    self.phontView = photosView;
    photosView.photoArray = @[[UIImage imageNamed:@"images_01"]];
    __weak ViewController *weakSelf=self;
    photosView.clickcloseImage = ^(NSInteger index){
        [weakSelf.imgArr removeObjectAtIndex:index];
    };
    photosView.clickChooseView = ^{
        // 直接调用相册
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [weakSelf.imgArr addObjectsFromArray:photos];
            NSArray *arr = [weakSelf.imgArr arrayByAddingObjectsFromArray:@[[UIImage imageNamed:@"images_01"]]];
            weakSelf.phontView.photoArray = arr;
        }];
        [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];

    };
    [textView addSubview:photosView];
}

#pragma  mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat textH = [textView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGRect frame = self.phontView.frame;
    frame.origin.y = 50+textH;
    self.phontView.frame = frame;
}
@end
