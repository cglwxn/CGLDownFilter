//
//  CGLFilterSelectView.m
//  SouFun
//
//  Created by cgl on 2019/5/25.
//  Copyright © 2019  CGL.com. All rights reserved.
//

#import "CGLFilterSelectView.h"
#import "CGLFilterSelectViewCell.h"

#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static NSString *CGLFilterSelectViewCellID = @"CGLFilterSelectViewCell.h";

@interface CGLFilterSelectView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 当前选中的indexPath */
@property (nonatomic, strong) NSIndexPath *currentSelectedIndexPath;


@end

@implementation CGLFilterSelectView

- (instancetype)initWithFrame:(CGRect)frame withSourcr:(NSArray<CGLFilterSelectModel *> *)source filterSelectViewDidSelectRowAtIndexPathHandler:(nullable FilterSelectViewDidSelectRowAtIndexPathHandler)filterSelectViewDidSelectRowAtIndexPathHandler {
    self = [super initWithFrame:frame];
    if (self) {
        _filterSelectViewDidSelectRowAtIndexPathHandler = filterSelectViewDidSelectRowAtIndexPathHandler;
        _dataSource = source.copy;
        [self addSubview:self.tableView];
        [self buildConstraints];
        [_tableView reloadData];
    }
    return self;
}

#pragma mark - private

- (void)buildConstraints {
    WS(ws)
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       __strong CGLFilterSelectView *strongSelf = ws;
       make.top.equalTo(strongSelf.mas_top).mas_offset(0);
       make.left.equalTo(strongSelf.mas_left).mas_offset(0);
       make.right.equalTo(strongSelf.mas_right).mas_offset(0);
       make.bottom.equalTo(strongSelf.mas_bottom).mas_offset(0);
   }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != self.currentSelectedIndexPath.row) {
        CGLFilterSelectModel *currentSelectedMo = self.dataSource[self.currentSelectedIndexPath.row];
        currentSelectedMo.isSelected = NO;
        
        CGLFilterSelectModel *newSelectedMo = self.dataSource[indexPath.row];
        newSelectedMo.isSelected = YES;
        
        if (self.filterSelectViewDidSelectRowAtIndexPathHandler) {
            self.filterSelectViewDidSelectRowAtIndexPathHandler(indexPath, newSelectedMo);
        }
        [tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[self.currentSelectedIndexPath,indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        [tableView endUpdates];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGLFilterSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CGLFilterSelectViewCellID];
    if (!cell) {
        cell = [[CGLFilterSelectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CGLFilterSelectViewCellID];
    }
    CGLFilterSelectModel *model = self.dataSource[indexPath.row];
    if (model.isSelected) {
        self.currentSelectedIndexPath = indexPath;
    }
    [cell configueWithModel:model filterSelectViewCellCompletionHandler:^(UILabel *label) {
        
    }];
    return cell;
}


#pragma mark - accessors

- (void)setDataSource:(NSArray<CGLFilterSelectModel *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = UIColorMake(0xFAFAFA);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
