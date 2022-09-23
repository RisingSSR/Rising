//
//  TestingCar.m
//  Rising
//
//  Created by SSR on 2022/9/20.
//

#import "TestingCar.h"

@implementation TestingCar

- (void)setAAAAA {
    NSLog(@"%@", self);
}

- (void)ABC {
    RisingDetailLog(@"%s", __func__);
}

@end

@interface BRTest (TestingCar) <TCP>

@end

@implementation BRTest (TestingCar)

- (void)ABC {
    RisingDetailLog(@"%s", __func__);
}

- (void)BCD {
    RisingDetailLog(@"%s", __func__);
}

- (void)TCP {
    RisingDetailLog(@"%s", __func__);
}

@end
