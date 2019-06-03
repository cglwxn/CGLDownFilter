//
//  ViewController.m
//  CGLDownFilter
//
//  Created by Guanglei Cheng on 2019/6/3.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CGLTopFilter.h"

@interface ViewController ()

@property (nonatomic, strong) CGLTopFilter *topFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topFilter];
    [self buildConstraints];
}

- (void)buildConstraints {
    WS(ws)
    [self.topFilter mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(ws) strongSelf = ws;
        make.left.mas_equalTo(strongSelf.view.mas_left).mas_offset(0);
        make.top.mas_equalTo(strongSelf.view.mas_top).mas_offset(100);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
}

- (CGLTopFilter *)topFilter {
    if (!_topFilter) {
        WS(ws)
        _topFilter = [[CGLTopFilter alloc] initWithFrame:CGRectZero height:50 selectItems:@[@{@"类型":@[@"全部",@"住宅",@"别墅",@"写字楼",@"商铺"].mutableCopy}.mutableCopy,@{@"楼盘":@[@"全部"].mutableCopy}.mutableCopy].mutableCopy itemParamaters:@[@{CGLButtonAttributeFont:[UIFont systemFontOfSize:14], CGLButtonAttributeButtonBackGroundColor:UIColorMake(0xFFFFFF), CGLButtonAttributeTitle :@"", CGLButtonAttributeTitleColor: UIColorMake(0x394043),CGLButtonAttributeSelectTitleColor: UIColorMake(0x0875E7), CGLButtonAttributeCornerRadius:@(0),CGLButtonAttributeSelectImageName:@"im_search_down"},@{CGLButtonAttributeFont:[UIFont systemFontOfSize:14], CGLButtonAttributeButtonBackGroundColor:UIColorMake(0xFFFFFF), CGLButtonAttributeTitle :@"", CGLButtonAttributeTitleColor: UIColorMake(0x394043),CGLButtonAttributeSelectTitleColor: UIColorMake(0x0875E7), CGLButtonAttributeCornerRadius:@(0),CGLButtonAttributeSelectImageName:@"im_search_down"}] completionHandler:^(NSInteger index, CGLFilterSelectModel *selectedModel) {
            switch (index) {
                case 0:
                    NSLog(@"index%ld is selected,the selected title is %@",(long)index, selectedModel.title);
                    break;
                case 1:
                    NSLog(@"index%ld is selected,the selected title is %@",(long)index, selectedModel.title);
                    break;
                default:
                    break;
            }
            
        } superView:self.view];
    }
    return _topFilter;
}


@end
