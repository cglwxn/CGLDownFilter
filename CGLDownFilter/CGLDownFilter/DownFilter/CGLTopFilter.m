//
//  CGLTopFilter.m
//  SouFun
//
//  Created by cgl on 2019/5/26.
//  Copyright © 2019  CGL.com. All rights reserved.
//

#import "CGLTopFilter.h"
#import "CGLFilterSelectView.h"
#import "Masonry.h"
#import "UIButton+Helper.h"

CGLButtonParamaterKey const CGLButtonAttributeFont = @"CGLButtonAttributeFont";
CGLButtonParamaterKey const CGLButtonAttributeTitle = @"CGLButtonAttributeTitle";
CGLButtonParamaterKey const CGLButtonAttributeTitleColor = @"CGLButtonAttributeTitleColor";
CGLButtonParamaterKey const CGLButtonAttributeSelectTitleColor = @"CGLButtonAttributeSelectTitleColor";
CGLButtonParamaterKey const CGLButtonAttributeButtonBackGroundColor = @"CGLButtonAttributeButtonBackGroundColor";
CGLButtonParamaterKey const CGLButtonAttributeEdgeInset = @"CGLButtonAttributeEdgeInset";
CGLButtonParamaterKey const CGLButtonAttributeCornerRadius = @"CGLButtonAttributeCornerRadius";
CGLButtonParamaterKey const CGLButtonAttributeSelectImageName = @"CGLButtonAttributeSelectImageName";
CGLButtonParamaterKey const CGLButtonAttributeUnSelectImageName = @"CGLButtonAttributeUnSelectImageName";
CGLButtonParamaterKey const CGLButtonAttributeSpaceBetweenTitleAndImage = @"CGLButtonAttributeSpaceBetweenTitleAndImage";

@interface CGLTopFilter ()

@property (nonatomic, strong) UIView *maskBlacKView;
@property (nonatomic, strong) UIView *topTitleView;
@property (nonatomic, strong) CGLFilterSelectView *filterSelecteView;
@property (nonatomic, copy) CGLTopFilterCompletionHandler topFilterCompletionHandler;
@property (nonatomic, strong) NSMutableArray *selectItems;
@property (nonatomic, copy) NSArray *paramaters;
@property (nonatomic, copy) NSMutableArray *mansoryViewArr;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) MASConstraint *bottomCon;

@property (nonatomic, weak) UIView *theSuper;
@end

@implementation CGLTopFilter

- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat)height selectItems:(NSMutableArray <NSMutableDictionary *> *)selectItems itemParamaters:(NSArray<NSDictionary *> *)paramaters completionHandler:(CGLTopFilterCompletionHandler)completionHandler superView:(nonnull UIView *)superV {
    CGRect originFrame = frame;
    CGRect newFrame = CGRectMake(originFrame.origin.x, originFrame.origin.y, originFrame.size.width, SCREEN_HEIGHT-CGRectGetMaxY(originFrame));
    self = [super initWithFrame:newFrame];
    self.originFrame = frame;
    if (self) {
//        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
        _height = height;
        _theSuper = superV;
        _mansoryViewArr = [NSMutableArray array];
        _topFilterCompletionHandler = completionHandler;
        
        //转换模型
        for (int i = 0; i < selectItems.count; i ++) {
            NSMutableDictionary *dic = selectItems[i];
            NSMutableArray *datasource = [NSMutableArray array];
            for (int j = 0; j < ((NSArray *)(dic.allValues.firstObject)).count; j ++) {
                CGLFilterSelectModel *Mo = [[CGLFilterSelectModel alloc] init];
                NSArray *allValues = dic.allValues.firstObject;
                Mo.title = (NSString *)allValues[j];
                if (j == 0) {
                    Mo.isSelected = YES;
                }else{
                    Mo.isSelected = NO;
                }
                [datasource addObject:Mo];
            }
            [dic setObject:datasource forKey:(dic.allKeys)[0]];
        }
        _selectItems = selectItems.mutableCopy;
        _paramaters = paramaters;
        [self addSubview:self.maskBlacKView];
        [self addSubview:self.topTitleView];
        [self addSubview:self.filterSelecteView];
        [self buildConstraints];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - public

- (void)updateDatasourceWithIndex:(NSInteger)index dictionary:(NSMutableDictionary *)dictionary {
//        NSMutableDictionary *dic = _selectItems[index];
    NSMutableArray *datasource = [NSMutableArray array];
    NSArray *allValues = dictionary.allValues.firstObject;
    for (int j = 0; j < allValues.count; j ++) {
        CGLFilterSelectModel *Mo = [[CGLFilterSelectModel alloc] init];
        Mo.title = (NSString *)allValues[j];
        if (j == 0) {
            Mo.isSelected = YES;
        }else{
            Mo.isSelected = NO;
        }
        [datasource addObject:Mo];
    }
    [dictionary setObject:datasource forKey:(dictionary.allKeys)[0]];
    _selectItems[index] = dictionary;
}

#pragma mark - private

- (void)tapAction:(UITapGestureRecognizer *)tapGesR {
    [self.filterSelecteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
        
        if (self.maskBlacKView.alpha != 0) {
            self.maskBlacKView.alpha = 0;
        }
    }];
#pragma mark - 注:此处必须先移除 bottomCon
    [self.bottomCon uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_height);
    }];
    [self layoutIfNeeded];
}



