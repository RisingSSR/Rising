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
        RisingDetailLog(@"%@", self);
    }
    return self;
}

@end
