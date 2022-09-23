//
//  TestingBase.h
//  Rising
//
//  Created by SSR on 2022/9/20.
//

#import <Foundation/Foundation.h>

#import "TestingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol A

- (void)ABC;

@end


@protocol B <A>

- (void)BCD;

@end


@interface ARTest <A> : NSObject

@end

@interface TestingBase <__contravariant ObjectType : id<TestingProtocol>> : NSObject

- (void)test:(void (^)(ObjectType item))test;

@end

@interface BRTest <__covariant ObjectType : id <A>> : ARTest

- (void)test:(void (^)(id <A> item))test;

@end

NS_ASSUME_NONNULL_END
