//
//  FilterListCell.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FilterListCell.h"

@interface FilterListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *inputLabel;

@end

@implementation FilterListCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self setupUI];
    [self layoutConstraints];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.inputLabel];
}

- (void)layoutConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).mas_offset(15);
        make.top.equalTo(self.contentView).mas_offset(10);
        make.trailing.equalTo(self.contentView).mas_offset(-15);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(5);
    }];
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.titleLabel);
        make.top.equalTo(self.descLabel.mas_bottom).mas_offset(5);
        make.bottom.equalTo(self.contentView).mas_offset(-10);
    }];
}

- (void)configTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)configDesc:(NSString *)desc {
    self.descLabel.text = desc;
}

- (void)configInherit:(NSString *)input {
    self.inputLabel.text = [NSString stringWithFormat:@"inherit: %@", input];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UILabel *)inputLabel {
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc] init];
        _inputLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        _inputLabel.font = [UIFont systemFontOfSize:11];
    }
    return _inputLabel;
}

@end
