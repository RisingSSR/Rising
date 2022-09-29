//
//  MainCollectionViewCell.m
//  Rising
//
//  Created by SSR on 2022/9/16.
//

#import "MainCollectionViewCell.h"

#import "MainDetailCollectionViewCell.h"

NSString *MainCollectionViewCellReuseIdentifier = @"MainCollectionViewCell";

#pragma mark - <#Class#> ()

@interface MainCollectionViewCell () <
    UICollectionViewDataSource
>

/// <#description#>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.SuperFrame collectionViewLayout:layout];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 23;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainDetailCollectionViewCell *cell = [self.superCollectionView dequeueReusableCellWithReuseIdentifier:MainDetailCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.greenColor;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(20, 30);
}

@end