- (void)buttonAction:(UIButton *)sender {
    NSInteger index = sender.tag - 1000;
    NSDictionary *itemsDic = self.selectItems[index];
    NSArray *dataSource = itemsDic.allValues[0];

    self.filterSelecteView.hidden = NO;
    self.filterSelecteView.dataSource = dataSource;
    NSDictionary *paraDic = _paramaters[index];
    
    
//    for (UIButton *button in self.mansoryViewArr) {
//        if (button != sender) {
//            if (paraDic[CGLButtonAttributeTitleColor]) {
//                [button setTitleColor:paraDic[CGLButtonAttributeTitleColor] forState:(UIControlStateNormal)];
//            }
//        }
//    }
    
    //更新约束,动画
    [self.filterSelecteView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (dataSource.count * 50 < 360) {
            make.height.mas_equalTo(dataSource.count * 50);
        }else{
            make.height.mas_equalTo(350);
        }
        
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
        if (self.maskBlacKView.alpha == 0) {
            self.maskBlacKView.alpha = 0.3;
        }
    }];
    
    WS(ws)
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        __strong CGLTopFilter *strongSelf = ws;
        strongSelf.bottomCon = make.bottom.mas_equalTo(strongSelf.theSuper.mas_bottom).mas_offset(0);
    }];
    [self layoutIfNeeded];
    
    self.filterSelecteView.filterSelectViewDidSelectRowAtIndexPathHandler = ^(NSIndexPath * _Nullable indexPath, CGLFilterSelectModel * _Nullable selectedModel) {
        __strong CGLTopFilter *strongSelf = ws;
        
        [strongSelf.filterSelecteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.1 animations:^{
            [strongSelf layoutIfNeeded];
            if (strongSelf.maskBlacKView.alpha != 0) {
                strongSelf.maskBlacKView.alpha = 0;
            }
        }];
        
#pragma mark - 注:此处必须先移除 bottomCon
        [strongSelf.bottomCon uninstall];
        [strongSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(strongSelf.height);
        }];
        [strongSelf layoutIfNeeded];
        
        
        NSString *originTitle = itemsDic.allKeys.firstObject;
        if ([selectedModel.title isEqualToString:@"全部"]) {
            if (paraDic[CGLButtonAttributeTitleColor]) {
                [sender setTitleColor:paraDic[CGLButtonAttributeTitleColor] forState:(UIControlStateNormal)];
            }
            [sender setTitle:originTitle forState:(UIControlStateNormal)];
        }else{
            if (paraDic[CGLButtonAttributeSelectTitleColor]) {
                [sender setTitleColor:paraDic[CGLButtonAttributeSelectTitleColor] forState:(UIControlStateNormal)];
            }
            [sender setTitle:selectedModel.title forState:(UIControlStateNormal)];
        }
        
        if ([sender imageForState:UIControlStateNormal] && [sender titleForState:UIControlStateNormal] && ![[sender titleForState:UIControlStateNormal] isEqualToString:@""]) {
            if (paraDic[CGLButtonAttributeSpaceBetweenTitleAndImage]) {
                [sender judgeButtonTitleAndImage:UIControlStateNormal space:((NSNumber *)paraDic[CGLButtonAttributeSpaceBetweenTitleAndImage]).floatValue];
            }else{
                [sender judgeButtonTitleAndImage:UIControlStateNormal space:0];
            }
        }
        
        if (strongSelf.topFilterCompletionHandler) {
            strongSelf.topFilterCompletionHandler(index,selectedModel);
        }
    };
}

