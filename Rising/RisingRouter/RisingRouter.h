//
//  RisingRouter.h
//  Rising
//
//  Created by SSR on 2022/7/11.
//

/// 这个类就是Router类，直接使用RisingRouter.router
/// 只有遵循了RisingHandlerProtocol的类才会被路由

#import <UIKit/UIKit.h>

#import "RisingRouterCompletionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - RisingRouter

@interface RisingRouter <__contravariant ProtocolType : Protocol *> : NSObject

- (void)registClass:(Class <RisingRouterCompletionProtocol>)className protocol:(ProtocolType)protocolName;

- (void)requestBlock:(void (^)(id <RisingRouterCompletionProtocol> item))block;

@end


@interface RisingRouter (aa)

- (UIViewController * _Nullable)topViewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable )(void))completion;

@end










#pragma mark - NSObject (RisingRouter)

@interface NSObject (RisingRouter)

@property (nonatomic, readonly) RisingRouter *router;

@end

NS_ASSUME_NONNULL_END
