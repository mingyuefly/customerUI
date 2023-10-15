//
//  ViewController.m
//  activityOC
//
//  Created by gmy on 2023/9/27.
//

#import "ViewController.h"
#import "ShareModel.h"
#import "ShareViewModel.h"

#import <QuickLook/QuickLook.h>

//#import <YYKit/YYKit.h>
#import <AFNetworking/AFNetworking.h>
//#import "YYAnimatedImageView.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) QLPreviewController *previewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 30);
    button.center = CGPointMake(self.view.bounds.size.width / 2, 115);
    [button setTitle:@"activity" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(activityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 150, 100, 30);
    button1.center = CGPointMake(self.view.bounds.size.width / 2, 165);
    [button1 setTitle:@"savePDF" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(savePDFAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 200, 100, 30);
    button2.center = CGPointMake(self.view.bounds.size.width / 2, 215);
    [button2 setTitle:@"sharePng" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(savePngAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(0, 250, 100, 30);
    button3.center = CGPointMake(self.view.bounds.size.width / 2, 265);
    [button3 setTitle:@"customShare" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(customShareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 100, 30);
    imageView.center = CGPointMake(self.view.bounds.size.width / 2, 360);
    imageView.backgroundColor = [UIColor cyanColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://183.214.155.7:443/ccaweb/jsp/mca/appRecomLstMng/images/20231012174434.jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^{
//            imageView.image = [UIImage imageWithData:data];
        });
    });
    [self.view addSubview:imageView];
    
//    [MBProgressHUD showMessage:@"正在下载文件" toView:currentVC.view];
    NSString *filePath = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    NSString *policyDirectoryPath = [documentsDirectory stringByAppendingPathComponent:@"服务协议"];
    NSString *pdfName = [NSString stringWithFormat:@"abc.jpg"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:policyDirectoryPath]) {
        // 创建文件目录
        NSError *error = nil;
        BOOL isSuccess = [fileManager createDirectoryAtPath:policyDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Create directory failed: %@",[error localizedDescription]);
            filePath = [documentsDirectory stringByAppendingPathComponent:pdfName];
        } else {
            filePath = [policyDirectoryPath stringByAppendingPathComponent:pdfName];
        }
    } else {
        filePath = [policyDirectoryPath stringByAppendingPathComponent:pdfName];
    }
    NSLog(@"filePath＝＝＝%@",filePath);
    NSString *urlString = @"https://183.214.155.7:443/ccaweb/jsp/mca/appRecomLstMng/images/20231012174434.jpg";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = NO;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld   %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *path = filePath;
        NSLog(@"文件路径＝＝＝%@",path);
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        [MBProgressHUD hideHUDForView:currentVC.view];
        if (!error) {
//            [MBProgressHUD showSuccess:@"下载完成" toView:currentVC.view];
            NSString *pdfFileName = [filePath path];
            NSLog(@"下载完成文件路径＝＝＝%@",pdfFileName);
            NSData *data = [NSData dataWithContentsOfFile:pdfFileName];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = [UIImage imageWithData:data];
            });
            
            // 打开activityViewController，用户可选择将文件存入系统files
//            NSArray *activityItems = @[[NSURL fileURLWithPath:pdfFileName]];
//            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//            [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
        } else {
            NSLog(@"%@", error);
//            [MBProgressHUD showSuccess:@"下载失败" toView:currentVC.view];
        }
    }];
    [task resume];
}

#pragma mark - button actions
-(void)activityAction {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString * content = @"活动的内容";
    //活动的url
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    //活动的图片
    UIImage * image = [UIImage imageNamed:@"iOSImage"];
    UIActivityViewController * con = [[UIActivityViewController alloc]initWithActivityItems:@[content, url, image] applicationActivities:nil];
    //活动行为结束后回调的block
    con.completionWithItemsHandler = ^(UIActivityType activityType, BOOL completed, NSArray * returnedItems, NSError * __nullable activityError){
        NSLog(@"%@ %@ %@ %@",activityType, @(completed), returnedItems, activityError);
        
    };
    [self.navigationController presentViewController:con animated:YES completion:nil];
}

