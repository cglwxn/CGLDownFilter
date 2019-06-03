//
//  CGLFilterSelectViewCell.m
//  SouFun
//
//  Created by Guanglei Cheng on 2019/5/25.
//  Copyright © 2019 房天下 CGL.com. All rights reserved.
//

#import "CGLFilterSelectViewCell.h"
//#import "UILabel+CGLLabel.h"
#import "CGLFilterSelectModel.h"



@interface CGLFilterSelectViewCell ()

@property (nonatomic, strong) UILabel *selectTitleLabel;
@property (nonatomic, copy) FilterSelectViewCellCompletionHandler filterSelectViewCellCompletionHandler;
@end

@implementation CGLFilterSelectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.selectTitleLabel];
    }
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

- (void)layoutSubviews {
    self.selectTitleLabel.frame = self.contentView.bounds;
    [super layoutSubviews];
}

#pragma mark - private

- (void)configueWithModel:(id)model filterSelectViewCellCompletionHandler:(nonnull FilterSelectViewCellCompletionHandler)filterSelectViewCellCompletionHandler {
    CGLFilterSelectModel *mo = model;
    _selectTitleLabel.text = mo.title;
    _selectTitleLabel.textColor = mo.isSelected ? UIColorMake(0x0875E7):UIColorMake(0x394043);
    self.filterSelectViewCellCompletionHandler = filterSelectViewCellCompletionHandler;
}

- (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

#pragma mark - accessors

- (UILabel *)selectTitleLabel {
    if (!_selectTitleLabel) {
        _selectTitleLabel = [self labelWithFrame:CGRectZero text:@"" font:[UIFont systemFontOfSize:16] textColor:UIColorMake(0x0875E7) textAlignment:(NSTextAlignmentCenter)];
    }
    return _selectTitleLabel;
}

@end
