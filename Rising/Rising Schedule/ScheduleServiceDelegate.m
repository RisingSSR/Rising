//
//  ScheduleServiceDelegate.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/10.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleServiceDelegate.h"

#import "ScheduleInteractorRequest.h"

#import "ScheduleInteractorWCDB.h"

#pragma mark - ScheduleServiceDelegate ()

@interface ScheduleServiceDelegate ()

/// <#description#>
@property (nonatomic) CGPoint contentPointWhenPanNeeded;

@end

@implementation ScheduleServiceDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[ScheduleModel alloc] init];
    }
    return self;
}

- (void)requestAndReloadData {
    
    NSString *str = [NSBundle.mainBundle pathForResource:@"rowLessonDataArr" ofType:nil];
    NSArray *lessonAry = [NSArray arrayWithContentsOfFile:str];
    
    NSString *stuNum = @"2021215154";
    NSInteger nowWeek = 4;
    
    ScheduleCombineModel *model =
    [ScheduleCombineModel
     combineWithSno:stuNum
     type:ScheduleCombineSystem];
    
    model.nowWeek = nowWeek;
    
    for (NSDictionary *courceDictionary in lessonAry) {
        
        ScheduleCourse *course = [[ScheduleCourse alloc] initWithDictionary:courceDictionary];
//        course.sno = stuNum.copy;
        
        [model.courseAry addObject:course];
    }
    
    [self.model combineModel:model];
    self.model.nowWeek = model.nowWeek;
    
    [self.collectionView reloadData];
    
}

- (void)_pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.collectionView];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
            if (indexPath) {
                return;
            }
            
            
        } break;
            
        case UIGestureRecognizerStateChanged: {
            
        } break;
            
        default: {
            
        }
    }
}

#pragma mark - Method

- (void)scrollToSection:(NSUInteger)page {
    [self.collectionView setContentOffset:CGPointMake(page * self.collectionView.width, 0) animated:YES];
}

#pragma mark - Setter

- (void)setCollectionView:(UICollectionView *)view {
    _collectionView = view;
    
    view.delegate = self;
    [view.panGestureRecognizer addTarget:self action:@selector(_pan:)];
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
