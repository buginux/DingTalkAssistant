//
//  WBWifiModel.m
//  DingTalkAssistant
//
//  Created by buginux on 2017/7/29.
//  Copyright © 2017年 buginux. All rights reserved.
//

#import "WBWifiModel.h"

@interface WBWifiModel ()

@property (nonatomic, strong) NSString *BSSID;

@end

@implementation WBWifiModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _BSSID = [dictionary valueForKey:@"BSSID"];
    }
    return self;
}

- (instancetype)initWithInterfaceName:(NSString *)ifname dictionary:(NSDictionary *)dictionary {
    if (self = [self initWithDictionary:dictionary]) {
        _interfaceName = ifname;
    }
    return self;
}

- (NSString *)wifiName {
    if ([_wifiName length] == 0) {
        return self.BSSID;
    }
    return _wifiName;
}

@end
