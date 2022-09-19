//
//  MainController.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "MainController.h"

#import "MainCollectionViewCell.h"

#import "MainDetailCollectionViewCell.h"

@interface MainController () <
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

/// a
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MainController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Method

- (void)test {
    NSString *str = [NSDate.date stringWithFormat:@"EEE" timeZone:NSTimeZone.CQ locale:NSLocale.CN];
    RisingDetailLog(@"%@", str);

}

// MARK: SEL

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:MainCollectionViewCell.class forCellWithReuseIdentifier:MainCollectionViewCellReuseIdentifier];
        [_collectionView registerClass:MainDetailCollectionViewCell.class forCellWithReuseIdentifier:MainDetailCollectionViewCellReuseIdentifier];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MainCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.redColor;
    cell.superCollectionView = collectionView;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
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
