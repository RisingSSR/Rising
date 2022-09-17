//
//  MineModel.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "MineModel.h"

@implementation MineModel

- (nonnull id<NSObject>)diffIdentifier {
    return self.name;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    MineModel *old = (MineModel *)object;
    return [self.name isEqualToString:old.name];
}

@end
