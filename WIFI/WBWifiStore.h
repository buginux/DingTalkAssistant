//
//  WBWifiStore.h
//  DingTalkAssistant
//
//  Created by buginux on 2017/7/29.
//  Copyright © 2017年 buginux. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBWifiModel;
@interface WBWifiStore : NSObject

@property (nonatomic, strong, readonly) NSArray *currentWifiList;
@property (nonatomic, strong, readonly) NSArray *historyWifiList;

- (void)fetchCurrentWifi;

@end
