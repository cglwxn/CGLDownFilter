//
//  CGLTopFilter.h
//  SouFun
//
//  Created by cgl on 2019/5/26.
//  Copyright © 2019  CGL.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLFilterSelectModel.h"

/** 十六进制颜色 */
#define UIColorMake(hex) UIColorAlphaMake(hex, 1)
/** 十六进制颜色(alpha) */
#define UIColorAlphaMake(hex, alpha) UIColorRGBAMake((hex & 0xFF0000) >> 16, (hex & 0xFF00) >> 8, hex & 0xFF, alpha)
/** RGB颜色 */
#define UIColorRGBMake(r, g, b) UIColorRGBAMake(r, g, b, 1)
/** RGB颜色(alpha) */
#define UIColorRGBAMake(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
typedef NSString * CGLButtonParamaterKey;

UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeFont;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeTitle;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeTitleColor;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeSelectTitleColor;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeButtonBackGroundColor;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeEdgeInset;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeCornerRadius;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeSelectImageName;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeUnSelectImageName;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeButtonBackGroundColor;
UIKIT_EXTERN CGLButtonParamaterKey const CGLButtonAttributeSpaceBetweenTitleAndImage;

typedef void (^CGLTopFilterCompletionHandler)(NSInteger index,CGLFilterSelectModel *selectedModel);

NS_ASSUME_NONNULL_BEGIN

@interface CGLTopFilter : UIView


/**
 返回本控件

 @param frame frame(如用自动布局,可设置为CGRectZero)
 @param height 高度,必填
 @param selectItems 数据源,元素为字典,字典的key对应初始标题,value是每个标题对应的选项数组,以NSString表示
 @param paramaters 每个button参数
 @param completionHandler 选择某选项后回调
 @param superV 父视图
 @return 本控件实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                       height:(CGFloat)height
                  selectItems:(NSMutableArray <NSMutableDictionary *>*)selectItems
               itemParamaters:(NSArray<NSDictionary *>*)paramaters
            completionHandler:(CGLTopFilterCompletionHandler)completionHandler
                    superView:(UIView *)superV;


/**
 更新某个index的数据源

 @param index 某个筛选类别的index
 @param dictionary 新数据源
 */
- (void)updateDatasourceWithIndex:(NSInteger)index dictionary:(NSMutableDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
