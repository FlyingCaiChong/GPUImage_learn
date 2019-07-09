//
//  MainViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "MainViewController.h"

static NSString *const kMainCellIdentifier = @"kMainCellIdentifier";

static NSString *const kFilterCategoryColorAdjustments = @"Color adjustments";
static NSString *const kFilterCategoryImageProcessing = @"Image Processing";
static NSString *const kFilterCategoryBlendingModes = @"Blending modes";
static NSString *const kFilterCategoryVisualEffects = @"Visual effects";

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configDatas];
    [self configNavigation];
    [self setupUI];
}

- (void)configDatas {
    self.dataList = @[
                      @{
                          @"title" : @"filters",
                          @"content" : @[kFilterCategoryColorAdjustments,
                                         kFilterCategoryImageProcessing,
                                         kFilterCategoryBlendingModes,
                                         kFilterCategoryVisualEffects],
                        },
                    ];
}

- (void)configNavigation {
    self.navigationItem.title = @"GPUImage学习";
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = self.view.bounds;
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
    if (indexPath.section == 0) {
        NSDictionary *info = self.dataList[indexPath.section];
        NSString *cellTitle = info[@"content"][indexPath.row];
        [self filtersSectionJumpToVcWithCellTitle:cellTitle];
    }
}

#pragma mark - private
- (void)filtersSectionJumpToVcWithCellTitle:(NSString *)title {
    if ([title isEqualToString:kFilterCategoryColorAdjustments]) {
        // TODO: jump to color adjustments vc
    } else if ([title isEqualToString:kFilterCategoryImageProcessing]) {
        // TODO: jump to image processing vc
    } else if ([title isEqualToString:kFilterCategoryBlendingModes]) {
        // TODO: jump to blending modes vc
    } else if ([title isEqualToString:kFilterCategoryVisualEffects]) {
        // TODO: jump to visual effects vc
    }
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