- (void)buildConstraints {
    WS(ws)
    [self.maskBlacKView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(ws) strongSelf = ws;
        make.top.equalTo(strongSelf.mas_top).mas_offset(_height);
        make.left.equalTo(strongSelf.mas_left).mas_offset(0);
        make.right.equalTo(strongSelf.mas_right).mas_offset(0);
        make.bottom.equalTo(strongSelf.mas_bottom).mas_offset(0);
    }];
    
    [self.topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(ws) strongSelf = ws;
        make.top.equalTo(strongSelf.mas_top).mas_offset(0);
        make.left.equalTo(strongSelf.mas_left).mas_offset(0);
        make.right.equalTo(strongSelf.mas_right).mas_offset(0);
        make.height.mas_equalTo(_height);
    }];
    
    [self.filterSelecteView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(ws) strongSelf = ws;
        make.top.equalTo(strongSelf.mas_top).mas_offset(_height);
        make.left.equalTo(strongSelf.mas_left).mas_offset(0);
        make.right.equalTo(strongSelf.mas_right).mas_offset(0);
        make.height.mas_equalTo(0);
    }];
    
    if (self.mansoryViewArr.count < 2) {
        UIView *subView = [self viewWithTag:1000];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(ws) strongSelf = ws;
            make.left.equalTo(strongSelf.mas_left).mas_offset(0);
            make.top.equalTo(strongSelf.mas_top).mas_offset(0);
            make.bottom.equalTo(strongSelf.mas_bottom).mas_offset(0);
            make.right.equalTo(strongSelf.mas_right).mas_offset(0);
        }];
    }else{
        [self.mansoryViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        
        [self.mansoryViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(ws) strongSelf = ws;
            make.top.equalTo(strongSelf.mas_top).mas_offset(0);
            make.height.mas_equalTo(_height);
        }];
    }
}

- (void)resetButton:(UIButton *)button withParamaters:(NSDictionary *)paramaters {
    NSDictionary *buttonAttrDic = paramaters;
    if (buttonAttrDic[CGLButtonAttributeTitleColor]) {
        [button setTitleColor:buttonAttrDic[CGLButtonAttributeTitleColor] forState:(UIControlStateNormal)];
    }else{
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
    
    if (buttonAttrDic[CGLButtonAttributeFont]) {
        button.titleLabel.font = buttonAttrDic[CGLButtonAttributeFont];
    }else{
        button.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    
    if (buttonAttrDic[CGLButtonAttributeButtonBackGroundColor]) {
        button.backgroundColor = buttonAttrDic[CGLButtonAttributeButtonBackGroundColor];
    }else{
        button.backgroundColor = UIColorMake(0x0875E7);
    }
    
    if (buttonAttrDic[CGLButtonAttributeCornerRadius]) {
        button.layer.cornerRadius = ((NSNumber *)buttonAttrDic[CGLButtonAttributeCornerRadius]).floatValue;
    }
    
    if (buttonAttrDic[CGLButtonAttributeTitle]) {
        [button setTitle:buttonAttrDic[CGLButtonAttributeTitle] forState:(UIControlStateNormal)];
    }
    
    if (buttonAttrDic[CGLButtonAttributeSelectImageName]) {
        [button setImage:[UIImage imageNamed:buttonAttrDic[CGLButtonAttributeSelectImageName]] forState:(UIControlStateNormal)];
    }
    
    if (buttonAttrDic[CGLButtonAttributeSpaceBetweenTitleAndImage] &&([button titleForState:UIControlStateNormal] && ![[button titleForState:UIControlStateNormal] isEqualToString:@""] && [button imageForState:UIControlStateNormal])) {
        [button judgeButtonTitleAndImage:UIControlStateNormal space:((NSNumber *)buttonAttrDic[CGLButtonAttributeSpaceBetweenTitleAndImage]).floatValue];
    }
}

#pragma mark - accessors

- (UIView *)maskBlacKView {
    if (!_maskBlacKView) {
        _maskBlacKView = [[UIView alloc] initWithFrame:self.frame];
        _maskBlacKView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_maskBlacKView addGestureRecognizer:tap];
        _maskBlacKView.alpha = 0;
    }
    return _maskBlacKView;
}

- (UIView *)topTitleView {
    if (!_topTitleView) {
        _topTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        _topTitleView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < _selectItems.count; i ++) {
            NSDictionary *itemDic = _selectItems[i];
            NSDictionary *paraDic = _paramaters[i]?:_paramaters[0];
            NSString *originTitle = itemDic.allKeys[0];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self resetButton:button withParamaters:paraDic];
            button.tag = 1000 + i;
            [self addSubview:button];
            [button setTitle:originTitle forState:(UIControlStateNormal)];
            
            if ([button imageForState:UIControlStateNormal] && [button titleForState:UIControlStateNormal] && ![[button titleForState:UIControlStateNormal] isEqualToString:@""]) {
                if (paraDic[CGLButtonAttributeSpaceBetweenTitleAndImage]) {
                    [button judgeButtonTitleAndImage:UIControlStateNormal space:((NSNumber *)paraDic[CGLButtonAttributeSpaceBetweenTitleAndImage]).floatValue];
                }else{
                    [button judgeButtonTitleAndImage:UIControlStateNormal space:0];
                }
            }
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [_topTitleView addSubview:button];
            [_mansoryViewArr addObject:button];
        }
    }
    return _topTitleView;
}

- (CGLFilterSelectView *)filterSelecteView {
    if (!_filterSelecteView) {
        _filterSelecteView = [[CGLFilterSelectView alloc] initWithFrame:CGRectZero withSourcr:@[] filterSelectViewDidSelectRowAtIndexPathHandler:nil];
        _filterSelecteView.hidden = YES;
    }
    return _filterSelecteView;
}

@end
