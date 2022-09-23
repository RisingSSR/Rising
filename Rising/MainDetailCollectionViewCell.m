//
//  MainDetailCollectionViewCell.m
//  Rising
//
//  Created by SSR on 2022/9/16.
//

#import "MainDetailCollectionViewCell.h"

NSString *MainDetailCollectionViewCellReuseIdentifier = @"MainDetailCollectionViewCell";

@implementation MainDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        static NSInteger i = 0;
        RisingDetailLog(@"%ld", i);
        i++;
    }
    return self;
}

@end
