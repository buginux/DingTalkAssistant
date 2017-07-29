//
//  WBWifiListViewController.m
//  DingTalkAssistant
//
//  Created by buginux on 2017/7/28.
//  Copyright © 2017年 buginux. All rights reserved.
//

#import "WBWifiListViewController.h"
#import "WBWifiStore.h"
#import "WBWifiModel.h"

@interface WBWifiListViewController ()

@property (nonatomic, strong) WBWifiStore *store;

@end

@implementation WBWifiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WIFI 设置";
    
    [self.store fetchCurrentWifi];
    [self.tableView reloadData];
}

- (WBWifiStore *)store {
    if (!_store) {
        _store = [WBWifiStore new];
    }
    return _store;
}

- (NSString *)titleForSection:(NSInteger)section {
    if (section == 0) {
        return @"当前 Wifi";
    } else {
        return @"历史 Wifi";
    }
}

- (WBWifiModel *)wifiForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.store.currentWifiList[indexPath.row];
    } else {
        return self.store.historyWifiList[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSection = 0;
    
    if ([self.store.currentWifiList count] > 0) {
        numberOfSection += 1;
    }
    
    if ([self.store.historyWifiList count] > 0) {
        numberOfSection += 1;
    }
    
    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.store.currentWifiList count];
    } else if (section == 1) {
        return [self.store.historyWifiList count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    }
    
    WBWifiModel *wifi = [self wifiForRowAtIndexPath:indexPath];
    cell.textLabel.text = wifi.wifiName;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self titleForSection:section];
}

@end
