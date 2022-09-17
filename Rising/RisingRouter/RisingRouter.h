//
//  RisingRouter.h
//  Rising
//
//  Created by SSR on 2022/7/11.
//

/// 这个类就是Router类，直接使用RisingRouter.router
/// 只有遵循了RisingHandlerProtocol的类才会被路由

#import <Foundation/Foundation.h>

#import "RisingUIKitExtension.h"

#import "RisingRouterHandler.h"

#import "RisingRouterRequest.h"

#import "RisingRouterCS.h"

NS_ASSUME_NONNULL_BEGIN

/// 路由的类路由后可选择接受回掉，
typedef void(^RisingRouterCompletionBlock)(RisingRouterRequest *request, RisingRouterResponse *response);

#pragma mark - RisingRouter

@interface RisingRouter : NSObject

/// 单例Router
@property(nonatomic, readonly, class) RisingRouter *router;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 开启路由，使用block进行添加setter
/// @param request 请求路径
/// @param completion 路由完成后回掉
- (void)handleRequest:(RisingRouterRequest *)request
           complition:(_Nullable RisingRouterCompletionBlock)completion;








//- (void)registerName:(NSString *)name response:(RisingRouterCS *)client;

- (void)requestRouterName:(NSString *)name
                parameter:(NSDictionary *)parameter;

@end


@interface RisingRouter (aa)

- (void)registerClass:(Class <RisingRouterHandler>)someClass;

- (void)registerName:(NSString *)name response:(void (^ _Nullable)(NSDictionary *pram))responseBlock;

- (void)registerName:(NSString *)name responseProtocol:(void (^ _Nullable)(id <RisingRouterHandler> item))protocolBlcok;

@end










#pragma mark - NSObject (RisingRouter)

@interface NSObject (RisingRouter)

@property (nonatomic, readonly) RisingRouter *router;

@end

NS_ASSUME_NONNULL_END
