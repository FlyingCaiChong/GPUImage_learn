//
//  ColorAdjustmentsViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHFilterListViewController.h"
#import "FHFilterListCell.h"
#import "FHFilterListItem.h"
#import "FHShowViewController+Private.h"
#import "FHShowBlendViewController+Private.h"

static NSString *const kColorAdjustmentsCellIdentifier = @"kColorAdjustmentsCellIdentifier";

@interface FHFilterListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BlendShowType _blendShowType;
    ShowType _showType;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FHFilterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _showType = ShowTypeImage;
    _blendShowType = BlendShowTypeImage;
    
    [self setupUI];
    [self initNavi];
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

- (void)initNavi {
    [self setRightItemTitle:@"Image"];
}

- (void)rightItemClick {
    NSString *itemTitle = self.navigationItem.rightBarButtonItem.title;
    if ([itemTitle isEqualToString:@"Image"]) {
        // Image -> Camera
        [self setRightItemTitle:@"Camera"];
        _showType = ShowTypeCamera;
        _blendShowType = BlendShowTypeCamera;
    } else {
        // Camera -> Image
        [self setRightItemTitle:@"Image"];
        _showType = ShowTypeImage;
        _blendShowType = BlendShowTypeImage;
    }
}

- (void)setRightItemTitle:(NSString *)title {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemClick)];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FHFilterListCell *cell = [tableView dequeueReusableCellWithIdentifier:[FHFilterListCell cellIdentifier] forIndexPath:indexPath];
    
    FHFilterListItem *item = self.dataList[indexPath.row];
    [cell configTitle:item.title];
    [cell configDesc:item.desc];
    [cell configInherit:item.inherit];
    [cell configTranslate:item.translate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FHFilterListItem *item = self.dataList[indexPath.row];
    
    if ([self.navigationItem.title isEqualToString:@"Blending Modes"]) {
        FHShowBlendViewController *blendVc = [[FHShowBlendViewController alloc] init];
        blendVc.type = _blendShowType;
        blendVc.item = item;
        blendVc.navigationItem.title = item.title;
        [self.navigationController pushViewController:blendVc animated:YES];
    } else {
        FHShowViewController *showVc = [[FHShowViewController alloc] init];
        showVc.type = _showType;
        showVc.item = item;
        showVc.navigationItem.title = item.title;
        [self.navigationController pushViewController:showVc animated:YES];
    }
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[FHFilterListCell class] forCellReuseIdentifier:[FHFilterListCell cellIdentifier]];
    }
    return _tableView;
}

@end
