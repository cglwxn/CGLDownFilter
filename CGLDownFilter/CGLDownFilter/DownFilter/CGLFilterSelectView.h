//
//  CGLFilterSelectView.h
//  SouFun
//
//  Created by cgl on 2019/5/25.
//  Copyright © 2019  CGL.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLFilterSelectModel.h"

typedef void (^FilterSelectViewDidSelectRowAtIndexPathHandler)(NSIndexPath * _Nullable indexPath, CGLFilterSelectModel * _Nullable selectedModel);

NS_ASSUME_NONNULL_BEGIN

@interface CGLFilterSelectView : UIView


/**
 初始化方法

 @param frame frame
 @param source 数据源,成员为CGLFilterSelectModel的数组
 @param filterSelectViewDidSelectRowAtIndexPathHandler 回调
 @return 返回实例化
 */
- (instancetype)initWithFrame:(CGRect)frame withSourcr:(NSArray <CGLFilterSelectModel *>*)source filterSelectViewDidSelectRowAtIndexPathHandler:(nullable FilterSelectViewDidSelectRowAtIndexPathHandler)filterSelectViewDidSelectRowAtIndexPathHandler;

/** 点击某个筛选项后回调 */
@property (nonatomic, copy) FilterSelectViewDidSelectRowAtIndexPathHandler filterSelectViewDidSelectRowAtIndexPathHandler;

/** 数据源 */
@property (nonatomic, strong) NSArray <CGLFilterSelectModel *>*dataSource;

@end

NS_ASSUME_NONNULL_END
