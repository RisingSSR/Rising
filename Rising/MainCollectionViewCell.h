//
//  MainCollectionViewCell.h
//  Rising
//
//  Created by SSR on 2022/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *MainCollectionViewCellReuseIdentifier;

@interface MainCollectionViewCell : UICollectionViewCell

/// <#description#>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
