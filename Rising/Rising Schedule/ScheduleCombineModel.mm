//
//  ScheduleCombineModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCombineModel.h"

#import "ScheduleCourse+WCTTableCoding.h"

ScheduleCombineType const ScheduleCombineSystem = @"system";

ScheduleCombineType const ScheduleCombineCustom = @"custom";

#pragma mark - ScheduleCombineModel

@implementation ScheduleCombineModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _courseAry = NSMutableArray.array;
    }
    return self;
}


+ (instancetype)combineWithSno:(NSString *)sno type:(ScheduleCombineType)type {
    BOOL check = ((!sno || sno.length < 2) || (!type));
    if (check) {
        NSAssert(!check, @"\n🔴%s sno : %@, type : %@", __func__, sno, type);
        return nil;
    }
    
    ScheduleCombineModel *model = [[ScheduleCombineModel alloc] init];
    
    model->_sno = sno.copy;
    model->_combineType = type.copy;
    
    return model;
}

- (NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@", _combineType, _sno];
}

@end

@implementation ScheduleCombineModel (XXHB)

+ (NSString *)path {
    NSString *pathComponent = [NSString stringWithFormat:@"/schedule/"];
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:pathComponent];
}

+ (WCTDatabase *)db {
    static WCTDatabase *_db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _db = [[WCTDatabase alloc] initWithPath:self.path];
    });
    return _db;
}

- (void)replace {
    [self.class.db deleteAllObjectsFromTable:self.identifier];
    [self.class.db insertObjects:self.courseAry into:self.identifier];
}

- (void)awake {
    self.courseAry = [self.class.db getAllObjectsOfClass:ScheduleCourse.class fromTable:self.identifier].mutableCopy;
}

@end
