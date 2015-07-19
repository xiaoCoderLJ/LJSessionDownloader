# LJSessionDownloader
-基于NSURLSession的断点下载（支持离线后恢复）,若果目标文件已存在会提示文件已下载。

##使用方法
 -将文件拖进工程
 ` LJSessionDownloader.h `
 ` LJSessionDownloader.m `
 
 -导入头文件
  `LJSessionDownloader.h`
  
 -创建对象，一个URL对应一个downloader

 -设置URL和文件储存路径，在下载进度block和下载完成block设置回调动作(也可不设置)

 -调用start方法开始下载，suspend方法暂停。

##API

```objc
/*
 *  工厂方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param contentPath 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
+ (instancetype)downloadWithURLString:(NSString *)urlString contentPath:(NSString *)contentPath withProgress:(void (^) (CGFloat progress))progress completion:(void (^) ())completion;

/**
 *  初始化方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param contentPath 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
- (instancetype)initWithURLString:(NSString *)urlString contentPath:(NSString *)contentPath withProgress:(void (^) (CGFloat progress))progress completion:(void (^) ())completion;

/**
 *  开始下载
 */
- (void)start;

/**
 *  暂停下载
 */
- (void)suspend;
```
##使用示范

```objc
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
   LJSessionDownloader *downloader = [LJSessionDownloader downloadWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"minion.mp4"] withProgress:^(CGFloat progress) {
       self.progressV.progressValue = progress;
   } completion:^{
       NSLog(@"下载完毕");
   }];
    
    //创建下载任务2
    LJSessionDownloader *downloader2 = [[LJSessionDownloader alloc] initWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"minion2.mp4"] withProgress:^(CGFloat progress) {
        self.progressV2.progressValue = progress;
    } completion:^{
        NSLog(@"2下载完毕");
    }];
    
    //下载任务3
    LJSessionDownloader *downloader3 = [[LJSessionDownloader alloc] initWithURLString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4" contentPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"minion3.mp4"] withProgress:^(CGFloat progress) {
        self.progressV3.progressValue = progress;
    } completion:^{
        NSLog(@"3下载完毕");
    }];
    
    //添加所有任务到数组
    self.downloaders = @[downloader, downloader2, downloader3];
   
}

```
#demo 

 ![image](https://github.com/xiaoCoderLJ/LJSessionDownloader/raw/master/downloadDemo.gif)
