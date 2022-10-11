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
#import <ranges>

using namespace std;

struct CombineConnectStatus {
    ScheduleCombineModel *combine;
    BOOL isConnect;
    
    CombineConnectStatus(ScheduleCombineModel *_combine) {
        combine = _combine;
        isConnect = YES;
    }
};

struct ScheudleCourseExtension {
    ScheduleCourse *course;
    NSString *sno;
    ScheduleCombineType type;
    
    ScheudleCourseExtension(ScheduleCourse *_course, NSString *_sno, ScheduleCombineType _type) {
        course = _course;
        sno = _sno;
        type = _type;
    }
    
    ScheudleCourseExtension(ScheduleCourse *_course, NSString *_sno) {
        ScheudleCourseExtension(_course, _sno, ScheduleCombineSystem);
    }
};

typedef map<NSValue *, ScheduleCourse *> DayRangeEntry;
typedef array<DayRangeEntry, 7> WeekDrawEntry;
typedef vector<WeekDrawEntry> DrawEntry;

#pragma mark - ScheduleModel ()

@interface ScheduleModel ()

/// 状态信息
@property (nonatomic) std::map<NSString *, CombineConnectStatus> ccs;

/// 绘制信息
@property (nonatomic) DrawEntry drawEntry;

@end

#pragma mark - ScheduleModel

@implementation ScheduleModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _courseAry = NSArray.array;
        [self _clear];
        
        
        
    }
    return self;
}

- (void)combineModel:(ScheduleCombineModel *)model transfrom:(BOOL)transfrom {
    CombineConnectStatus status = CombineConnectStatus(model);
    _ccs.insert({model.identifier ,status});
    
    for (ScheduleCourse *course in model.courseAry) {
        [course.inSections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * __unused stop) {
            NSInteger section = obj.longValue;
            NSValue *range = [NSValue valueWithRange:course.period];
            [self _check:section remake:NO];
            
            // if origin is nil, everything can be add in
            // untransfrom and uncustom can be sure about muti schedule
            // if without sno, same as muti schedule
            if ((_drawEntry[section][course.inWeek][range] == nil) ||
                (!transfrom && model.combineType != ScheduleCombineCustom) ||
                (_sno == nil || [_sno isEqualToString:@""])) {
                _drawEntry[section][course.inWeek][range] = course;
                return;
            }
            
            ScheudleCourseExtension extension = ScheudleCourseExtension(course, model.sno, model.combineType);
            
        }];
            
    }
}

- (void)_check:(NSInteger)beAppend remake:(BOOL)remake {
    static NSInteger lenth = _drawEntry.size();
    lenth = remake ? 0 : lenth;
    for (NSInteger i = lenth; i <= beAppend; i++) {
        WeekDrawEntry entryW = {};
        for (int i = 0; i < 7; i++) {
            DayRangeEntry entryM = {};
            entryW[i] = entryM;
        }
        _drawEntry.push_back(entryW);
    }
    lenth = beAppend;
}


- (void)_clear {
    map<NSString *, CombineConnectStatus> _map = {};
    _ccs = _map;
    vector<WeekDrawEntry> _draw = {};
    _drawEntry = _draw;
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
