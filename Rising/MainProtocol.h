//
//  MainProtocol.h
//  Rising
//
//  Created by SSR on 2022/9/20.
//

#import "RisingRouterCompletionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainProtocol <RisingRouterCompletionProtocol>

- (void)main;

@end

@interface RisingRouter (MainProtocol) <MainProtocol>

@end

NS_ASSUME_NONNULL_END
