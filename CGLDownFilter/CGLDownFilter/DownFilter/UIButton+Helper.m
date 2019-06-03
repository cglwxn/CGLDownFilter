//
//  UIViewController+Helper.m
//  CGLDownFilter
//
//  Created by cgl on 2019/6/3.
//  Copyright © 2019 cgl. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)

- (void)judgeButtonTitleAndImage:(UIControlState)state space:(CGFloat)space {
    NSString *title = [self titleForState:state];
    UIFont *font = self.titleLabel.font;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGSize maxSize = CGSizeMake(screenBounds.size.width, font.pointSize + 3);
    CGFloat titleW = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    UIImage *image = [self imageForState:state];
    CGFloat imgW  = image.size.width;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW+space/2.0), 0, (imgW+space/2.0));
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2.0, 0, -titleW-space/2.0);
}

@end
