//
//  WKViewController.m
//  Rising
//
//  Created by SSR on 2022/9/27.
//

#import "WKViewController.h"

#import <WebKit/WebKit.h>
#import "CustomURLSchemeHandler.h"
#import <WKWebViewJavascriptBridge.h>

@interface WKViewController () <
    WKUIDelegate,
    WKNavigationDelegate
//    NSURLProtocolClient
>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
}

- (WKWebView *)webView {
    if (_webView == nil) {
        
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        CustomURLSchemeHandler *handler = [[CustomURLSchemeHandler alloc]init];
        [configuration setURLSchemeHandler:handler forURLScheme:@"www.baidu.com"];
//        [configuration setURLSchemeHandler:handler forURLScheme:@"http"];
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.SuperFrame configuration:configuration];
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark - AAA

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    RisingLog("😀", @"%@", navigation);
    NSString *str = @""
    "    "
    "     ";
    
}

@end
