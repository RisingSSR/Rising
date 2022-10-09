//
//  ScheduleInteractorWCDB.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/24.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**数据缓存业务
 * 创建该业务并绑定所需业务模型
 * 利用**Request业务**进行缓存CRUD行为
 * 禁止在绑定后指定其他绑定对象
 *
 * 该对象强持有数据模型，但不推荐使用该类去访问对象
 * 但可以在合适的时候通过该类去获取到所绑定的对象
 * 没课约采取此缓存时请注意表名
 * 该模型的CRUD不会对bindModel进行改变
 * 相反的，你应该使用一个业务对其进行封装
 */

#import <Foundation/Foundation.h>

#import "ScheduleCombineModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ScheduleInteractorWCDB

@interface ScheduleInteractorWCDB : NSObject

/// 绑定模型
@property (nonatomic, strong, readonly) ScheduleCombineModel *combine;

/// 存储路径（由绑定的模型决定）
@property (nonatomic, readonly, class) NSString *DBPath;

/// 数据表名字
@property (nonatomic, readonly, copy) NSString *tableName;

/// 强制替换
- (void)replace;

#pragma mark - Method

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithSno:(NSString *)sno type:(ScheduleCombineType)type;

@end

NS_ASSUME_NONNULL_END
