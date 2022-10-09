//
//  ScheduleInteractorWCDB.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/24.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleInteractorWCDB.h"

#import "ScheduleCourse+WCTTableCoding.h"

#pragma mark - ScheduleInteractorWCDB ()

@interface ScheduleInteractorWCDB ()

/// 唯一的db
@property (nonatomic, readonly) WCTDatabase *db;

@end

#pragma mark - ScheduleInteractorWCDB

@implementation ScheduleInteractorWCDB

- (instancetype)initWithSno:(NSString *)sno type:(ScheduleCombineType)type {
    self = [super init];
    if (self) {
        _tableName = [NSString stringWithFormat:@"%@%@", type, sno];
        [self.class.db createVirtualTableOfName:_tableName withClass:ScheduleCourse.class];
        _combine = [ScheduleCombineModel combineWithSno:sno type:type];
        _combine.nowWeek = [NSUserDefaults.standardUserDefaults integerForKey:RisingClassSchedule_nowWeek_Integer];
        _combine.courseAry = [self.class.db getAllObjectsOfClass:ScheduleCourse.class fromTable:self.tableName].mutableCopy;
    }
    return self;
}

- (void)replace {
    [self.class.db deleteAllObjectsFromTable:_tableName];
    [self.class.db insertObjects:_combine.courseAry into:_tableName];
}

#pragma mark - Getter

+ (NSString *)DBPath {
    NSString *pathComponent = @"/schedule/";
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:pathComponent];
}

+ (WCTDatabase *)db {
    static WCTDatabase *_db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _db = [[WCTDatabase alloc] initWithPath:self.DBPath];
    });
    return _db;
}

@end
