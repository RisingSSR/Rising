//
//  ViewController.m
//  Rising
//
//  Created by SSR on 2022/10/11.
//

#import "ViewController.h"

#import "RisingNetManager.h"

#import <CocoaMarkdown/CocoaMarkdown.h>

#import <AppAuth/AppAuth.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test5];
    
    UITextField *a;
}

- (void)test7 {
    NSURL *issuer = [NSURL URLWithString:@"https://sso.imvictor.tech/auth/realms/master"];
    NSURL *redirectURI = [NSURL URLWithString:@"http://localhost:53456/*"];

//    [OIDAuthorizationService discoverServiceConfigurationForIssuer:issuer
//        completion:^(OIDServiceConfiguration *_Nullable configuration,
//                     NSError *_Nullable error) {
//
//      if (!configuration) {
//        NSLog(@"Error retrieving discovery document: %@",
//              [error localizedDescription]);
//        return;
//      }
//
//
//    }];
    
    
    NSString *kClientID = @"5UkgeN3how465mpQ0K5BO5dmeRw2sIcn";
    NSString *kClientSecret = @"";
    
    OIDServiceConfiguration *configuration = [[OIDServiceConfiguration alloc] initWithAuthorizationEndpoint:[NSURL URLWithString:@""] tokenEndpoint:[NSURL URLWithString:@""]];
    
    // builds authentication request
    OIDAuthorizationRequest *request =
        [[OIDAuthorizationRequest alloc] initWithConfiguration:configuration
                                                      clientId:kClientID
                                                  clientSecret:kClientSecret
                                                        scopes:@[ OIDScopeOpenID ]
                                                   redirectURL:redirectURI
                                                  responseType:OIDResponseTypeCode
                                          additionalParameters:nil];
    // performs authentication request
    __weak __typeof(self) weakSelf = self;
        [OIDAuthState authStateByPresentingAuthorizationRequest:request
                            callback:^(OIDAuthState *_Nullable authState,
                                       NSError *_Nullable error) {
      // Brings this app to the foreground.
//      [[NSRunningApplication currentApplication]
//          activateWithOptions:(NSApplicationActivateAllWindows |
//                               NSApplicationActivateIgnoringOtherApps)];

      // Processes the authorization response.
      if (authState) {
        NSLog(@"Got authorization tokens. Access token: %@",
              authState.lastTokenResponse.accessToken);
      } else {
        NSLog(@"Authorization error: %@", error.localizedDescription);
      }
      [weakSelf setAuthState:authState];
    }];
    
    [_authState performActionWithFreshTokens:^(NSString *_Nonnull accessToken,
                                               NSString *_Nonnull idToken,
                                               NSError *_Nullable error) {
      if (error) {
        NSLog(@"Error fetching fresh tokens: %@", [error localizedDescription]);
        return;
      }

      // perform your API request using the tokens
    }];
}







- (void)test1 {
    NSMutableDictionary *dic = NSMutableDictionary.dictionary;
    NSRange r1 = NSMakeRange(1, 2);
    NSRange r2 = NSMakeRange(1, 3);
    
    NSValue *v1 = [NSValue valueWithRange:r1];
    NSValue *v2 = [NSValue valueWithRange:r2];
    
    dic[v1] = @"a";
    dic[v2] = @"b";
    
    NSValue *t1 = [NSValue valueWithRange:r1];
    
    dic[t1] = @"c";

    RisingLog("😀", @"%@", dic);
}

- (void)test2 {
    CGRect r1 = CGRectMake(0, 0, 100, 100);
    CGRect r2 = CGRectMake(0, 0, 50, 50);
    RisingDetailLog(@"%d - %d", CGRectContainsRect(r1, r2), CGRectContainsRect(r2, r1));
}

- (void)test3 {
    RisingNetManager *manager = RisingNetManager.shareManager;
    manager
        .GET(@"tttt")
        .header(^(NSDictionary<NSString *,id> * _Nonnull headerFeild) {
            
        })
        .parametersInURI(@{
            @"page" : @(1)
        })
        .dataTask(@{
            @"stu_num" : @"20201215154"
        })
        .mutiForm(^(id<RisingMultipartFormData> body) {
            
        })
        .resume(^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull object, NSError * _Nullable error) {
            
        });
    
    manager.GET(@"/202121212/dian_zan").resume(nil);
    
}

- (void)test4 {
    for(NSString *fontFamilyName in [UIFont familyNames]){
        NSLog(@"family: %@ ",fontFamilyName);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]){
            NSLog(@"\t font: %@ ",fontName);
        }
        NSLog(@"-------------");
    }
}

- (void)test5 {
    CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"markdown_test" ofType:@"md"] options:CMDocumentOptionsSmart];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 400)];
    CMTextAttributes *textA = [[CMTextAttributes alloc] init];
    textA.h1Attributes = @{
        NSFontAttributeName : [UIFont fontWithName:PingFangSC size:34],
        NSForegroundColorAttributeName : [UIColor redColor]
    };
    
    
    
    NSAttributedString *astr = [document attributedStringWithAttributes:textA];
    textView.attributedText = astr;
    
    [self.view addSubview:textView];
}

@end
