//
//  MainCollectionViewCell.m
//  Rising
//
//  Created by SSR on 2022/9/16.
//

#import "MainCollectionViewCell.h"

NSString *MainCollectionViewCellReuseIdentifier = @"MainCollectionViewCell";

#pragma mark - <#Class#> ()

@interface MainCollectionViewCell ()

@end

@implementation MainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}



@end
