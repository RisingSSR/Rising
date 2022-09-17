//
//  RisingNetManager.h
//  Rising
//
//  Created by SSR on 2022/9/17.
//

#import <Foundation/Foundation.h>

#import "RisingSigleClass.h"

#if __has_include(<AFNetworking.h>)
#import <AFNetworking.h>

typedef NSString * RisingNetRequestType NS_STRING_ENUM;

typedef AFHTTPRequestSerializer * RisingNetSerializer;

NS_ASSUME_NONNULL_BEGIN

@interface RisingNetManager : NSObject

RisingSigleClass_PROPERTY(Manager);

/// Base URL
@property (nonatomic, strong) NSURL *baseURL;

/// Token
@property (nonatomic, strong) NSString *token;

- (void)dataTask:(NSString *)URLString
            type:(RisingNetRequestType)type
      serializer:(RisingNetSerializer)serializer
      parameters:(NSDictionary *)parameters
  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completion:(nullable void (^)(NSURLSessionDataTask *dataTask, id _Nullable responseObject, NSError * _Nullable error))completionHandler;

- (void)multipartForm:(NSString *)URLString
                 type:(RisingNetRequestType)requestType
           parameters:(nullable id)parameters
     constructingBody:(nullable void (^)(id<AFMultipartFormData> body))block
             progress:(nullable void (^)(NSProgress * progress))uploadProgress
           completion:(void (^)(NSURLSessionUploadTask *dataTask, id responseObject, NSError *error))completionHandler;

@end

// Request type

FOUNDATION_EXPORT RisingNetRequestType const RisingNetReuqestGET;

FOUNDATION_EXPORT RisingNetRequestType const RisingNetReuqestPOST;

FOUNDATION_EXPORT RisingNetRequestType const RisingNetReuqestDELETE;

FOUNDATION_EXPORT RisingNetRequestType const RisingNetReuqestPUT;

// Serializer

FOUNDATION_EXPORT RisingNetSerializer RisingNetSerializerJSON(void);

FOUNDATION_EXPORT RisingNetSerializer RisingNetSerializerHTTP(void);

NS_ASSUME_NONNULL_END

#endif
