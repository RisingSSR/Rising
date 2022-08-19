//
//  MainController.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "MainController.h"

#import "ScrollB.h"

@interface MainController () <UIScrollViewDelegate>

/// <#description#>
@property (nonatomic, strong) UIScrollView *scrollA;

/// <#description#>
@property (nonatomic, strong) ScrollB *scrollB;

/// <#description#>
@property (nonatomic) BOOL enableFatherViewScroll;

/// <#description#>
@property (nonatomic) BOOL enableChildViewScroll;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self.view addSubview:self.scrollA];
//    [self.scrollA addSubview:self.scrollB];
}

- (UIScrollView *)scrollA {
    if (_scrollA == nil) {
        _scrollA = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 400)];
        _scrollA.backgroundColor = UIColor.orangeColor;
        _scrollA.contentSize = CGSizeMake(0, 800);
        _scrollA.delegate = self;
    }
    return _scrollA;
}

- (ScrollB *)scrollB {
    if (_scrollB == nil) {
        _scrollB = [[ScrollB alloc] initWithFrame:CGRectMake(50, 50, 100, 200)];
        _scrollB.backgroundColor = UIColor.redColor;
        _scrollB.contentSize = CGSizeMake(0, 800);
//        _scrollB.bounces = NO;
        _scrollB.delegate = self;
    }
    return _scrollB;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffset = 20;
    // 如果是大的
    if (scrollView == self.scrollA) {
        // 且自己不能滑动
        if (!self.enableFatherViewScroll) {
            // 自己永远在这个offset
            scrollView.contentOffset = CGPointMake(0, contentOffset);
            // 并且让自己的子视图可以操作
            self.enableChildViewScroll = YES;
        } else {
        // 自己能滑动
            if (scrollView.contentOffset.y >= contentOffset) {
                // 且视图是下拉，自己视图下拉
                scrollView.contentOffset = CGPointMake(0, contentOffset);
                if (self.enableFatherViewScroll) {
                    // 如果自己允许滑动
                    self.enableFatherViewScroll = NO;
                    self.enableChildViewScroll = YES;
                }
            }
        }
    } else {
    // 如果是小的滑动
        if (!self.enableChildViewScroll) {
            // 并且小的能滑动，则
            scrollView.contentOffset = CGPointMake(0, 0);
        } else {
            if (scrollView.contentOffset.y <= 0) {
                self.enableChildViewScroll = NO;
                self.enableFatherViewScroll = YES;
            }
        }
    }
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"main"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                MainController *vc = [[self alloc] init];
                response.responseController = vc;
                
                [nav pushViewController:vc animated:YES];
            } else {
                
                response.errorCode = RouterResponseWithoutNavagation;
            }
            
        } break;
            
        case RouterRequestParameters: {
            // TODO: 传回参数
        } break;
            
        case RouterRequestController: {
            
            MainController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}

@end
