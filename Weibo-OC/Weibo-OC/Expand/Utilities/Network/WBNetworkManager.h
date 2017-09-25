//
//  WBNetworkManager.h
//  Weibo-OC
//
//  Created by leeyii on 2017/9/25.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WBNetworkStatus) {
    WBNetworkStateUnknow  = -1,            ///< 未知
    WBNetworkStateNotReachable   = 0,      ///< 未连接
    WBNetworkStateWWAN   = 1,              ///< 2G,3G,4G
    WBNetworkStateWIFI   = 2               ///< wifi
};


@interface WBNetworkManager : NSObject

/// 请求超时时间 default 10s
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/// network status
+ (WBNetworkStatus)networkStatus;

+ (instancetype)shareInstance;

/// GET request
- (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(id)parameters
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure;

/// POST request
- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(id)parameters
                       success:(void(^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure;


@end
