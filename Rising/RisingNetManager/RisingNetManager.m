//
//  RisingNetManager.m
//  Rising
//
//  Created by SSR on 2022/9/17.
//

#import "RisingNetManager.h"

RisingNetRequestType const RisingNetReuqestGET = @"GET";

RisingNetRequestType const RisingNetReuqestPOST = @"POST";

RisingNetRequestType const RisingNetReuqestDELETE = @"DELETE";

RisingNetRequestType const RisingNetReuqestPUT = @"PUT";

@interface RisingNetManager ()

/// SessionManager
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation RisingNetManager

RisingSigleClass_IMPLEMENTATION(Manager)

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = AFHTTPSessionManager.manager;
        
        AFJSONResponseSerializer *JSONResponseSerializer = AFJSONResponseSerializer.serializer;
        JSONResponseSerializer.acceptableContentTypes =
        [NSSet setWithArray:
         @[@"application/json",
           @"text/json",
           @"text/javascript",
           @"text/html",
           @"text/plain",
           @"application/atom+xml",
           @"application/xml",
           @"text/xml",
           @"application/x-www-form-urlencoded"]];
        
        _manager.responseSerializer = JSONResponseSerializer;
    }
    return self;
}

- (void)dataTask:(NSString *)URLString
            type:(RisingNetRequestType)type
      serializer:(RisingNetSerializer)serializer
      parameters:(NSDictionary *)parameters
  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completion:(nullable void (^)(NSURLSessionDataTask *dataTask, id _Nullable responseObject, NSError * _Nullable error))completionHandler {
    
    _manager.requestSerializer = serializer;
    
    NSMutableURLRequest *request = [serializer requestWithMethod:type URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [_manager dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse * __unused response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(dataTask, responseObject, error);
        }
    }];
    
    [dataTask resume];
}

- (void)multipartForm:(NSString *)URLString
                 type:(RisingNetRequestType)requestType
           parameters:(nullable id)parameters
     constructingBody:(nullable void (^)(id<AFMultipartFormData> body))block
             progress:(nullable void (^)(NSProgress * progress))uploadProgress
           completion:(void (^)(NSURLSessionUploadTask *dataTask, id responseObject, NSError *error))completionHandler {
    
    _manager.requestSerializer = RisingNetSerializerJSON();
        
    NSMutableURLRequest *request = [_manager.requestSerializer multipartFormRequestWithMethod:requestType URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    __block NSURLSessionUploadTask *task = nil;
    
    task = [_manager uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (completionHandler) {
            completionHandler(task, responseObject, error);
        }
    }];
    
    [task resume];
}

@end

RisingNetSerializer RisingNetSerializerJSON(void) {
    static AFJSONRequestSerializer *jsonRequestWerializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsonRequestWerializer = AFJSONRequestSerializer.serializer;
        jsonRequestWerializer.timeoutInterval = 15;
        jsonRequestWerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[]];
    });
    if (RisingNetManager.shareManager.token) {
        [jsonRequestWerializer setValue:[NSString stringWithFormat:@"Bearer %@",RisingNetManager.shareManager.token] forHTTPHeaderField:@"Authorization"];
    }
    return jsonRequestWerializer;
}

RisingNetSerializer RisingNetSerializerHTTP(void) {
    static AFHTTPRequestSerializer *httpRequestWerializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequestWerializer = AFHTTPRequestSerializer.serializer;
        httpRequestWerializer.timeoutInterval = 15;
    });
    if (RisingNetManager.shareManager.token) {
        [httpRequestWerializer setValue:[NSString stringWithFormat:@"Bearer %@",RisingNetManager.shareManager.token] forHTTPHeaderField:@"Authorization"];
    }
    return httpRequestWerializer;
}
