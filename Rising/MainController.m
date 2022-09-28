//
//  MainController.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "MainController.h"

#import "MainCollectionViewCell.h"

#import "MainDetailCollectionViewCell.h"

#import "TestingCar.h"

#import "MainProtocol.h"

@interface MainController () <
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

/// a
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MainController

+ (void)load {
//    RisingRouter *a;
//    [a registClass:self protocol:@protocol(MainProtocol)];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self.view addSubview:self.collectionView];
//    [self test];
    [self test5];
}

#pragma mark - Method

- (void)test5 {
    NSNumberFormatter *formatter = NSNumberFormatter.new;
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    formatter.locale = [NSLocale CN];
    NSString *str = [formatter stringFromNumber:@2];
    RisingLog("😀", @"%@", str);
}

- (void)test4 {
    NSRange r1 = NSMakeRange(0, 2);
    NSRange r2 = NSMakeRange(3, 2);
    NSRange t1 = NSIntersectionRange(r1, r2);
    NSRange t2 = NSUnionRange(r1, r2);
    RisingLog("😅", @"%@", NSStringFromRange(t1));
    RisingLog("😅", @"%@", NSStringFromRange(t2));
}

- (void)test3 {
    CGRect r1 = CGRectMake(50, 130, 30, 30);
    CGRect r2 = CGRectMake(30, 130, 80, 50);
    BOOL t1 = CGRectIntersectsRect(r1, r2);
    BOOL t2 = CGRectContainsRect(r1, r2);
    RisingLog("🥹", @"%d - %d", t1, t2);
    UILabel *lab1 = [[UILabel alloc] initWithFrame:r1];
    lab1.text = @(t1).stringValue;
    lab1.backgroundColor = UIColor.redColor;
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:r2];
    lab2.text = @(t2).stringValue;
    lab2.backgroundColor = UIColor.greenColor;
    [self.view addSubview:lab2];
    [self.view addSubview:lab1];
}

- (void)test2 {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = NSLocale.CN;
    formatter.timeZone = NSTimeZone.CQ;
    NSArray *t = formatter.shortWeekdaySymbols;
    RisingLog("😀", @"%@", t);
}

- (void)test {
    NSString *str = [NSDate.date stringWithFormat:@"EEE" timeZone:NSTimeZone.CQ locale:NSLocale.CN];
    RisingDetailLog(@"%@", str);

    UIView *A = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    A.backgroundColor = UIColor.redColor;
    
    UIView *B = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    B.backgroundColor = UIColor.greenColor;
    
    UIView *C = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    C.backgroundColor = UIColor.orangeColor;
    
    [A addSubview:C];
    [B addSubview:C];
    
    [self.view addSubview:A];
    [self.view addSubview:B];
    NSDictionary *a;NSObject *b;
    
    TestingBase <TestingCar *> *base = [[TestingBase alloc] init];
    [base test:^(TestingCar * _Nonnull item) {
            
    }];
    
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

//+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
//
//    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
//
//    switch (request.requestType) {
//        case RouterRequestPush: {
//
//            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
//
//            if (nav) {
//                MainController *vc = [[self alloc] init];
//                response.responseController = vc;
//
//                [nav pushViewController:vc animated:YES];
//            } else {
//
//                response.errorCode = RouterResponseWithoutNavagation;
//            }
//
//        } break;
//
//        case RouterRequestParameters: {
//            // TODO: 传回参数
//        } break;
//
//        case RouterRequestController: {
//
//            MainController *vc = [[self alloc] init];
//
//            response.responseController = vc;
//        } break;
//    }
//
//    if (completion) {
//        completion(response);
//    }
//}

@end
