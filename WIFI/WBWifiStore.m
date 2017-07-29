//
//  WBWifiStore.m
//  DingTalkAssistant
//
//  Created by buginux on 2017/7/29.
//  Copyright © 2017年 buginux. All rights reserved.
//

#import "WBWifiStore.h"
#import "WBWifiModel.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <netdb.h>

@interface WBWifiStore ()

@property (nonatomic, strong) NSMutableArray *internalCurrentWifiList;
@property (nonatomic, strong) NSMutableArray *internalHistoryWifiList;

@end

@implementation WBWifiStore

- (instancetype)init {
    if (self = [super init]) {
        _internalCurrentWifiList = [NSMutableArray array];
        _internalHistoryWifiList = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)currentWifiList {
    return [self.internalCurrentWifiList copy];
}

- (NSArray *)historyWifiList {
    return [self.internalHistoryWifiList copy];
}

- (void)fetchCurrentWifi {
    [self.internalCurrentWifiList removeAllObjects];
    
    CFArrayRef arrayRef = CNCopySupportedInterfaces();
    NSArray *interfaces = (__bridge NSArray *)(arrayRef);
    
    if ([interfaces count] > 0) {
        NSString *interfaceName = [interfaces firstObject];
        
        CFDictionaryRef info = CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
        NSDictionary *dictionary = (__bridge NSDictionary *)info;
        
        if (dictionary) {
            WBWifiModel *wifi = [[WBWifiModel alloc] initWithInterfaceName:interfaceName dictionary:dictionary];
            wifi.flags = [self fetchCurrentNetworkStatus];
            [self.internalCurrentWifiList addObject:wifi];
        }
    }
}

- (SCNetworkReachabilityFlags)fetchCurrentNetworkStatus {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        NSLog(@"Error. Could not receover network reachability flags.");
        return 0;
    }
    
    return flags;
}

@end