-(void)savePDFAction {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSHomeDirectory());
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *policyPath = [documentPath stringByAppendingPathComponent:@"service"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = @"";
    if (![fileManager fileExistsAtPath:policyPath]) {
        NSError *error;
        BOOL success = [fileManager createDirectoryAtPath:policyPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            filePath = [documentPath stringByAppendingPathComponent:@"title.pdf"];
        } else {
            filePath = [policyPath stringByAppendingPathComponent:@"title.pdf"];
        }
    } else {
        filePath = [policyPath stringByAppendingPathComponent:@"title.pdf"];
    }
    //    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:@"/Users/gmy/Documents/iOS/UI/customerUI/activity/Objective-C/CloseButton.pdf"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:[[NSBundle mainBundle] pathForResource:@"CloseButton.pdf" ofType:nil]];
    NSData *data = [fileHandle readDataToEndOfFile];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    
    //    UIDocumentInteractionController *doc= [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    //    doc.delegate = self;
    //    [doc presentPreviewAnimated:YES];
    
    
    NSArray *activityItems = @[[NSURL fileURLWithPath:filePath]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}

-(void)savePngAction {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSHomeDirectory());
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *policyPath = [documentPath stringByAppendingPathComponent:@"pictures"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = @"";
    if (![fileManager fileExistsAtPath:policyPath]) {
        NSError *error;
        BOOL success = [fileManager createDirectoryAtPath:policyPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            filePath = [documentPath stringByAppendingPathComponent:@"ios.png"];
        } else {
            filePath = [policyPath stringByAppendingPathComponent:@"ios.png"];
        }
    } else {
        filePath = [policyPath stringByAppendingPathComponent:@"ios.png"];
    }
    //    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:@"/Users/gmy/Documents/iOS/UI/customerUI/activity/Objective-C/iOS.png"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:[[NSBundle mainBundle] pathForResource:@"iOS.png" ofType:nil]];
    NSData *data = [fileHandle readDataToEndOfFile];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    
    NSArray *activityItems = @[[NSURL fileURLWithPath:filePath]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
    
    // UIDocumentInteractionController打开文件
//    UIDocumentInteractionController *doc= [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
//    doc.delegate = self;
//    [doc presentPreviewAnimated:YES];
    
    // QuickLook打开文件
//    self.previewController = [[QLPreviewController alloc] init];
//    self.previewController.dataSource = self;
//    [self.navigationController presentViewController:self.previewController animated:YES completion:nil];
    
    // webView打开文件
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CloseButton.pdf" ofType:nil]];
////    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iOS.png" ofType:nil]];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 300)];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    [self.view addSubview:webView];
}

- (void)customShareAction {
    NSArray *activityItems = @[];
    // 分享的是普通文本,指定icon、主标题、子标题、分享的文本
//    ShareModel *originShareTextModel = [ShareModel modelWithShowIcon:[UIImage imageNamed:@"iOSImage"] showTitle:@"主标题1" showSubTitle:@"子标题2" data:@"share text"];
//    ShareViewModel *wrapShareShareTextModel = [ShareViewModel viewModelWithModel: originShareTextModel];
//    activityItems = @[wrapShareShareTextModel];
    
    // 分享的是链接
//    ShareModel *originShareURLModel = [ShareModel modelWithShowIcon:[UIImage imageNamed:@"iOSImage"] showTitle:@"主标题" showSubTitle:@"子标题" data:[NSURL URLWithString:@"http://www.baidu.com"]];
//    ShareViewModel *wrapShareShareURLModel = [ShareViewModel viewModelWithModel: originShareURLModel];
//    activityItems = @[wrapShareShareURLModel];
    
    // 分享的是图片
//    activityItems = @[[UIImage imageNamed:@"iOSImage"]];
//    ShareModel *originShareImageModel = [ShareModel modelWithShowIcon:[UIImage imageNamed:@"iOSImage"] showTitle:@"主标题" showSubTitle:@"子标题" data:[UIImage imageNamed:@"iOSImage"]];
//    ShareViewModel *wrapShareShareImageModel = [ShareViewModel viewModelWithModel: originShareImageModel];
//    activityItems = @[wrapShareShareImageModel];
    
    // 分享pdf
    activityItems = @[[UIImage imageNamed:@"iOSImage"]];
    ShareModel *originShareImageModel = [ShareModel modelWithShowIcon:[UIImage imageNamed:@"iOSImage"] showTitle:@"主标题" showSubTitle:@"子标题" data:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CloseButton.pdf" ofType:nil]]];
    ShareViewModel *wrapShareShareImageModel = [ShareViewModel viewModelWithModel: originShareImageModel];
    activityItems = @[wrapShareShareImageModel];
    
    // 分享多个内容
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    __weak typeof(self) weakself = self;
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (activityType == nil && activityError == nil && completed == NO) {
            NSLog(@"关闭分享弹窗");
        } else if (activityType != nil && completed) {
            // 分享成功
            
        } else if (activityType != nil && activityError != nil) {
            // 操作失败];
        } else if (activityType != nil && completed == NO) {
            // 操作失败
            // 备忘录取消操作
        } else {
            //
        }
    };
    
    [self.navigationController presentViewController:activityVC animated:YES completion:^{
        
    }];
}

#pragma mark - UIDocumentInteractionControllerDelegate
//必须实现的代理方法 预览窗口以模式窗口的形式显示，因此需要在该方法中返回一个view controller ，作为预览窗口的父窗口。如果你不实现该方法，或者在该方法中返回 nil，或者你返回的 view controller 无法呈现模式窗口，则该预览窗口不会显示。

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    
    return self;
}

- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller {
    
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    
    return CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 3;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CloseButton.pdf" ofType:nil]];
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iOS.png" ofType:nil]];
    return url;
}


@end
