//
//  ScheduleModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/2.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleModel.h"

#import <map>
#import <vector>
#import <array>

using namespace std;

struct CombineConnectStatus {
    ScheduleCombineModel *combine;
    BOOL isConnect;
    
    bool operator==(const CombineConnectStatus &other) const {
        return ([combine.identifier isEqualToString:other.combine.identifier]);
    }
    
    BOOL isValid() {
        return (combine == nil);
    }
};

struct ScheudleCourseEntry {
    ScheduleCourse *course;
    CombineConnectStatus *status;
    
    BOOL isValid() {
        return (course == nil);
    }
};

typedef map<NSValue *, ScheudleCourseEntry> DayRangeEntry;
typedef array<DayRangeEntry, 7> WeekDrawEntry;
typedef vector<WeekDrawEntry> DrawEntry;

NS_INLINE NSValue *NSValueFromRange(NSRange range) {
    return [NSValue valueWithRange:range];
}

#pragma mark - ScheduleModel

@implementation ScheduleModel {
    map<NSString *, CombineConnectStatus> _combineMap;
    DrawEntry _drawEntry;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _courseAry = NSArray.array;
        
    }
    return self;
}

- (void)combineModel:(ScheduleCombineModel *)model transfrom:(BOOL)transfrom {
    if (!_combineMap[model.identifier].isValid()) {
        [self _clear];
    }
    _combineMap.insert({model.identifier, {model, YES}});
    
    for (ScheduleCourse *course in model.courseAry) {
        [course.inSections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * __unused stop) {
            NSInteger week = obj.longValue;
            NSValue *rangeValue = NSValueFromRange(course.period);
            [self _check:week];
            
            _drawEntry[week][course.inWeek - 1][rangeValue] = {course, &_combineMap[model.identifier]};
        }];
    }
}

- (void)_check:(NSInteger)beAppend {
    for (NSInteger i = _drawEntry.size(); i < beAppend; i++) {
        _drawEntry.push_back({
            DayRangeEntry(),
            DayRangeEntry(),
            DayRangeEntry(),
            DayRangeEntry(),
            DayRangeEntry(),
            DayRangeEntry(),
            DayRangeEntry()
        });
    }
}

- (void)_clear {
    
}

- (void)_compare:(ScheduleCourse *)course
        withWeek:(NSInteger)week
      withStatus:(const CombineConnectStatus )status {
    NSValue *rangeValue = NSValueFromRange(course.period);
//    if (_drawEntry[week][course.inWeek - 1].at(rangeValue)) {
//        _drawEntry[week][course.inWeek - 1][rangeValue] = {course, &status};
//    }
}

#pragma mark - Setter

- (void)setNowWeek:(NSUInteger)nowWeek {
    if (nowWeek == _nowWeek) {
        return;
    }
    _nowWeek = nowWeek;
    NSDate *date = NSDate.date;
    NSTimeInterval beforNow = (_nowWeek - 1) * 7 * 24 * 60 * 60 + (date.weekday - 2) * 24 * 60 * 60;
    _startDate = [NSDate dateWithTimeIntervalSinceNow:-beforNow];
}

@end
