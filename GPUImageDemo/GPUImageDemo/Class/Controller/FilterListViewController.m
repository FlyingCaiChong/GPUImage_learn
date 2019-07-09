//
//  ColorAdjustmentsViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FilterListViewController.h"
#import "FilterListCell.h"

static NSString *const kColorAdjustmentsCellIdentifier = @"kColorAdjustmentsCellIdentifier";

@interface FilterListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FilterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterListCell *cell = [tableView dequeueReusableCellWithIdentifier:[FilterListCell cellIdentifier] forIndexPath:indexPath];
    
    NSDictionary *info = self.dataList[indexPath.row];
    [cell configTitle:info[@"title"]];
    [cell configDesc:info[@"desc"]];
    [cell configInherit:info[@"inherit"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[FilterListCell class] forCellReuseIdentifier:[FilterListCell cellIdentifier]];
    }
    return _tableView;
}

@end
