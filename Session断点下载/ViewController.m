//
//  ViewController.m
//  Session断点下载
//
//  Created by Jay_Apple on 15/7/16.
//  Copyright (c) 2015年 Jay_Apple. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"
#import "LJSessionDownloader.h"
#import "MyProgressView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet MyProgressView *progressV;
@property (weak, nonatomic) IBOutlet MyProgressView *progressV2;
@property (weak, nonatomic) IBOutlet MyProgressView *progressV3;

@property (strong, nonatomic) NSArray *downloaders;

@end

@implementation ViewController
- (IBAction)start {
    //开启所有下载任务
    [self.downloaders makeObjectsPerformSelector:@selector(start)];
}
- (IBAction)suspend {
    //暂停所有下载任务
    [self.downloaders makeObjectsPerformSelector:@selector(suspend)];
}

- (void)viewDidLoad{
    
   //创建下载任务1
   LJSessionDownloader *downloader = [LJSessionDownloader downloadWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"minion.mp4"] withProgress:^(CGFloat progress) {
       self.progressV.progressValue = progress;
   } completion:^{
       NSLog(@"下载完毕");
   }];
    
    //创建下载任务2
    LJSessionDownloader *downloader2 = [[LJSessionDownloader alloc] initWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"minion2.mp4"] withProgress:^(CGFloat progress) {
        self.progressV2.progressValue = progress;
    } completion:^{
        NSLog(@"2下载完毕");
    }];
    
    //下载任务3
    LJSessionDownloader *downloader3 = [[LJSessionDownloader alloc] initWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"minion3.mp4"] withProgress:^(CGFloat progress) {
        self.progressV3.progressValue = progress;
    } completion:^{
        NSLog(@"3下载完毕");
    }];
    
    //添加所有任务到数组
    self.downloaders = @[downloader, downloader2, downloader3];
   
}


@end
