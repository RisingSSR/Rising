//
//  RisingRouterCS.h
//  Rising
//
//  Created by SSR on 2022/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RisingRouterCS : NSObject

@property (nonatomic) Class objClass;

@property (nonatomic, strong, nullable) NSObject *obj;

/// <#description#>
@property (nonatomic, strong) NSDictionary *clientParameter;

/// <#description#>
@property (nonatomic, strong) NSDictionary *serverParameter;

@end

NS_ASSUME_NONNULL_END
