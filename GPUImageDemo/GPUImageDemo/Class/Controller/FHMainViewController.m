//
//  MainViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHMainViewController.h"
#import "FHFilterListViewController.h"
#import "FHFetchCategoryFiltersTool.h"
#import "MJExtension.h"
#import "FHFilterListItem.h"


static NSString *const kMainCellIdentifier = @"kMainCellIdentifier";

static NSString *const kFilterCategoryColorAdjustments = @"Color Adjustments";
static NSString *const kFilterCategoryImageProcessing = @"Image Processing";
static NSString *const kFilterCategoryBlendingModes = @"Blending Modes";
static NSString *const kFilterCategoryVisualEffects = @"Visual Effects";

static NSString *const kCustomFilterSplit = @"Custom";

@interface FHMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation FHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configDatas];
    [self configNavigation];
    [self setupUI];
}

- (void)configDatas {
    self.dataList = @[
                      @{
                          @"title": @"GPUImage Filters",
                          @"content" : @[kFilterCategoryColorAdjustments,
                                         kFilterCategoryImageProcessing,
                                         kFilterCategoryBlendingModes,
                                         kFilterCategoryVisualEffects],
                        },
                      @{
                          @"title": @"Custom Filters",
                          @"content": @[kCustomFilterSplit,
                                  ],
                          }
                    ];
}

- (void)configNavigation {
    self.navigationItem.title = @"GPUImage学习";
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
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dictInfo = self.dataList[section];
    NSArray *listArr = dictInfo[@"content"];
    return listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMainCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kMainCellIdentifier];
    }
    
    NSDictionary *info = self.dataList[indexPath.section];
    NSArray *contentInfo = info[@"content"];
    NSString *content = contentInfo[indexPath.row];
    cell.textLabel.text = content;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *info = self.dataList[section];
    NSString *sectionTitle = info[@"title"];
    return sectionTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *info = self.dataList[indexPath.section];
    NSString *cellTitle = info[@"content"][indexPath.row];
    if (indexPath.section == 0) {
        [self filtersSectionJumpToVcWithCellTitle:cellTitle];
    } else if (indexPath.section == 1) {
        [self customFiltersSectionJumpToVcWithCellTitle:cellTitle];
    }
}

#pragma mark - private
- (void)filtersSectionJumpToVcWithCellTitle:(NSString *)title {
    FHFilterListViewController *vc = [[FHFilterListViewController alloc] init];
    if ([title isEqualToString:kFilterCategoryColorAdjustments]) {
        vc.dataList = [FHFilterListItem mj_objectArrayWithKeyValuesArray:[FHFetchCategoryFiltersTool colorAdjustmentsFilters]];
    } else if ([title isEqualToString:kFilterCategoryImageProcessing]) {
        vc.dataList = [FHFilterListItem mj_objectArrayWithKeyValuesArray:[FHFetchCategoryFiltersTool imageProcessingFilters]];
    } else if ([title isEqualToString:kFilterCategoryBlendingModes]) {
        vc.dataList = [FHFilterListItem mj_objectArrayWithKeyValuesArray:[FHFetchCategoryFiltersTool blendingModesFilters]];
    } else if ([title isEqualToString:kFilterCategoryVisualEffects]) {
        vc.dataList = [FHFilterListItem mj_objectArrayWithKeyValuesArray:[FHFetchCategoryFiltersTool visualEffectsFilters]];
    }
    vc.navigationItem.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customFiltersSectionJumpToVcWithCellTitle:(NSString *)title {
    FHFilterListViewController *vc = [[FHFilterListViewController alloc] init];
    vc.dataList = [FHFilterListItem mj_objectArrayWithKeyValuesArray:[FHFetchCategoryFiltersTool customFilters]];
    vc.navigationItem.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
