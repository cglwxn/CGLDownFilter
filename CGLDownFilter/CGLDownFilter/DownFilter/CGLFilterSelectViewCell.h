//
//  CGLFilterSelectViewCell.h
//  SouFun
//
//  Created by cgl on 2019/5/25.
//  Copyright © 2019  CGL.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 十六进制颜色 */
#define UIColorMake(hex) UIColorAlphaMake(hex, 1)
/** 十六进制颜色(alpha) */
#define UIColorAlphaMake(hex, alpha) UIColorRGBAMake((hex & 0xFF0000) >> 16, (hex & 0xFF00) >> 8, hex & 0xFF, alpha)
/** RGB颜色 */
#define UIColorRGBMake(r, g, b) UIColorRGBAMake(r, g, b, 1)
/** RGB颜色(alpha) */
#define UIColorRGBAMake(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

typedef void (^FilterSelectViewCellCompletionHandler)(UILabel *label);

NS_ASSUME_NONNULL_BEGIN

@interface CGLFilterSelectViewCell : UITableViewCell

- (void)configueWithModel:(id)model filterSelectViewCellCompletionHandler:(FilterSelectViewCellCompletionHandler)filterSelectViewCellCompletionHandler;

@end

NS_ASSUME_NONNULL_END
