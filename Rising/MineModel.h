//
//  MineModel.h
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import <Foundation/Foundation.h>

#import <IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : NSObject

/// 名字
@property (nonatomic, copy) NSString *name;

/// 
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
