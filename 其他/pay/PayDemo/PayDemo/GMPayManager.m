//
//  GMPayManager.m
//  PayDemo
//
//  Created by Gguomingyue on 2018/3/27.
//  Copyright © 2018年 Gmingyue. All rights reserved.
//

#import "GMPayManager.h"
#import "GMPayConstant.h"
#import "UPPaymentControl.h"

@implementation GMPayWXModel

@end

@interface GMPayManager ()

@property (nonatomic, copy) NSString *wxAppid;
@property (nonatomic, copy) void(^completedBlock)(NSDictionary *resultDict);

@end

@implementation GMPayManager

+(instancetype)shareManager
{
    static GMPayManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GMPayManager alloc] init];
    });
    return instance;
}

-(BOOL)wxAppInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GM_WxUrlPrefix]];
}

-(BOOL)aliPayInstalled
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GM_AlUrlPrefix]];
}

-(void)wxpayOrder:(GMPayWXModel *)model completed:(void (^)(NSDictionary *resultDictionary))completedBlock
{
    if (!model) {
        NSLog(@"缺少pay参数");
        return;
    }
    if (![[GMPayManager shareManager] wxAppInstalled]) {
        NSLog(@"未安装微信");
        return;
    }
    self.wxAppid = model.openID;
    model.package = [model.package stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    NSString *parameterString = [NSString stringWithFormat:@"nonceStr=%@&package=%@&partnerId=%@&prepayId=%@&timeStamp=%d&sign=%@&signType=%@",model.nonceStr,model.package,model.partnerId,model.prepayId,(unsigned int)model.timeStamp,model.sign,@"SHA1"];
    NSString *openUrl = [NSString stringWithFormat:@"%@app/%@/pay/?%@",GM_WxUrlPrefix, model.openID, parameterString];
    if (completedBlock) {
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(void)alipayOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr completed:(void(^)(NSDictionary *resultDict))completedBlock
{
    if (!orderStr) {
        NSLog(@"缺少orderStr参数");
        return;
    }
    if (!schemeStr) {
        NSLog(@"缺少schemeStr参数");
        return;
    }
    if (![[GMPayManager shareManager] aliPayInstalled]) {
        NSLog(@"未安装支付宝");
        return;
    }
    NSDictionary *dict = @{@"fromAppUrlScheme":schemeStr,@"requestType":@"SafePay",@"dataString":orderStr};
    NSString *jsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *encodeString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)jsonString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    NSString *openUrl = [NSString stringWithFormat:@"%@%@%@",GM_AlUrlPrefix,GM_AlUrlClient,encodeString];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(void)unionPayOrder:(NSString*)tn viewController:(UIViewController*)viewController
{
    [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"" mode:@"" viewController:viewController];
}

-(BOOL)handleOpenURL:(NSURL *)url{
    NSString *absoluteString = url.absoluteString;
    NSString *urlString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)absoluteString, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    if ([urlString rangeOfString:@"//safepay/"].location != NSNotFound){
        NSString *resultStr = [[urlString componentsSeparatedByString:@"?"] lastObject];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"ResultStatus" withString:@"resultStatus"];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[resultStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *resultDict = result[@"memo"];
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    if (self.wxAppid && [urlString rangeOfString:self.wxAppid].location != NSNotFound){
        NSArray *retArray =  [urlString componentsSeparatedByString:@"&"];
        NSInteger errCode = -1;
        NSString *errStr = @"普通错误";
        for (NSString *retStr in retArray) {
            if([retStr containsString:@"ret="]){
                errCode = [[retStr stringByReplacingOccurrencesOfString:@"ret=" withString:@""] integerValue];
            }
        }
        if(errCode == 0){
            errStr = @"成功";
        }else if (errCode == -2){
            errStr = @"用户取消";
        }else if (errCode == -3){
            errStr = @"发送失败";
        }else if (errCode == -4){
            errStr = @"授权失败";
        }else if (errCode == -5){
            errStr = @"微信不支持";
        }
        NSDictionary *resultDict = @{@"errCode":@(errCode),@"errStr":errStr};
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
                if([self verify:sign]) {
                    //验签成功
                }
                else {
                    //验签失败
                }
            }
            
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }
    }];
    return NO;
}

-(BOOL) verify:(NSString *) resultStr {
    
    //此处的verify，商户需送去商户后台做验签
    return NO;
}



@end
