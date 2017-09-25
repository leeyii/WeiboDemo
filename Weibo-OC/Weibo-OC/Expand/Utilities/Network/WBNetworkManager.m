//
//  WBNetworkManager.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/25.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "WBNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface WBNetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *afSessionManager;

@end

@implementation WBNetworkManager

static WBNetworkManager *_shareInstance;
static WBNetworkStatus   _status;

+ (WBNetworkStatus)networkStatus {
    if (!_shareInstance) {
        [WBNetworkManager shareInstance];
    }
    return _status;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[WBNetworkManager alloc] init];
        
        // monitor network state
        AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
        [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _status = (WBNetworkStatus)status;
        }];
        [reachability startMonitoring];
        
        _shareInstance.timeoutInterval = 20;
        
        // init AFHTTPSessionManager
        _shareInstance.afSessionManager = [AFHTTPSessionManager manager];
        _shareInstance.afSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        
        _shareInstance.afSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareInstance.afSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        
        _shareInstance.afSessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
    });
    return _shareInstance;
}


- (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure
{
    self.afSessionManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    NSURLSessionDataTask *task = [_afSessionManager GET:url
                                             parameters:parameters
                                               progress:nil
                                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                  {
                                      success(responseObject);
                                  }
                                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                  {
                                      failure(error);
                                  }];
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(id)parameters
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure
{
    self.afSessionManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    NSURLSessionDataTask *task = [_afSessionManager POST:url
                                              parameters:parameters
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                  {
                                      success(responseObject);
                                  }
                                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                  {
                                      failure(error);
                                  }];
    return task;
}

@end
