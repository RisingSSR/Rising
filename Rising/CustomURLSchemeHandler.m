//
//  CustomURLSchemeHandler.m
//  Rising
//
//  Created by SSR on 2022/9/27.
//

#import "CustomURLSchemeHandler.h"

@implementation CustomURLSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    NSURLRequest *request = urlSchemeTask.request;
        //可以通过url拦截响应的方法
        if ([request.URL.absoluteString.pathExtension isEqualToString:@"png"]
            || [request.URL.absoluteString.pathExtension isEqualToString:@"gif"]) {
            //一个任务完成需要返回didReceiveResponse和didReceiveData两个方法
            //最后在执行didFinish，不可重复调用，可能会导致崩溃
            [urlSchemeTask didReceiveResponse:[NSURLResponse new]];
            [urlSchemeTask didReceiveData:[NSData dataWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpeg"]]];
            [urlSchemeTask didFinish];
            return;
        }
        NSURLSessionDataTask *task = [[NSURLSession sharedSession]
            dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSDictionary *header = httpResponse.allHeaderFields;
            
            NSString *urlStr = httpResponse.URL.absoluteString;
            
            //也可以通过解析data等数据，通过data等数据来确定是否拦截
            //一个任务完成需要返回didReceiveResponse和didReceiveData两个方法
            //最后在执行didFinish，不可重复调用，可能会导致崩溃
            if (!data) {
                [urlSchemeTask didReceiveResponse:[NSURLResponse new]];
                [urlSchemeTask didReceiveData:[NSData dataWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpeg"]]];
            } else {
                [urlSchemeTask didReceiveResponse:response];
                [urlSchemeTask didReceiveData:data];

            }
            [urlSchemeTask didFinish];
        }];
        [task resume];
}


- (void)webView:(WKWebView *)webVie stopURLSchemeTask:(id)urlSchemeTask {
    
}
@end
